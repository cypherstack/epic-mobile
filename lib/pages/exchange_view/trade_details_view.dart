import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/models/paymint/transactions_model.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/transaction_details_view.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/string_extensions.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/custom_buttons/custom_text_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
    required this.isBuy,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/tradeDetails";

  final String tradeId;
  final ClipboardInterface clipboard;
  final Transaction? transactionIfSentFromStack;
  final String? walletId;
  final String? walletName;
  final bool isBuy;

  @override
  ConsumerState<TradeDetailsView> createState() => _TradeDetailsViewState();
}

class _TradeDetailsViewState extends ConsumerState<TradeDetailsView> {
  static const double maxDivHeight = 51;
  static const double minDivHeight = 5;
  final _key = GlobalKey();
  static const sidePadding = EdgeInsets.symmetric(horizontal: 16);

  late final String tradeId;
  late final ClipboardInterface clipboard;
  late final Transaction? transactionIfSentFromStack;
  late final String? walletId;

  StreamSubscription<Trade?>? _tradeSubscription;

  late Trade trade;

  late int divCount;
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
        final response = await exchange.updateTrade(trade);

        if (mounted && response.value != null) {
          await ref.read(pIsarDB).isar.writeTxn(() async {
            await ref.read(pIsarDB).isar.trades.put(response.value!);
          });

          if (mounted) {
            setState(() {
              trade = response.value!;
            });
          }
        }
      }
    });

    divCount = 7;
    if (getSentFromStack) {
      divCount += 1;
    }
    if (!getSentFromStack && !getHasTx) {
      divCount += 1;
    }

    _setSize();

    super.initState();
  }

  @override
  void dispose() {
    _tradeSubscription?.cancel();
    _tradeSubscription = null;
    super.dispose();
  }

  bool get getSentFromStack =>
      transactionIfSentFromStack != null && walletId != null;
  bool get getHasTx =>
      getSentFromStack ||
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

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor * 0.85;
    final bool sentFromStack = getSentFromStack;

    final bool hasTx = getHasTx;

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
            widget.isBuy ? "Buy details" : "Trade details",
            style: STextStyles.titleH4(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                Assets.exchange.changeNow,
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: scaleFactor,
            ),
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    layoutBuilderHeight = constraints.maxHeight;
                    return SingleChildScrollView(
                      child: IntrinsicHeight(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.isBuy
                                      ? trade.fromFullTicker
                                      : trade.fromCurrency.toUpperCase(),
                                  style: STextStyles.titleH3(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .textMedium,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    Assets.svg.swapArrows,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Text(
                                  widget.isBuy
                                      ? trade.toFullTicker
                                      : trade.toCurrency.toUpperCase(),
                                  style: STextStyles.titleH3(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .textMedium,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: SelectableText(
                                trade.status.capitalize(),
                                style: STextStyles.body(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .colorForStatus(trade.status),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (!sentFromStack && !hasTx)
                              Padding(
                                padding: sidePadding,
                                child: RoundedWhiteContainer(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "You must send at least "
                                          "${sendAmount.toString()} "
                                          "${widget.isBuy ? trade.fromFullTicker : trade.fromCurrency.toUpperCase()}. ",
                                      style: STextStyles.errorBold(context),
                                      children: [
                                        TextSpan(
                                          text: "If you send less than "
                                              "${sendAmount.toString()} "
                                              "${widget.isBuy ? trade.fromFullTicker : trade.fromCurrency.toUpperCase()}"
                                              ", your transaction may not be "
                                              "converted and it may not be refunded.",
                                          style: STextStyles.error(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            if (!sentFromStack && !hasTx)
                              const SizedBox(
                                height: 20,
                              ),

                            if (!sentFromStack && !hasTx)
                              _DetailsItem(
                                title:
                                    "SEND ${widget.isBuy ? trade.fromFullTicker : trade.fromCurrency.toUpperCase()} "
                                    "TO THIS ADDRESS (CHANGENOW)",
                                data: trade.payinAddress,
                                trailingBelow: true,
                                isTapCopy: true,
                                trailing: CustomTextButton(
                                  text: "  SHOW QR CODE  ",
                                  onPressed: () {
                                    showDialog<dynamic>(
                                      context: context,
                                      useSafeArea: false,
                                      barrierDismissible: true,
                                      builder: (_) {
                                        final width =
                                            MediaQuery.of(context).size.width /
                                                2;
                                        return EPDialogBase(
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "Send ${widget.isBuy ? trade.fromFullTicker : trade.fromCurrency.toUpperCase()} to this address",
                                                    style:
                                                        STextStyles.pageTitleH2(
                                                            context),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Center(
                                                  child: RepaintBoundary(
                                                    // key: _qrKey,
                                                    child: SizedBox(
                                                      width: width + 20,
                                                      height: width + 20,
                                                      child: QrImage(
                                                          data: trade
                                                              .payinAddress,
                                                          size: width,
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .extension<
                                                                  StackColors>()!
                                                              .popupBG,
                                                          foregroundColor: Theme
                                                                  .of(context)
                                                              .extension<
                                                                  StackColors>()!
                                                              .accentColorDark),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    width: width,
                                                    child: SecondaryButton(
                                                      label: "Cancel",
                                                      onPressed: () async {
                                                        // await _capturePng(true);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                            if (!sentFromStack && !hasTx)
                              _Divider(height: divHeight),

                            _DetailsItem(
                              title: "AMOUNT TO SEND",
                              data:
                                  "${sendAmount.toString()} ${widget.isBuy ? trade.fromFullTicker : trade.fromCurrency.toUpperCase()}",
                              isTapCopy: true,
                            ),

                            _Divider(height: divHeight),
                            _DetailsItem(
                              title: "AMOUNT TO RECEIVE",
                              data:
                                  "${trade.toAmount} ${widget.isBuy ? trade.toFullTicker : trade.toCurrency.toUpperCase()}",
                              isTapCopy: true,
                              trailing: Text(
                                "(estimated)",
                                style: STextStyles.body(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textDark,
                                ),
                              ),
                            ),

                            _Divider(height: divHeight),
                            _DetailsItem(
                              title: "EXCHANGE RATE",
                              data:
                                  "~${(Decimal.parse(trade.toAmount) / Decimal.parse(trade.fromAmount)).toDecimal(
                                scaleOnInfinitePrecision: 8,
                              )} ${widget.isBuy ? trade.toFullTicker : trade.toCurrency.toUpperCase()}",
                              isTapCopy: true,
                            ),

                            if (sentFromStack) _Divider(height: divHeight),
                            if (sentFromStack)
                              _DetailsItem(
                                title: "TRANSACTION ID",
                                data:
                                    transactionIfSentFromStack?.txid ?? "error",
                                trailingBelow: true,
                                isTapCopy: true,
                                trailing: CustomTextButton(
                                  text: "VIEW TRANSACTION",
                                  onPressed: () {
                                    final Coin coin =
                                        coinFromTickerCaseInsensitive(
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
                              ),

                            _Divider(
                              height: divHeight,
                            ),
                            _DetailsItem(
                              title: "CHANGENOW ADDRESS",
                              data: trade.payinAddress,
                              isTapCopy: true,
                            ),

                            _Divider(
                              height: divHeight,
                            ),
                            _DetailsItem(
                              title: "RECEIVING ADDRESS",
                              data: trade.payoutAddress,
                              isTapCopy: true,
                            ),

                            _Divider(
                              height: divHeight,
                            ),
                            _DetailsItem(
                              title: "DATE",
                              data: Format.extractDateFrom(DateTime.parse(
                                    trade.createdAt!,
                                  ).millisecondsSinceEpoch ~/
                                  1000),
                              isTapCopy: true,
                            ),

                            _Divider(
                              height: divHeight,
                            ),
                            _DetailsItem(
                              title: widget.isBuy ? "BUY ID" : "TRADE ID",
                              data: trade.tradeId,
                              isTapCopy: true,
                            ),

                            _Divider(
                              height: divHeight,
                            ),
                            Padding(
                              padding: sidePadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TRACKING",
                                    style: STextStyles.overLineBold(context),
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
                                      return CustomTextButton(
                                        text: "  $url  ",
                                        onPressed: () {
                                          launchUrl(
                                            Uri.parse(url),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
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
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsItem extends StatelessWidget {
  const _DetailsItem({
    super.key,
    required this.title,
    required this.data,
    this.trailing,
    this.trailingBelow = false,
    this.isTapCopy = false,
    this.verticalSpacing = 8,
    this.padding = _TradeDetailsViewState.sidePadding,
  });

  final String title;
  final String data;
  final Widget? trailing;
  final bool trailingBelow;
  final bool isTapCopy;
  final double verticalSpacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: isTapCopy
            ? () {
                Clipboard.setData(
                  ClipboardData(
                    text: data,
                  ),
                );
              }
            : null,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: STextStyles.overLineBold(context),
              ),
              SizedBox(
                height: verticalSpacing,
              ),
              ConditionalParent(
                condition: trailing != null && !trailingBelow,
                builder: (child) => Row(
                  children: [
                    child,
                    const SizedBox(
                      width: 10,
                    ),
                    trailing!,
                  ],
                ),
                child: Text(
                  data,
                  style: STextStyles.body(context),
                ),
              ),
              if (trailing != null && trailingBelow) trailing!,
            ],
          ),
        ),
      ),
    );
  }
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
      padding: EdgeInsets.symmetric(
        vertical: (height - 1) / 2,
        horizontal: _TradeDetailsViewState.sidePadding.left,
      ),
      child: Container(
        height: 1,
        color: Theme.of(context).extension<StackColors>()!.popupBG,
      ),
    );
  }
}
