import 'dart:async';

import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/pages/buy_view/confirm_crypto_buy_view.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/pages/send_view/send_view.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:epicpay/utilities/address_utils.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/barcode_scanner_interface.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/icon_widgets/qrcode_icon.dart';
import 'package:epicpay/widgets/icon_widgets/x_icon.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/textfield_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';

class BuyRefundAddressEntry extends ConsumerStatefulWidget {
  const BuyRefundAddressEntry({
    super.key,
    required this.option,
    required this.estimate,
  });

  final CryptoBuyOption option;
  final Estimate estimate;

  static const routeName = "/buyRefundAddressEntry";

  @override
  ConsumerState<BuyRefundAddressEntry> createState() =>
      _BuyRefundAddressEntryState();
}

class _BuyRefundAddressEntryState extends ConsumerState<BuyRefundAddressEntry> {
  final TextEditingController controller = TextEditingController();
  final _addressFocusNode = FocusNode();

  String? _address;
  bool _addressToggleFlag = false;

  bool _getAQuoteLock = false;
  Future<void> _getTrade() async {
    if (_getAQuoteLock) {
      return;
    }
    _getAQuoteLock = true;

    try {
      const timeout = Duration(seconds: 5);

      final address = await ref.read(walletProvider)!.currentReceivingAddress;

      final epic = ref
          .read(pIsarDB)
          .isar
          .currencies
          .filter()
          .exchangeNameEqualTo(ChangeNowExchange.exchangeName)
          .tickerEqualTo("epic")
          .and()
          .networkEqualTo("epic")
          .and()
          .nameEqualTo("EpicCash")
          .findFirstSync();

      final resultFuture = ChangeNowExchange.instance
          .createTrade(
            from: widget.option.currency!,
            to: epic!,
            fixedRate: false,
            amount: widget.estimate.fromAmount,
            estimate: widget.estimate,
            addressTo: address,
            addressRefund: _address!,
            refundExtraId: "",
            reversed: false,
            zBuy: true,
          )
          .timeout(
            timeout,
            onTimeout: () => ExchangeResponse(
              value: null,
              exception: ExchangeException("Get Quote timeout"),
            ),
          );

      if (mounted) {
        final result = await showLoading(
          whileFuture: resultFuture,
          context: context,
          delay: const Duration(seconds: 1),
          timeout: timeout,
        );

        if (mounted) {
          if (result == null) {
            unawaited(
              showDialog<void>(
                context: context,
                builder: (context) => const EPErrorDialog(
                  title: "Unknown error",
                  info: "showLoading result should never be null",
                ),
              ),
            );
            return;
          }

          if (result.exception != null) {
            unawaited(
              showDialog<void>(
                context: context,
                builder: (context) => EPErrorDialog(
                  title: "Buy error",
                  info: result.exception!.message,
                ),
              ),
            );
            return;
          }

          if (result.value != null) {
            await ref.read(pIsarDB).isar.writeTxn(() async {
              await ref.read(pIsarDB).isar.trades.put(result.value!);
            });
            if (mounted) {
              await Navigator.of(context).pushNamed(
                ConfirmCryptoBuyView.routeName,
                arguments: result.value!,
              );
            }
          }
        }
      }
    } finally {
      _getAQuoteLock = false;
    }
  }

