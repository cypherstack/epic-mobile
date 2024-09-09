import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_2.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/services/guardarian/guardarian_api.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:epicpay/widgets/step_progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class BuyWithFiatStep1 extends ConsumerStatefulWidget {
  const BuyWithFiatStep1({
    super.key,
    required this.currencies,
    required this.epic,
  });

  static const routeName = "/buyWithFiatStep1";

  final List<GCurrency> currencies;
  final GCurrency epic;

  @override
  ConsumerState<BuyWithFiatStep1> createState() => _BuyWithFiatStep1State();
}

class _BuyWithFiatStep1State extends ConsumerState<BuyWithFiatStep1> {
  int? _selectedIndex;

  bool _onNextPressedLock = false;
  void _onNextPressed() async {
    if (_onNextPressedLock) {
      return;
    }
    _onNextPressedLock = true;

    try {
      final option = widget.currencies[_selectedIndex!];
      const timeout = Duration(seconds: 5);

      Exception? ex;

      final info = await showLoading(
        whileFuture: GuardarianAPI.getMarketInfo(
          option.ticker,
          null,
          widget.epic.ticker,
          "EPIC",
        ),
        context: context,
        delay: const Duration(seconds: 1),
        timeout: timeout,
        onException: (e) => ex = e,
      );

      if (mounted) {
        if (info == null || ex != null) {
          unawaited(
            showDialog<void>(
              context: context,
              builder: (context) => EPErrorDialog(
                title: ex == null ? "Unknown error" : "Error",
                info:
                    ex?.toString() ?? "showLoading result should never be null",
              ),
            ),
          );
          return;
        }

        if (info.exception != null) {
          unawaited(
            showDialog<void>(
              context: context,
              builder: (context) => EPErrorDialog(
                title: "Fetch Market Info error",
                info: info.exception!.toString(),
              ),
            ),
          );
          return;
        }

        if (info.value != null) {
          final max = Decimal.tryParse(info.value!.max.toString()) ??
              Decimal.parse("999999999999999999999999"); // insane max
          final min =
              Decimal.tryParse(info.value!.min.toString()) ?? Decimal.zero;

          await Navigator.of(context).pushNamed(
            BuyWithFiatStep2.routeName,
            arguments: (
              option: option,
              epic: widget.epic,
              min: min,
              max: max,
            ),
          );
        }
      }
    } finally {
      _onNextPressedLock = false;
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
              activeCount: 1,
              totalCount: 4,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "I have",
                textAlign: TextAlign.center,
                style: STextStyles.titleH3(context),
              ),
              SizedBox(
                height: height < 600 ? 8 : 24,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final option = widget.currencies[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (_selectedIndex == index) {
                            return;
                          }

                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: RoundedContainer(
                          padding: const EdgeInsets.all(12),
                          borderColor: _selectedIndex == index
                              ? Theme.of(context)
                                  .extension<StackColors>()!
                                  .stepIndicatorBGCheck
                              : null,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .popupBG,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 36,
                                height: 36,
                                child: SvgPicture.network(
                                  width: 36,
                                  height: 36,
                                  option.logoUrl,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "${option.name} / ${option.ticker}",
                                style: STextStyles.w400_16(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: widget.currencies.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryButton(
                  label: "NEXT",
                  enabled: _selectedIndex != null,
                  onPressed: _selectedIndex == null ? null : _onNextPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
