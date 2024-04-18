import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:decimal/decimal.dart';
import 'package:epicpay/models/send_view_auto_fill_data.dart';
import 'package:epicpay/pages/send_view/send_amount_view.dart';
import 'package:epicpay/pages/send_view/send_view.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/providers/ui/home_view_index_provider.dart';
import 'package:epicpay/services/coins/epiccash/epiccash_wallet.dart';
import 'package:epicpay/utilities/barcode_scanner_interface.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

SendViewAutoFillData? parseQr(
  String content,
  String currentEpicBoxServer,
  bool Function(String) validateAddress,
) {
  SendViewAutoFillData? data;

  final threeParts = content.split("*");

  if (threeParts.length != 3) {
    throw Exception("Invalid Payment Code");
  }

  final address = threeParts[0];
  final onChainNote = threeParts[1];
  final amountString = threeParts[2];

  if (!validateAddress(address)) {
    throw Exception("Invalid Address");
  }

  String? epicboxServer;
  try {
    epicboxServer = address.split("@")[1];
  } catch (_) {
    // do nothing
  }
  if (epicboxServer == null) {
    throw Exception("Missing EpicBox Server");
  }
  String? overrideEpicboxServer;
  if (epicboxServer != currentEpicBoxServer) {
    overrideEpicboxServer = epicboxServer;
  }

  final amount = Decimal.parse(amountString);

  data = SendViewAutoFillData(
    address: address,
    contactLabel: address,
    onChainNote: onChainNote,
    amount: amount,
    pay: true,
    overrideEpicBoxServer: overrideEpicboxServer,
  );

  return data;
}

Future<void> scan(
  WidgetRef ref,
  BuildContext context,
  BarcodeScannerInterface scanner,
) async {
  final qrResult = await scanner.scan();

  if (qrResult.type == ResultType.Cancelled) {
    ref.read(homeViewPageIndexStateProvider.state).state =
        ref.read(prevHomeViewPageIndexStateProvider.state).state;
    return;
  }

  try {
    final currentEpicBoxConfig =
        await (ref.read(walletProvider)!.wallet as EpicCashWallet)
            .getEpicBoxConfig();
    final data = parseQr(
      qrResult.rawContent,
      currentEpicBoxConfig.host,
      ref.read(walletProvider)!.validateAddress,
    );

    ref.read(sendViewFillDataProvider.state).state = data;
    if (context.mounted) {
      await Navigator.of(context).pushNamed(
        SendAmountView.routeName,
        arguments: Tuple3(
          ref.read(walletProvider)!.walletId,
          data!.address,
          Coin.epicCash,
        ),
      );
    }
  } catch (e) {
    // show error dialog with options: cancel, retry

    bool? retry;

    if (context.mounted) {
      retry = await showDialog<bool?>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius * 2),
            ),
            backgroundColor:
                Theme.of(context).extension<StackColors>()!.popupBG,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius * 2),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Error",
                      style: STextStyles.titleH3(context).copyWith(
                        fontSize: 18,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      e.toString(),
                      style: STextStyles.overLineBold(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              label: "RETRY",
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SecondaryButton(
                              label: "CANCEL",
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    // on retry, reopen scanner
    if (retry == true && context.mounted) {
      return await scan(ref, context, scanner);
    } else {
      // on cancel
      ref.read(homeViewPageIndexStateProvider.state).state =
          ref.read(prevHomeViewPageIndexStateProvider.state).state;
    }
  }
}

class PayView extends ConsumerStatefulWidget {
  const PayView({
    Key? key,
    required this.walletId,
    required this.coin,
    this.barcodeScanner = const BarcodeScannerWrapper(),
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/payView";

  final String walletId;
  final Coin coin;

  final BarcodeScannerInterface barcodeScanner;
  final ClipboardInterface? clipboard;

  @override
  ConsumerState<PayView> createState() => _PayViewState();
}

class _PayViewState extends ConsumerState<PayView> {
  late final String walletId;
  late final Coin coin;
  late final BarcodeScannerInterface scanner;

  @override
  void initState() {
    walletId = widget.walletId;
    coin = widget.coin;
    scanner = widget.barcodeScanner;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await scan(ref, context, scanner);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    return Scaffold(
      backgroundColor: Theme.of(context).extension<StackColors>()!.background,
      body: LayoutBuilder(
        builder: (builderContext, constraints) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 12,
              right: 12,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // subtract top and bottom padding set in parent
                  minHeight: constraints.maxHeight - 24,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
