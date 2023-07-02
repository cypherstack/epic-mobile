import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/models/models.dart';
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/dialogs/cancelling_transaction_progress_dialog.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/services/coins/epiccash/epiccash_wallet.dart';
import 'package:epicpay/services/coins/manager.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailsView extends ConsumerStatefulWidget {
  const TransactionDetailsView({
    Key? key,
    required this.transaction,
    required this.walletId,
    required this.coin,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/transactionDetails";

  final Transaction transaction;
  final String walletId;
  final Coin coin;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<TransactionDetailsView> createState() =>
      _TransactionDetailsViewState();
}

class _TransactionDetailsViewState
    extends ConsumerState<TransactionDetailsView> {
  static const double maxDivHeight = 51;
  static const double minDivHeight = 5;
  final _key = GlobalKey();

  late final TextEditingController noteController;
  late Transaction _transaction;
  late final String walletId;

  late final ClipboardInterface clipboard;

  late final Coin coin;
  late final Decimal amount;
  late final Decimal fee;

  bool showFeePending = false;

  late final bool isSent;
  late final int divCount;
  double divHeight = maxDivHeight;
  double? layoutBuilderHeight;
  Size? size;

  double _getInRange(double value) {
    if (value < minDivHeight) {
      return minDivHeight;
    } else if (value > maxDivHeight) {
      return maxDivHeight;
    } else {
      return value;
    }
  }

  void _setSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      size = _key.currentContext?.size;

      if (layoutBuilderHeight != null && size != null) {
        if (layoutBuilderHeight! < size!.height) {
          final diff = size!.height - layoutBuilderHeight!;
          final dDiff = diff / divCount;
          divHeight = _getInRange(divHeight - dDiff);
        } else {
          final diff = layoutBuilderHeight! - size!.height;
          final dDiff = diff / divCount;
          divHeight = _getInRange(divHeight + dDiff);
        }
      }

      setState(() {});
    });
  }

  Widget whatIsIt(String type) {
    Color color;
    String label;
    print("THIS TRANSACTION IS $_transaction");
    if (_transaction.isCancelled) {
      color = Theme.of(context).extension<StackColors>()!.accentColorRed;
      label = "Cancelled";
    } else if (type == "Received") {
      if (_transaction.confirmedStatus) {
        color = Theme.of(context).extension<StackColors>()!.accentColorGreen;
        label = "Received";
      } else {
        if (_transaction.numberOfMessages == 1) {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label = "Receiving (waiting for sender)";
        } else if ((_transaction.numberOfMessages ?? 0) > 1) {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label =
              "Receiving (waiting for confirmations)"; // TODO test if the sender still has to open again after the receiver has 2 messages present, ie. sender->receiver->sender->node (yes) vs. sender->receiver->node (no)
        } else {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label = "Receiving";
        }
      }
    } else if (type == "Sent") {
      if (_transaction.confirmedStatus) {
        color = Theme.of(context).extension<StackColors>()!.accentColorGreen;
        label = "Sent (confirmed)";
      } else {
        if (_transaction.numberOfMessages == 1) {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label = "Sending (waiting for receiver)";
        } else if ((_transaction.numberOfMessages ?? 0) > 1) {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label = "Sending (waiting for confirmations)";
        } else {
          color = Theme.of(context).extension<StackColors>()!.accentColorYellow;
          label = "Sending";
        }
      }
    } else {
      color = Theme.of(context).extension<StackColors>()!.textLight;
      label = type;
    }

    return Text(
      label,
      style: STextStyles.body(context).copyWith(
        color: color,
      ),
    );
  }

  Future<String> fetchContactNameFor(String address) async {
    // if (address.isEmpty) {
    //   return address;
    // }
    // try {
    // final contacts = ref.read(addressBookServiceProvider).contacts.where(
    //     (element) => element.addresses
    //         .where((element) => element.address == address)
    //         .isNotEmpty);
    // if (contacts.isNotEmpty) {
    //   return contacts.first.name;
    // } else {
    return address;
    // }
    // } catch (e, s) {
    //   Logging.instance.log("$e\n$s", level: LogLevel.Warning);
    //   return address;
    // }
  }

  Future<bool> showExplorerWarning(String explorer) async {
    final bool? shouldContinue = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => StackDialog(
        title: "Attention",
        message:
            "You are about to view this transaction in a block explorer. The explorer may log your IP address and link it to the transaction. Only proceed if you trust $explorer.",
        icon: Row(
          children: [
            Consumer(builder: (_, ref, __) {
              return Checkbox(
                value: ref.watch(prefsChangeNotifierProvider
                    .select((value) => value.hideBlockExplorerWarning)),
                onChanged: (value) {
                  if (value is bool) {
                    ref
                        .read(prefsChangeNotifierProvider)
                        .hideBlockExplorerWarning = value;
                    setState(() {});
                  }
                },
              );
            }),
            Text(
              "Never show again",
              style: STextStyles.smallMed14(context),
            )
          ],
        ),
        leftButton: TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            "Cancel",
            style: STextStyles.buttonText(context).copyWith(
                color: Theme.of(context)
                    .extension<StackColors>()!
                    .accentColorDark),
          ),
        ),
        rightButton: TextButton(
          style: Theme.of(context)
              .extension<StackColors>()!
              .getPrimaryEnabledButtonColor(context),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Continue",
            style: STextStyles.buttonText(context),
          ),
        ),
      ),
    );
    return shouldContinue ?? false;
  }

  Future<void> _onCancelPressed() async {
    final Manager manager = ref.read(walletProvider)!;

    if (manager.wallet is EpicCashWallet) {
      final String? id = _transaction.slateId;
      if (id == null) {
        // unawaited(showFloatingFlushBar(
        //   type: FlushBarType.warning,
        //   message: "Could not find Epic transaction ID",
        //   context: context,
        // ));
        return;
      }

      unawaited(showDialog<dynamic>(
        barrierDismissible: false,
        context: context,
        builder: (_) => const CancellingTransactionProgressDialog(),
      ));

      final result = await manager.cancelPendingTransaction(id);
      if (mounted) {
        // pop progress dialog
        Navigator.of(context).pop();

        if (result.isEmpty) {
          await showDialog<dynamic>(
            context: context,
            builder: (_) => OkDialog(
              title: "Transaction cancelled",
              onOkPressed: (_) {
                manager.refresh();
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeView.routeName));
              },
            ),
          );
        } else {
          await showDialog<dynamic>(
            context: context,
            builder: (_) => OkDialog(
              title: "Failed to cancel transaction",
              message: result,
            ),
          );
        }
      }
    } else {
      // unawaited(showFloatingFlushBar(
      //   type: FlushBarType.warning,
      //   message: "ERROR: Wallet type is not Epic Cash",
      //   context: context,
      // ));
      return;
    }
  }

  @override
  void initState() {
    noteController = TextEditingController();
    _transaction = widget.transaction;
    walletId = widget.walletId;
    clipboard = widget.clipboard;

    coin = widget.coin;
    amount = Format.satoshisToAmount(_transaction.amount, coin: coin);
    fee = Format.satoshisToAmount(_transaction.fees, coin: coin);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      noteController.text = await ref
          .read(notesServiceChangeNotifierProvider(walletId))
          .getNoteFor(txid: _transaction.txid);
    });
    isSent = _transaction.txType.toLowerCase() == "sent";
    divCount = isSent ? 8 : 6;
    _setSize();
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor * 0.85;

    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          leading: AppBarBackButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            "Transaction details",
            style: STextStyles.titleH4(context),
          ),
        ),
        body: SafeArea(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: scaleFactor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 24,
                right: 24,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  layoutBuilderHeight = constraints.maxHeight;
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: IntrinsicHeight(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TXDetailsItemBase(
                                  title: Text(
                                    "STATUS",
                                    style: STextStyles.overLineBold(context),
                                  ),
                                  body: whatIsIt(_transaction.txType),
                                ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItemBase(
                                  title: Text(
                                    "NOTE",
                                    style: STextStyles.overLineBold(context),
                                  ),
                                  body: TextField(
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    controller: noteController,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              notesServiceChangeNotifierProvider(
                                                  walletId))
                                          .editOrAddNote(
                                            txid: _transaction.txid,
                                            note: value,
                                          );
                                    },
                                    style: STextStyles.body(context),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      focusColor: Colors.transparent,
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 0,
                                      ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      // border: InputBorder.none,
                                      isCollapsed: true,
                                      hintText: "Type something...",
                                      hintStyle:
                                          STextStyles.body(context).copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .textDark,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSent)
                                  _Divider(
                                    height: divHeight,
                                  ),
                                if (isSent)
                                  TXDetailsItem(
                                    title: "RECIPIENT",
                                    info: _transaction.address,
                                  ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItem(
                                  title: "AMOUNT",
                                  info: trimTrailingZeros(amount),
                                ),
                                if (isSent)
                                  _Divider(
                                    height: divHeight,
                                  ),
                                if (isSent)
                                  TXDetailsItem(
                                    title: "FEE",
                                    info: showFeePending
                                        ? _transaction.confirmedStatus
                                            ? trimTrailingZeros(fee)
                                            : "Pending"
                                        : trimTrailingZeros(fee),
                                  ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItem(
                                  title: "DATE",
                                  info: Format.extractDateFrom(
                                    _transaction.timestamp,
                                  ),
                                ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItemBase(
                                  title: Text(
                                    "TRANSACTION ID",
                                    style: STextStyles.overLineBold(context),
                                  ),
                                  body: GestureDetector(
                                    onTap: () async {
                                      final uri = Uri.parse(
                                          "https://explorer3.epic.tech/blockdetail/${_transaction.txid}");
                                      try {
                                        await launchUrl(
                                          uri,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } catch (_) {
                                        unawaited(
                                          showDialog<void>(
                                            context: context,
                                            builder: (_) => OkDialog(
                                              title:
                                                  "Could not open in block explorer",
                                              message:
                                                  "Failed to open \"${uri.toString()}\"",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Text(
                                        _transaction.txid,
                                        style:
                                            STextStyles.body(context).copyWith(
                                          color: Theme.of(context)
                                              .extension<StackColors>()!
                                              .textGold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItem(
                                  title: "SLATE ID",
                                  info: _transaction.slateId ?? "Unknown",
                                ),
                                _Divider(
                                  height: divHeight,
                                ),
                                TXDetailsItem(
                                  title: "BLOCK HEIGHT",
                                  info: _transaction.confirmations > 0
                                      ? "${_transaction.height}"
                                      : "Pending",
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if (isSent &&
                                    _transaction.confirmedStatus == false &&
                                    _transaction.isCancelled == false)
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Theme.of(context)
                                            .extension<StackColors>()!
                                            .accentColorRed,
                                      ),
                                    ),
                                    onPressed: _onCancelPressed,
                                    child: Text(
                                      "CANCEL TRANSACTION",
                                      style: STextStyles.buttonText(context)
                                          .copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .popupBG,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String trimTrailingZeros(Decimal amount) {
  String amountString = amount.toStringAsFixed(8);
  // I'd love to do this more simply
  // Step from the right of the string to the left, break at first non-zero character and make substring up to that point (LTR, unless it's zero)
  for (int i = amountString.length - 1; i > 0; i--) {
    if (amountString.split('')[i] != '0') {
      String subStr = amountString.substring(0, i + 1);
      if (subStr.isNotEmpty) {
        amountString = subStr;
      }
      break;
    }
  }

  // remove decimal separator
  if (amountString.endsWith(".") || amountString.endsWith(",")) {
    amountString = amountString.substring(0, amountString.length - 1);
  }
  return amountString;
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: (height - 1) / 2),
      child: Container(
        height: 1,
        color: Theme.of(context)
            .extension<StackColors>()!
            .buttonBackPrimaryDisabled,
      ),
    );
  }
}

class TXDetailsItem extends ConsumerStatefulWidget {
  const TXDetailsItem({
    Key? key,
    required this.title,
    required this.info,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  final String title;
  final String info;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<TXDetailsItem> createState() => _TXDetailsItemState();
}

class _TXDetailsItemState extends ConsumerState<TXDetailsItem> {
  late final String title;
  late final String info;
  late final ClipboardInterface clipboard;

  @override
  void initState() {
    title = widget.title;
    info = widget.info;
    clipboard = widget.clipboard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TXDetailsItemBase(
      title: Text(
        title,
        style: STextStyles.overLineBold(context),
      ),
      body: GestureDetector(
        onTap: () {
          clipboard.setData(
            ClipboardData(
              text: info,
            ),
          );
        },
        child: Text(
          info,
          style: STextStyles.body(context),
        ),
      ),
    );
  }
}

class TXDetailsItemBase extends StatelessWidget {
  const TXDetailsItemBase({
    Key? key,
    required this.title,
    required this.body,
    this.spacing = 5,
  }) : super(key: key);

  final Widget title;
  final Widget body;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(
          height: spacing,
        ),
        body,
      ],
    );
  }
}
