/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'dart:async';

import 'package:epicpay/models/exchange/incomplete_exchange.dart';
import 'package:epicpay/pages/exchange_view/exchange_form.dart';
import 'package:epicpay/pages/exchange_view/sub_widgets/step_row.dart';
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/providers/exchange/exchange_form_state_provider.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:epicpay/widgets/stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tuple/tuple.dart';

class Step4View extends ConsumerStatefulWidget {
  const Step4View({
    Key? key,
    required this.model,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/exchangeStep4";

  final IncompleteExchangeModel model;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<Step4View> createState() => _Step4ViewState();
}

class _Step4ViewState extends ConsumerState<Step4View> {
  late final IncompleteExchangeModel model;
  late final ClipboardInterface clipboard;

  String _statusString = "New";

  Timer? _statusTimer;

  bool _isWalletCoinAndHasWallet(String ticker, WidgetRef ref) {
    try {
      final coin = coinFromTickerCaseInsensitive(ticker);
      return coin == Coin.epicCash;
    } catch (_) {
      return false;
    }
  }

  Future<void> _updateStatus() async {
    final statusResponse =
        await ref.read(efExchangeProvider).updateTrade(model.trade!);
    String status = "Waiting";
    if (statusResponse.value != null) {
      status = statusResponse.value!.status;
    }

    // extra info if status is waiting
    if (status == "Waiting") {
      status += " for deposit";
    }

    if (mounted) {
      setState(() {
        _statusString = status;
      });
    }
  }

  @override
  void initState() {
    model = widget.model;
    clipboard = widget.clipboard;

    _statusTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _updateStatus();
    });

    super.initState();
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    _statusTimer = null;
    super.dispose();
  }

