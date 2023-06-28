/* 
 * This file is part of Stack Wallet.
 * 
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/providers/exchange/exchange_form_state_provider.dart';
import 'package:epicpay/providers/global/locale_provider.dart';
import 'package:epicpay/services/swap/exchange.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/amount/amount_formatter.dart';
import 'package:epicpay/utilities/amount/amount_unit.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/animated_text.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExchangeOption extends ConsumerStatefulWidget {
  const ExchangeOption({
    Key? key,
    required this.exchange,
    required this.fixedRate,
    required this.reversed,
  }) : super(key: key);

  final Exchange exchange;
  final bool fixedRate;
  final bool reversed;

  @override
  ConsumerState<ExchangeOption> createState() => _ExchangeOptionState();
}

class _ExchangeOptionState extends ConsumerState<ExchangeOption> {
  @override
  Widget build(BuildContext context) {
    final sendCurrency =
        ref.watch(efCurrencyPairProvider.select((value) => value.send));
    final receivingCurrency =
        ref.watch(efCurrencyPairProvider.select((value) => value.receive));
    final reversed = ref.watch(efReversedProvider);
    final amount = reversed
        ? ref.watch(efReceiveAmountProvider)
        : ref.watch(efSendAmountProvider);

    final data = ref.watch(efEstimatesListProvider(widget.exchange.name));
    final estimates = data?.item1.value;

    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubicEmphasized,
      child: Builder(
        builder: (_) {
          if (ref.watch(efRefreshingProvider)) {
            // show loading
            return _ProviderOption(
              exchange: widget.exchange,
              estimate: null,
              rateString: "",
              loadingString: true,
            );
          } else if (sendCurrency != null &&
              receivingCurrency != null &&
              amount != null &&
              amount > Decimal.zero) {
            if (estimates != null && estimates.isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < estimates.length; i++)
                    Builder(
                      builder: (context) {
                        final e = estimates[i];

                        int decimals;
                        try {
                          decimals = coinFromTickerCaseInsensitive(
                                  receivingCurrency.ticker)
                              .decimals;
                        } catch (_) {
                          decimals = 8; // some reasonable alternative
                        }
                        Amount rate;
                        if (e.reversed) {
                          rate = (amount / e.fromAmount)
                              .toDecimal(scaleOnInfinitePrecision: 18)
                              .toAmount(fractionDigits: decimals);
                        } else {
                          rate = (e.toAmount / amount)
                              .toDecimal(scaleOnInfinitePrecision: 18)
                              .toAmount(fractionDigits: decimals);
                        }

                        Coin? coin;
                        try {
                          coin = coinFromTickerCaseInsensitive(
                              receivingCurrency.ticker);
                        } catch (_) {
                          coin = null;
                        }

                        final String rateString;
                        if (coin != null) {
                          rateString = "1 ${sendCurrency.ticker.toUpperCase()} "
                              "~ ${ref.watch(pAmountFormatter(coin)).format(rate)}";
                        } else {
                          final formatter = AmountFormatter(
                            unit: AmountUnit.normal,
                            locale: ref.watch(
                              localeServiceChangeNotifierProvider
                                  .select((value) => value.locale),
                            ),
                            coin: Coin.epicCash, // some sane default
                            maxDecimals: 8, // some sane default
                          );
                          rateString = "1 ${sendCurrency.ticker.toUpperCase()} "
                              "~ ${formatter.format(rate, withUnitName: false)}"
                              " ${receivingCurrency.ticker.toUpperCase()}";
                        }

                        return ConditionalParent(
                          condition: i > 0,
                          builder: (child) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              child,
                            ],
                          ),
                          child: _ProviderOption(
                            key: Key(widget.exchange.name + e.exchangeProvider),
                            exchange: widget.exchange,
                            estimate: e,
                            rateString: rateString,
                            kycRating: e.kycRating,
                          ),
                        );
                      },
                    ),
                ],
              );
            } else {
              Logging.instance.log(
                "$runtimeType rate unavailable for ${widget.exchange.name}: $data",
                level: LogLevel.Warning,
              );

              return Consumer(
                builder: (_, ref, __) {
                  String? message;

                  final range = data?.item2;
                  if (range != null) {
                    if (range.min != null && amount < range.min!) {
                      message ??= "Amount too small";
                    } else if (range.max != null && amount > range.max!) {
                      message ??= "Amount too large";
                    }
                  } else if (data?.item1.value == null) {
                    final rateType = ref.watch(efRateTypeProvider) ==
                            SupportedRateType.estimated
                        ? "estimated"
                        : "fixed";
                    message ??= "Pair unavailable on $rateType rate flow";
                  }

                  return _ProviderOption(
                    exchange: widget.exchange,
                    estimate: null,
                    rateString: message ?? "Failed to fetch rate",
                    rateColor:
                        Theme.of(context).extension<StackColors>()!.textError,
                  );
                },
              );
            }
          } else {
            // show n/a
            return _ProviderOption(
              exchange: widget.exchange,
              estimate: null,
              rateString: "n/a",
            );
          }
        },
      ),
    );
  }
}

class _ProviderOption extends ConsumerStatefulWidget {
  const _ProviderOption({
    Key? key,
    required this.exchange,
    required this.estimate,
    required this.rateString,
    this.kycRating,
    this.loadingString = false,
    this.rateColor,
  }) : super(key: key);

  final Exchange exchange;
  final Estimate? estimate;
  final String rateString;
  final String? kycRating;
  final bool loadingString;
  final Color? rateColor;

  @override
  ConsumerState<_ProviderOption> createState() => _ProviderOptionState();
}

class _ProviderOptionState extends ConsumerState<_ProviderOption> {
  late final String _id;

  @override
  void initState() {
    _id =
        "${widget.exchange.name} (${widget.estimate?.exchangeProvider ?? widget.exchange.name})";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String groupValue = ref.watch(currentCombinedExchangeIdProvider);
    //
    // if (ref.watch(efExchangeProvider).name ==
    //     (widget.estimate?.exchangeProvider ?? widget.exchange.name)) {
    //   groupValue = _id;
    // }

    return GestureDetector(
      // onTap: () {
      //   ref.read(efExchangeProvider.notifier).state = widget.exchange;
      //   ref.read(efExchangeProviderNameProvider.notifier).state =
      //       widget.exchange.name;
      // },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: 20,
              //   height: 20,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 15.0),
              //     child: Radio(
              //       activeColor: Theme.of(context)
              //           .extension<StackColors>()!
              //           .radioButtonIconEnabled,
              //       value: _id,
              //       groupValue: groupValue,
              //       onChanged: (_) {
              //         ref.read(efExchangeProvider.notifier).state =
              //             widget.exchange;
              //         ref.read(efExchangeProviderNameProvider.notifier).state =
              //             widget.exchange.name;
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   width: 14,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: SizedBox(
              //     width: 24,
              //     height: 24,
              //     child: SvgPicture.asset(
              //       Assets.exchange.changeNow,
              //       width: 24,
              //       height: 24,
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              Text(
                "ESTIMATED RATE",
                style: STextStyles.overLineBold(context).copyWith(
                  color: Theme.of(context).extension<StackColors>()!.textLight,
                ),
                // widget.exchange.name,
                // style: STextStyles.titleBold12_400(context).copyWith(
                //   color: Theme.of(context).extension<StackColors>()!.textGold,
                // ),
              ),
              widget.loadingString
                  ? AnimatedText(
                      stringsToLoopThrough: const [
                        "Loading",
                        "Loading.",
                        "Loading..",
                        "Loading...",
                      ],
                      style: STextStyles.overLineBold(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textLight,
                      ),
                      // style: STextStyles.itemSubtitle12(context).copyWith(
                      //   color: Theme.of(context)
                      //       .extension<StackColors>()!
                      //       .textSubtitle1,
                      // ),
                    )
                  : Text(
                      widget.rateString,
                      style: STextStyles.overLineBold(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textLight,
                      ),

                      // style: STextStyles.itemSubtitle12(context).copyWith(
                      //   color: widget.rateColor ??
                      //       Theme.of(context)
                      //           .extension<StackColors>()!
                      //           .textSubtitle1,
                      // ),
                    ),
              //     ],
              //   ),
              // ),
              // if (widget.kycRating != null)
              //   TrocadorKYCInfoButton(
              //     kycType: TrocadorKYCType.fromString(
              //       widget.kycRating!,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