  @override
  void dispose() {
    _addressFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarIconButton(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF222227),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.svg.arrowLeft,
                  width: 24,
                  height: 24,
                  color: Theme.of(context).extension<StackColors>()!.textMedium,
                ),
              ),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Enter ${widget.option.ticker} refund address",
                        textAlign: TextAlign.center,
                        style: STextStyles.titleH3(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedWhiteContainer(
                        child: Text(
                          "Required. "
                          "In case something goes wrong during the exchange, "
                          "ChangeNOW may need a refund address so your "
                          "coins can be returned to you.",
                          style: STextStyles.w400_12_18h(context),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedContainer(
                        color: Theme.of(context).extension<StackColors>()!.coal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                key: const Key(
                                  "buyRefundAddressFieldKey",
                                ),
                                controller: controller,
                                readOnly: false,
                                autocorrect: false,
                                enableSuggestions: false,
                                focusNode: _addressFocusNode,
                                style: STextStyles.body(context),
                                maxLines: 1,
                                onChanged: (newValue) {
                                  _address = newValue;

                                  setState(() {
                                    _addressToggleFlag =
                                        _address?.isNotEmpty == true;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Paste address...",
                                  hintStyle: STextStyles.body(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .textMedium,
                                  ),
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  focusColor: Colors.transparent,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                ),
                              ),
                            ),
                            _addressToggleFlag
                                ? TextFieldIconButton(
                                    key: const Key(
                                      "buyViewClearAddressFieldButtonKey",
                                    ),
                                    onTap: () {
                                      controller.text = "";
                                      _address = "";
                                      setState(() {
                                        _addressToggleFlag = false;
                                      });
                                    },
                                    child: const XIcon(),
                                  )
                                : TextFieldIconButton(
                                    key: const Key(
                                      "buyViewPasteAddressFieldButtonKey",
                                    ),
                                    onTap: () async {
                                      final ClipboardData? data =
                                          await Clipboard.getData(
                                        Clipboard.kTextPlain,
                                      );
                                      if (data?.text != null &&
                                          data!.text!.isNotEmpty) {
                                        String content = data.text!.trim();
                                        if (content.contains("\n")) {
                                          content = content.substring(
                                              0, content.indexOf("\n"));
                                        }
                                        content = formatAddress(content);

                                        controller.text = content;
                                        _address = content;

                                        setState(() {
                                          _addressToggleFlag =
                                              controller.text.isNotEmpty;
                                        });
                                      }
                                    },
                                    child: controller.text.isEmpty
                                        ? SvgPicture.asset(
                                            Assets.svg.paste,
                                            width: 24,
                                            height: 24,
                                          )
                                        : const XIcon(),
                                  ),
                            TextFieldIconButton(
                              key: const Key("buyViewScanQrButtonKey"),
                              onTap: () async {
                                try {
                                  if (FocusScope.of(context).hasFocus) {
                                    FocusScope.of(context).unfocus();
                                    await Future<void>.delayed(
                                      const Duration(milliseconds: 75),
                                    );
                                  }

                                  final qrResult =
                                      await const BarcodeScannerWrapper()
                                          .scan();

                                  Logging.instance.log(
                                    "qrResult content: ${qrResult.rawContent}",
                                    level: LogLevel.Info,
                                  );

                                  final results = AddressUtils.parseUri(
                                    qrResult.rawContent,
                                  );

                                  Logging.instance.log(
                                    "qrResult parsed: $results",
                                    level: LogLevel.Info,
                                  );

                                  if (results.isNotEmpty &&
                                      results["scheme"] == "epic") {
                                    // auto fill address
                                    _address = results["address"] ?? "";
                                    controller.text = _address!;

                                    setState(() {
                                      _addressToggleFlag =
                                          controller.text.isNotEmpty;
                                    });

                                    // now check for non standard encoded basic address
                                  } else {
                                    _address = qrResult.rawContent;
                                    controller.text = _address ?? "";

                                    setState(() {
                                      _addressToggleFlag =
                                          controller.text.isNotEmpty;
                                    });
                                  }
                                } on PlatformException catch (e, s) {
                                  // here we ignore the exception caused by not giving permission
                                  // to use the camera to scan a qr code
                                  Logging.instance.log(
                                    "Failed to get camera permissions while trying to scan qr code in Buy flow: $e\n$s",
                                    level: LogLevel.Warning,
                                  );
                                }
                              },
                              child: const QrCodeIcon(),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: "NEXT",
                        enabled: _address?.isNotEmpty == true,
                        onPressed: _getTrade,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