  Future<void> _close() async {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
      await Future<void>.delayed(const Duration(milliseconds: 75));
    }
    if (mounted) {
      // ref.read(homeViewPageIndexStateProvider.notifier).state = 0;
      Navigator.of(context).popUntil(
        ModalRoute.withName(
          HomeView.routeName,
        ),
      );
    }
  }

  Future<void> _confirmSend(Tuple2<String, Coin> tuple) async {
    final bool firoPublicSend;
    // if (tuple.item2 == Coin.firo) {
    //   final result = await _showSendFromFiroBalanceSelectSheet(tuple.item1);
    //   if (result == null) {
    //     return;
    //   } else {
    //     firoPublicSend = result;
    //   }
    // } else {
    firoPublicSend = false;
    // }

    final manager = ref.read(walletProvider)!;

    final Amount amount = model.sendAmount.toAmount(
      fractionDigits: manager.coin.decimals,
    );
    final address = model.trade!.payinAddress;

    bool wasCancelled = false;
    try {
      if (!mounted) return;

      // unawaited(
      //   showDialog<dynamic>(
      //     context: context,
      //     useSafeArea: false,
      //     barrierDismissible: false,
      //     builder: (context) {
      //       return BuildingTransactionDialog(
      //         coin: manager.coin,
      //         onCancel: () {
      //           wasCancelled = true;
      //         },
      //       );
      //     },
      //   ),
      // );

      final time = Future<dynamic>.delayed(
        const Duration(
          milliseconds: 2500,
        ),
      );

      Future<Map<String, dynamic>> txDataFuture = manager.prepareSend(
        address: address,
        satoshiAmount: amount.raw.toInt(),
      );

      final results = await Future.wait([
        txDataFuture,
        time,
      ]);

      final txData = results.first as Map<String, dynamic>;

      if (!wasCancelled) {
        // pop building dialog

        if (mounted) {
          Navigator.of(context).pop();
        }

        txData["note"] =
            "${model.trade!.fromCurrency.toUpperCase()}/${model.trade!.toCurrency.toUpperCase()} exchange";
        txData["address"] = address;

        if (mounted) {
          // unawaited(
          //   Navigator.of(context).push(
          //     RouteGenerator.getRoute(
          //       shouldUseMaterialRoute: RouteGenerator.useMaterialPageRoute,
          //       builder: (_) => ConfirmChangeNowSendView(
          //         transactionInfo: txData,
          //         walletId: tuple.item1,
          //         routeOnSuccessName: HomeView.routeName,
          //         trade: model.trade!,
          //         shouldSendPublicFiroFunds: firoPublicSend,
          //       ),
          //       settings: const RouteSettings(
          //         name: ConfirmChangeNowSendView.routeName,
          //       ),
          //     ),
          //   ),
          // );
        }
      }
    } catch (e) {
      if (mounted && !wasCancelled) {
        // pop building dialog
        Navigator.of(context).pop();

        unawaited(
          showDialog<dynamic>(
            context: context,
            useSafeArea: false,
            barrierDismissible: true,
            builder: (context) {
              return EPDialog(
                title: "Transaction failed",
                info: e.toString(),
                confirmButtonTitle: "OK",
                onConfirmPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWalletCoin =
        _isWalletCoinAndHasWallet(model.trade!.fromCurrency, ref);
    return WillPopScope(
      onWillPop: () async {
        await _close();
        return false;
      },
      child: Background(
        child: Scaffold(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          appBar: AppBar(
            leading: AppBarBackButton(
              onPressed: () async {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                  await Future<void>.delayed(const Duration(milliseconds: 75));
                }
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
            centerTitle: true,
            title: const SizedBox(
              width:
                  66, // 66 is the width of the StepRow based on the current hardcoded values
              child: StepRow(
                count: 4,
                current: 3,
                width: 6,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final width = MediaQuery.of(context).size.width - 32;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Center(
                              child: Text(
                                "Send deposit",
                                style: STextStyles.pageTitleH1(context),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RoundedContainer(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .coal,
                              child: Column(
                                children: [
                                  UnorderedListItem(
                                    "SEND ${model.from.ticker.toUpperCase()} "
                                    "TO THE ADDRESS BELOW",
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "If you send less than "
                                      "${model.sendAmount.toString()} "
                                      "${model.from.ticker.toUpperCase()}, "
                                      "your transaction may not be converted "
                                      "and it may not be refunded.",
                                      style:
                                          STextStyles.label(context).copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .warningForeground,
                                      ),
                                    ),
                                  ),
                                  UnorderedListItem(
                                    "Once it is received, ChangeNOW will send "
                                    "the ${model.to.ticker.toUpperCase()} to "
                                    "the recipient address you provided.",
                                  ),
                                  UnorderedListItem(
                                    "Find this trade details and check its "
                                    "status in the list of trades.",
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Send ${model.from.ticker.toUpperCase()} "
                                      "to this address",
                                      style: STextStyles.itemSubtitle(context),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    clipboard.setData(ClipboardData(
                                      text: model.trade!.payinAddress,
                                    ));
                                  },
                                  child: Text(
                                    model.trade!.payinAddress,
                                    style: STextStyles.itemSubtitle12(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "AMOUNT TO SEND",
                                  style: STextStyles.itemSubtitle(context),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final data = ClipboardData(
                                      text: model.sendAmount.toString(),
                                    );
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
                                  child: Text(
                                    model.sendAmount.toString(),
                                    style: STextStyles.itemSubtitle12(context),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "TRADE ID",
                                  style: STextStyles.itemSubtitle(context),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        clipboard.setData(ClipboardData(
                                          text: model.trade!.tradeId,
                                        ));
                                      },
                                      child: Text(
                                        model.trade!.tradeId,
                                        style:
                                            STextStyles.itemSubtitle12(context),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "STATUS",
                                  style: STextStyles.itemSubtitle(context),
                                ),
                                Text(
                                  _statusString,
                                  style: STextStyles.itemSubtitle(context)
                                      .copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .colorForStatus(_statusString),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 12,
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) {
                                    return StackDialogBase(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Center(
                                            child: Text(
                                              "Send ${model.from.ticker} to this address",
                                              style: STextStyles.pageTitleH2(
                                                  context),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Center(
                                            child: QrImage(
                                              data: model.trade!.payinAddress,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              foregroundColor: Theme.of(context)
                                                  .extension<StackColors>()!
                                                  .accentColorDark,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  style: Theme.of(context)
                                                      .extension<StackColors>()!
                                                      .getSecondaryEnabledButtonColor(
                                                          context),
                                                  child: Text(
                                                    "Cancel",
                                                    style:
                                                        STextStyles.buttonText(
                                                                context)
                                                            .copyWith(
                                                      color: Theme.of(context)
                                                          .extension<
                                                              StackColors>()!
                                                          .buttonTextSecondary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: Theme.of(context)
                                  .extension<StackColors>()!
                                  .getSecondaryEnabledButtonColor(context),
                              child: Text(
                                "SHOW QR CODE",
                                style: STextStyles.buttonText(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .buttonTextSecondary,
                                ),
                              ),
                            ),
                            // if (isWalletCoin)
                            const SizedBox(
                              height: 12,
                            ),
                            if (isWalletCoin)
                              Builder(
                                builder: (context) {
                                  String buttonTitle = "SEND FROM EPIC PAY";

                                  final tuple = ref
                                      .read(
                                          exchangeSendFromWalletIdStateProvider
                                              .state)
                                      .state;
                                  if (tuple != null &&
                                      model.from.ticker.toLowerCase() ==
                                          tuple.item2.ticker.toLowerCase()) {
                                    buttonTitle =
                                        "SEND FROM ${ref.watch(walletProvider)!.walletName.toUpperCase()}";
                                  }

                                  return TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).pushNamed(
                                      //   ConfirmSendDetails.routeName,
                                      //   arguments: model,
                                      // );
                                    },
                                    // tuple != null &&
                                    //         model.from.ticker.toLowerCase() ==
                                    //             tuple.item2.ticker.toLowerCase()
                                    //     ? () async {
                                    //         await _confirmSend(tuple);
                                    //       }
                                    //     : () {
                                    // Navigator.of(context).push(
                                    //   RouteGenerator.getRoute(
                                    //     shouldUseMaterialRoute:
                                    //         RouteGenerator
                                    //             .useMaterialPageRoute,
                                    //     builder:
                                    //         (BuildContext context) {
                                    //       final coin =
                                    //           coinFromTickerCaseInsensitive(
                                    //               model.trade!
                                    //                   .fromCurrency);
                                    //       return SendFromView(
                                    //         coin: coin,
                                    //         amount: model.sendAmount
                                    //             .toAmount(
                                    //           fractionDigits:
                                    //               coin.decimals,
                                    //         ),
                                    //         address: model
                                    //             .trade!.payInAddress,
                                    //         trade: model.trade!,
                                    //       );
                                    //     },
                                    //     settings: const RouteSettings(
                                    //       name: SendFromView.routeName,
                                    //     ),
                                    //   ),
                                    // );
                                    // },
                                    style: Theme.of(context)
                                        .extension<StackColors>()!
                                        .getPrimaryEnabledButtonColor(context),
                                    child: Text(
                                      buttonTitle,
                                      style: STextStyles.buttonText(context)
                                          .copyWith(
                                        color: Theme.of(context)
                                            .extension<StackColors>()!
                                            .overlay,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}