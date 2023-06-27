import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/models/paymint/transactions_model.dart';
import 'package:epicpay/pages/exchange_view/edit_trade_note_view.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/transaction_details_view.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/trade_notes_service.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/amount/amount_formatter.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/custom_buttons/custom_text_button.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

enum ChangeNowTransactionStatus {
  New,
  Waiting,
  Confirming,
  Exchanging,
  Sending,
  Finished,
  Failed,
  Refunded,
  Verifying,
}

extension ChangeNowTransactionStatusExt on ChangeNowTransactionStatus {
  String get lowerCaseName => name.toLowerCase();
}

ChangeNowTransactionStatus changeNowTransactionStatusFromStringIgnoreCase(
  String string,
) {
  for (final value in ChangeNowTransactionStatus.values) {
    if (value.lowerCaseName == string.toLowerCase()) {
      return value;
    }
  }
  throw ArgumentError(
      "String value does not match any known ChangeNowTransactionStatus");
}

class TradeDetailsView extends ConsumerStatefulWidget {
  const TradeDetailsView({
    Key? key,
    required this.tradeId,
    required this.transactionIfSentFromStack,
    required this.walletId,
    required this.walletName,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/tradeDetails";

  final String tradeId;
  final ClipboardInterface clipboard;
  final Transaction? transactionIfSentFromStack;
  final String? walletId;
  final String? walletName;

  @override
  ConsumerState<TradeDetailsView> createState() => _TradeDetailsViewState();
}

class _TradeDetailsViewState extends ConsumerState<TradeDetailsView> {
  late final String tradeId;
  late final ClipboardInterface clipboard;
  late final Transaction? transactionIfSentFromStack;
  late final String? walletId;

  StreamSubscription<Trade?>? _tradeSubscription;

  late Trade trade;

  String _note = "";

  bool isStackCoin(String ticker) {
    try {
      coinFromTickerCaseInsensitive(ticker);
      return true;
    } on ArgumentError catch (_) {
      return false;
    }
  }

  @override
  initState() {
    tradeId = widget.tradeId;
    clipboard = widget.clipboard;
    transactionIfSentFromStack = widget.transactionIfSentFromStack;
    walletId = widget.walletId;

    trade = ref
        .read(pIsarDB)
        .isar
        .trades
        .where()
        .tradeIdEqualToAnyExchangeName(tradeId)
        .findFirstSync()!;

    _tradeSubscription =
        ref.read(pIsarDB).isar.trades.watchObject(trade.id).listen((trade) {
      if (trade != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (mounted) {
            setState(() {
              this.trade = trade;
            });
          }
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final exchange =
            ChangeNowExchange.instance; //Exchange.fromName(trade.exchangeName);
        final response = await exchange.updateTrade(trade!);

        if (mounted && response.value != null) {
          await ref.read(pIsarDB).isar.writeTxn(() async {
            await ref.read(pIsarDB).isar.trades.put(response.value!);
          });
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tradeSubscription?.cancel();
    _tradeSubscription = null;
    super.dispose();
  }

  String _fetchIconAssetForStatus(String statusString) {
    ChangeNowTransactionStatus? status;
    try {
      if (statusString.toLowerCase().startsWith("waiting")) {
        statusString = "Waiting";
      }
      status = changeNowTransactionStatusFromStringIgnoreCase(statusString);
    } on ArgumentError catch (_) {
      switch (statusString.toLowerCase()) {
        case "funds confirming":
        case "processing payment":
          // TODO add assets
          return Assets.svg.anonymizePending;
        // return Assets.txExchangePending;

        case "completed":
          // TODO add assets
          return Assets.svg.anonymize;
        // return assets.txExchange;

        default:
          status = ChangeNowTransactionStatus.Failed;
      }
    }

    switch (status) {
      case ChangeNowTransactionStatus.New:
      case ChangeNowTransactionStatus.Waiting:
      case ChangeNowTransactionStatus.Confirming:
      case ChangeNowTransactionStatus.Exchanging:
      case ChangeNowTransactionStatus.Sending:
      case ChangeNowTransactionStatus.Refunded:
      case ChangeNowTransactionStatus.Verifying:
      // TODO add assets
      // return assets.txExchangePending;
      case ChangeNowTransactionStatus.Finished:
      // TODO add assets
      // return assets.txExchange;
      case ChangeNowTransactionStatus.Failed:
        // TODO add assets
        // return assets.txExchangeFailed;
        return Assets.svg.anonymize;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool sentFromStack =
        transactionIfSentFromStack != null && walletId != null;

    final bool hasTx = sentFromStack ||
        !(trade.status == "New" ||
            trade.status == "new" ||
            trade.status == "Waiting" ||
            trade.status == "waiting" ||
            trade.status == "Refunded" ||
            trade.status == "refunded" ||
            trade.status == "Closed" ||
            trade.status == "closed" ||
            trade.status == "Expired" ||
            trade.status == "expired" ||
            trade.status == "Failed" ||
            trade.status == "failed");

    //todo: check if print needed
    debugPrint("walletId: $walletId");
    debugPrint("transactionIfSentFromStack: $transactionIfSentFromStack");
    debugPrint("sentFromStack: $sentFromStack");
    debugPrint("hasTx: $hasTx");
    debugPrint("trade: ${trade.toString()}");

    final sendAmount =
        Decimal.tryParse(trade.fromAmount) ?? Decimal.parse("-1");

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
            "Trade details",
            style: STextStyles.titleH4(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RoundedWhiteContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "${trade.fromCurrency.toUpperCase()} → ${trade.toCurrency.toUpperCase()}",
                                // style: STextStyles.titleBold12(context),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Builder(builder: (context) {
                                String text;
                                try {
                                  final coin = coinFromTickerCaseInsensitive(
                                      trade.fromCurrency);
                                  final amount = sendAmount.toAmount(
                                      fractionDigits: coin.decimals);
                                  text = ref
                                      .watch(pAmountFormatter(coin))
                                      .format(amount);
                                } catch (_) {
                                  text = sendAmount.toStringAsFixed(
                                      trade.fromCurrency.toLowerCase() == "xmr"
                                          ? 12
                                          : 8);
                                }

                                return SelectableText(
                                  "-$text ${trade.fromCurrency.toUpperCase()}",
                                  style: STextStyles.itemSubtitle(context),
                                );
                              }),
                            ],
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                _fetchIconAssetForStatus(
                                  trade.status,
                                ),
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const _Divider(),
                    RoundedWhiteContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: STextStyles.itemSubtitle(context),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SelectableText(
                            trade.status,
                            style: STextStyles.itemSubtitle(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .colorForStatus(trade.status),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!sentFromStack && !hasTx) const _Divider(),
                    if (!sentFromStack && !hasTx)
                      RoundedContainer(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .warningBackground,
                        child: RichText(
                          text: TextSpan(
                            text:
                                "You must send at least ${sendAmount.toStringAsFixed(
                              trade.fromCurrency.toLowerCase() == "xmr"
                                  ? 12
                                  : 8,
                            )} ${trade.fromCurrency.toUpperCase()}. ",
                            style: STextStyles.label(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .warningForeground,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "If you send less than ${sendAmount.toStringAsFixed(
                                  trade.fromCurrency.toLowerCase() == "xmr"
                                      ? 12
                                      : 8,
                                )} ${trade.fromCurrency.toUpperCase()}, your transaction may not be converted and it may not be refunded.",
                                style: STextStyles.label(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .warningForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (sentFromStack) const _Divider(),
                    if (sentFromStack)
                      RoundedWhiteContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sent from",
                              style: STextStyles.itemSubtitle(context),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SelectableText(
                              widget.walletName!,
                              style: STextStyles.itemSubtitle12(context),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextButton(
                              text: "View transaction",
                              onPressed: () {
                                final Coin coin = coinFromTickerCaseInsensitive(
                                    trade.fromCurrency);

                                Navigator.of(context).pushNamed(
                                  TransactionDetailsView.routeName,
                                  arguments: Tuple3(
                                    transactionIfSentFromStack!,
                                    coin,
                                    walletId!,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    if (sentFromStack) const _Divider(),
                    if (sentFromStack)
                      RoundedWhiteContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${trade.exchangeName} address",
                                  style: STextStyles.itemSubtitle(context),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SelectableText(
                                  trade.payinAddress,
                                  style: STextStyles.itemSubtitle12(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (!sentFromStack && !hasTx) const _Divider(),
                    if (!sentFromStack && !hasTx)
                      RoundedWhiteContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Send ${trade.fromCurrency.toUpperCase()} to this address",
                                  style: STextStyles.itemSubtitle(context),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final address = trade.payinAddress;
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text: address,
                                      ),
                                    );
                                    // if (mounted) {
                                    //   unawaited(
                                    //     showFloatingFlushBar(
                                    //       type: FlushBarType.info,
                                    //       message: "Copied to clipboard",
                                    //       context: context,
                                    //     ),
                                    //   );
                                    // }
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.svg.copy,
                                        width: 12,
                                        height: 12,
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .infoItemIcons,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Copy",
                                        style: STextStyles.link2(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SelectableText(
                              trade.payinAddress,
                              style: STextStyles.itemSubtitle12(context),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              // onTap: () {
                              //   showDialog<dynamic>(
                              //     context: context,
                              //     useSafeArea: false,
                              //     barrierDismissible: true,
                              //     builder: (_) {
                              //       final width =
                              //           MediaQuery.of(context).size.width / 2;
                              //       return StackDialogBase(
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.stretch,
                              //           children: [
                              //             Center(
                              //               child: Text(
                              //                 "Send ${trade.payInCurrency.toUpperCase()} to this address",
                              //                 style: STextStyles.pageTitleH2(
                              //                     context),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               height: 12,
                              //             ),
                              //             Center(
                              //               child: RepaintBoundary(
                              //                 // key: _qrKey,
                              //                 child: SizedBox(
                              //                   width: width + 20,
                              //                   height: width + 20,
                              //                   child: QrImageView(
                              //                       data: trade.payInAddress,
                              //                       size: width,
                              //                       backgroundColor: Theme.of(
                              //                               context)
                              //                           .extension<StackColors>()!
                              //                           .popupBG,
                              //                       foregroundColor: Theme.of(
                              //                               context)
                              //                           .extension<StackColors>()!
                              //                           .accentColorDark),
                              //                 ),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               height: 12,
                              //             ),
                              //             Center(
                              //               child: SizedBox(
                              //                 width: width,
                              //                 child: TextButton(
                              //                   onPressed: () async {
                              //                     // await _capturePng(true);
                              //                     Navigator.of(context).pop();
                              //                   },
                              //                   style: Theme.of(context)
                              //                       .extension<StackColors>()!
                              //                       .getSecondaryEnabledButtonStyle(
                              //                           context),
                              //                   child: Text(
                              //                     "Cancel",
                              //                     style: STextStyles.button(
                              //                             context)
                              //                         .copyWith(
                              //                             color: Theme.of(context)
                              //                                 .extension<
                              //                                     StackColors>()!
                              //                                 .accentColorDark),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   );
                              // },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.svg.qrcode,
                                    width: 12,
                                    height: 12,
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .infoItemIcons,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Show QR code",
                                    style: STextStyles.link2(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    const _Divider(),
                    RoundedWhiteContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trade note",
                                style: STextStyles.itemSubtitle(context),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    EditTradeNoteView.routeName,
                                    arguments: (
                                      tradeId: tradeId,
                                      note: ref
                                          .read(tradeNoteServiceProvider)
                                          .getNote(tradeId: tradeId),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.svg.pencil,
                                      width: 10,
                                      height: 10,
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .infoItemIcons,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Edit",
                                      style: STextStyles.link2(context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SelectableText(
                            ref.watch(tradeNoteServiceProvider.select(
                                (value) => value.getNote(tradeId: tradeId))),
                            style: STextStyles.itemSubtitle12(context),
                          ),
                        ],
                      ),
                    ),
                    // if (sentFromStack) const _Divider(),
                    // if (sentFromStack)
                    //   RoundedWhiteContainer(
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               "Transaction note",
                    //               style: STextStyles.itemSubtitle(context),
                    //             ),
                    //             GestureDetector(
                    //               onTap: () {
                    //                 Navigator.of(context).pushNamed(
                    //                   EditNoteView.routeName,
                    //                   arguments: Tuple3(
                    //                     transactionIfSentFromStack!.txid,
                    //                     walletId!,
                    //                     _note,
                    //                   ),
                    //                 );
                    //               },
                    //               child: Row(
                    //                 children: [
                    //                   SvgPicture.asset(
                    //                     Assets.svg.pencil,
                    //                     width: 10,
                    //                     height: 10,
                    //                     color: Theme.of(context)
                    //                         .extension<StackColors>()!
                    //                         .infoItemIcons,
                    //                   ),
                    //                   const SizedBox(
                    //                     width: 4,
                    //                   ),
                    //                   Text(
                    //                     "Edit",
                    //                     style: STextStyles.link2(context),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 4,
                    //         ),
                    //         FutureBuilder(
                    //           future: ref.watch(
                    //               notesServiceChangeNotifierProvider(walletId!)
                    //                   .select((value) => value.getNoteFor(
                    //                       txid: transactionIfSentFromStack!
                    //                           .txid))),
                    //           builder: (builderContext,
                    //               AsyncSnapshot<String> snapshot) {
                    //             if (snapshot.connectionState ==
                    //                     ConnectionState.done &&
                    //                 snapshot.hasData) {
                    //               _note = snapshot.data ?? "";
                    //             }
                    //             return SelectableText(
                    //               _note,
                    //               style: STextStyles.itemSubtitle12(context),
                    //             );
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    const _Divider(),

                    RoundedWhiteContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: STextStyles.itemSubtitle(context),
                          ),
                          SelectableText(
                            Format.extractDateFrom(
                                DateTime.parse(trade.createdAt!)
                                        .millisecondsSinceEpoch ~/
                                    1000),
                            style: STextStyles.itemSubtitle12(context),
                          ),
                        ],
                      ),
                    ),
                    const _Divider(),
                    RoundedWhiteContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Swap service",
                            style: STextStyles.itemSubtitle(context),
                          ),
                          SelectableText(
                            trade.exchangeName,
                            style: STextStyles.itemSubtitle12(context),
                          ),
                        ],
                      ),
                    ),
                    const _Divider(),
                    RoundedWhiteContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trade ID",
                            style: STextStyles.itemSubtitle(context),
                          ),
                          Row(
                            children: [
                              Text(
                                trade.tradeId,
                                style: STextStyles.itemSubtitle12(context),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final data =
                                      ClipboardData(text: trade.tradeId);
                                  await clipboard.setData(data);
                                  // if (mounted) {
                                  //   unawaited(
                                  //     showFloatingFlushBar(
                                  //       type: FlushBarType.info,
                                  //       message: "Copied to clipboard",
                                  //       context: context,
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: SvgPicture.asset(
                                  Assets.svg.copy,
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .infoItemIcons,
                                  width: 12,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const _Divider(),
                    RoundedWhiteContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tracking",
                            style: STextStyles.itemSubtitle(context),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Builder(
                            builder: (context) {
                              late final String url;
                              switch (trade.exchangeName) {
                                case ChangeNowExchange.exchangeName:
                                  url =
                                      "https://changenow.io/exchange/txs/${trade.tradeId}";
                                  break;
                                // case SimpleSwapExchange.exchangeName:
                                //   url =
                                //       "https://simpleswap.io/exchange?id=${trade.tradeId}";
                                //   break;
                                // case MajesticBankExchange.exchangeName:
                                //   url =
                                //       "https://majesticbank.sc/track?trx=${trade.tradeId}";
                                //   break;
                                //
                                // default:
                                //   if (trade.exchangeName.startsWith(
                                //       TrocadorExchange.exchangeName)) {
                                //     url =
                                //         "https://trocador.app/en/checkout/${trade.tradeId}";
                                //   }
                              }
                              return GestureDetector(
                                onTap: () {
                                  launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                child: Text(
                                  url,
                                  style: STextStyles.link2(context),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //   const SizedBox(
                    //     height: 12,
                    //   ),
                    // if (
                    //     !hasTx &&
                    //     isStackCoin(trade.payInCurrency) &&
                    //     (trade.status == "New" ||
                    //         trade.status == "new" ||
                    //         trade.status == "waiting" ||
                    //         trade.status == "Waiting"))
                    //   SecondaryButton(
                    //     label: "Send from Stack",
                    //     onPressed: () {
                    //       final amount = sendAmount;
                    //       final address = trade.payInAddress;
                    //
                    //       final coin =
                    //           coinFromTickerCaseInsensitive(trade.payInCurrency);
                    //
                    //       Navigator.of(context).pushNamed(
                    //         SendFromView.routeName,
                    //         arguments: Tuple4(
                    //           coin,
                    //           amount,
                    //           address,
                    //           trade,
                    //         ),
                    //       );
                    //     },
                    //   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Theme.of(context).extension<StackColors>()!.backgroundAppBar,
    );
  }
}
