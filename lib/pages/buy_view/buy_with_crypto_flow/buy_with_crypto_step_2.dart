import 'dart:async';
import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_3.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/providers/global/locale_provider.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/step_progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class BuyWithCryptoStep2 extends ConsumerStatefulWidget {
  const BuyWithCryptoStep2({
    super.key,
    required this.option,
    required this.min,
    required this.max,
    required this.usdtRate,
  });

  final CryptoBuyOption option;
  final Decimal min;
  final Decimal max;
  final Decimal usdtRate;

  static const routeName = "/buyWithCryptoStep2";

  @override
  ConsumerState<BuyWithCryptoStep2> createState() => _BuyWithCryptoStep2State();
}

class _BuyWithCryptoStep2State extends ConsumerState<BuyWithCryptoStep2> {
  String _amountString = "0";
  String _minMax = "";

  bool amountIsZero(String amountString) => amountString == "0";

  Decimal convertedFromUsd = Decimal.zero;

  Decimal? convert(String amountString) {
    final amount = Decimal.tryParse(amountString);
    if (amount == null) {
      return null;
    }

    return amount * widget.usdtRate;
  }

  String _formatRange(Decimal value) {
    final Decimal result;
    if (value.abs() > Decimal.zero) {
      result =
          (value / widget.usdtRate).toDecimal(scaleOnInfinitePrecision: 10);
    } else {
      result = value;
    }
    return result.toStringAsFixed(2);
  }

  void amountChanged() {
    final amount = convert(_amountString);

    if (amount != null) {
      if (amount < widget.min) {
        setState(() {
          _minMax = "Minimum amount ${_formatRange(widget.min)}";
        });
      } else if (amount > widget.max) {
        setState(() {
          _minMax = "Maximum amount ${_formatRange(widget.max)}";
        });
      } else {
        setState(() {
          _minMax = "";
        });
      }
    }
  }

  void append(String value) {
    if (value == "." && _amountString.contains(".")) {
      return;
    }

    if (_amountString.contains(".") &&
        _amountString.length - _amountString.indexOf(".") >=
            widget.option.fractionDigits) {
      return;
    }

    if (amountIsZero(_amountString) && int.tryParse(value) != null) {
      setState(() {
        _amountString = value;
      });
    } else {
      setState(() {
        _amountString += value;
      });
    }
    amountChanged();
  }

  void undo() {
    if (amountIsZero(_amountString)) {
      return;
    }

    if (_amountString.length > 1) {
      setState(() {
        _amountString = _amountString.substring(0, _amountString.length - 1);
      });
    } else {
      setState(() {
        _amountString = "0";
      });
    }
    amountChanged();
  }

  bool _getAQuoteLock = false;
  Future<void> _nextPressed() async {
    if (_getAQuoteLock) {
      return;
    }
    _getAQuoteLock = true;

    try {
      const timeout = Duration(seconds: 5);

      final amount = convert(_amountString)!;

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
          .getEstimate(
            widget.option.currency!,
            epic!,
            amount,
            false,
            false,
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

          final estimates = result.value;

          if (estimates != null) {
            if (estimates.isEmpty) {
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (context) => const EPErrorDialog(
                    title: "Buy error",
                    info: "ChangeNOW provided no estimate",
                  ),
                ),
              );
              return;
            }

            await Navigator.of(context).pushNamed(
              BuyWithCryptoStep3.routeName,
              arguments: (
                estimate: estimates.first,
                option: widget.option,
              ),
            );
          }
        }
      }
    } finally {
      _getAQuoteLock = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Background(
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
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
                    color:
                        Theme.of(context).extension<StackColors>()!.textMedium,
                  ),
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            centerTitle: true,
            title: const StepProgressDots(
              activeCount: 2,
              totalCount: 3,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: AppBarIconButton(
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF222227),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.paste,
                        width: 24,
                        height: 24,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .topNavIconPrimary,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final value = await Clipboard.getData("text/plain");

                    num? number;
                    try {
                      number = NumberFormat.decimalPattern(
                        ref.read(localeServiceChangeNotifierProvider).locale,
                      ).parse(value!.text!);
                    } catch (_) {
                      number = null;
                    }

                    if (number == null) {
                      return;
                    }

                    final decimal = convert(number.toString());

                    if (mounted && decimal != null) {
                      setState(() {
                        _amountString = convert(
                          decimal.toStringAsFixed(widget.option.fractionDigits),
                        )!
                            .toString();
                      });

                      amountChanged();
                    }
                  },
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "I want to spend",
                        textAlign: TextAlign.center,
                        style: STextStyles.titleH3(context),
                      ),
                      SizedBox(
                        height: height < 600 ? 8 : 40,
                      ),
                      Text(
                        "$_amountString  USD",
                        textAlign: TextAlign.center,
                        style: STextStyles.w600_40(context).copyWith(
                          color: amountIsZero(_amountString)
                              ? Theme.of(context)
                                  .extension<StackColors>()!
                                  .textDark
                              : Theme.of(context)
                                  .extension<StackColors>()!
                                  .textLight,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        _minMax,
                        style: STextStyles.error2(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 300,
                              maxHeight: 400,
                            ),
                            child: Builder(builder: (context) {
                              final spaceWidth =
                                  (min(constraints.maxWidth, 300) - (3 * 72)) /
                                      2;
                              final spaceHeight =
                                  (min(constraints.maxHeight, 400) - (4 * 72)) /
                                      3;

                              final space = min(spaceWidth, spaceHeight);

                              Widget spacer() =>
                                  SizedBox(width: space, height: space);

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      _Button(
                                          value: "1",
                                          onPressed: () => append("1")),
                                      spacer(),
                                      _Button(
                                          value: "2",
                                          onPressed: () => append("2")),
                                      spacer(),
                                      _Button(
                                          value: "3",
                                          onPressed: () => append("3")),
                                    ],
                                  ),
                                  spacer(),
                                  Row(
                                    children: [
                                      _Button(
                                          value: "4",
                                          onPressed: () => append("4")),
                                      spacer(),
                                      _Button(
                                          value: "5",
                                          onPressed: () => append("5")),
                                      spacer(),
                                      _Button(
                                          value: "6",
                                          onPressed: () => append("6")),
                                    ],
                                  ),
                                  spacer(),
                                  Row(
                                    children: [
                                      _Button(
                                          value: "7",
                                          onPressed: () => append("7")),
                                      spacer(),
                                      _Button(
                                          value: "8",
                                          onPressed: () => append("8")),
                                      spacer(),
                                      _Button(
                                          value: "9",
                                          onPressed: () => append("9")),
                                    ],
                                  ),
                                  spacer(),
                                  Row(
                                    children: [
                                      _Button(
                                          value: ".",
                                          onPressed: () => append(".")),
                                      spacer(),
                                      _Button(
                                          value: "0",
                                          onPressed: () => append("0")),
                                      spacer(),
                                      _Undo(onPressed: undo),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: PrimaryButton(
                          label: "NEXT",
                          enabled: double.parse(_amountString) > 0 &&
                              _minMax.isEmpty,
                          onPressed: _nextPressed,
                        ),
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

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.value,
    required this.onPressed,
  });

  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(72),
        ),
        child: Center(
          child: Text(
            value,
            style: STextStyles.numberDefault(context),
          ),
        ),
      ),
    );
  }
}

class _Undo extends StatelessWidget {
  const _Undo({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(72),
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              Assets.svg.delete,
            ),
          ),
        ),
      ),
    );
  }
}
