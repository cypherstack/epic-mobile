import 'package:decimal/decimal.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_1.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/services/guardarian/enums.dart';
import 'package:epicpay/services/guardarian/guardarian_api.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/services/guardarian/response_models/g_estimate.dart';
import 'package:epicpay/services/guardarian/response_models/g_transaction.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/step_progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyWithFiatStep3 extends ConsumerStatefulWidget {
  const BuyWithFiatStep3({
    super.key,
    required this.option,
    required this.epic,
    required this.estimate,
    required this.sendAmount,
  });

  final GCurrency option;
  final GCurrency epic;
  final GEstimate estimate;
  final Decimal sendAmount;

  static const routeName = "/buyWithFiatStep3";

  @override
  ConsumerState<BuyWithFiatStep3> createState() => _BuyWithFiatStep3State();
}

class _BuyWithFiatStep3State extends ConsumerState<BuyWithFiatStep3> {
  Future<GTransaction> _createBuy() async {
    final tx = await GuardarianAPI.postTransaction(
      fromAmount: widget.sendAmount.toDouble(),
      fromCurrency: widget.estimate.fromCurrency,
      fromNetwork: widget.estimate.fromNetwork,
      toCurrency: widget.estimate.toCurrency,
      toNetwork: widget.estimate.toNetwork,
      skipChoosePaymentCategory: false,
      paymentCategory: EGPaymentCategory.VISA_MC,
      skipChoosePayoutAddress: false,
    );

    if (tx.exception != null) {
      throw tx.exception!;
    }

    return tx.value!;
  }

  bool _acceptPressedLock = false;
  void _acceptPressed() async {
    if (_acceptPressedLock) {
      return;
    }
    _acceptPressedLock = true;
    try {
      Exception? ex;
      final result = await showLoading(
        whileFuture: _createBuy(),
        context: context,
        onException: (e) => ex = e,
      );

      if (ex != null) {
        if (mounted) {
          await Logging.uiLog(
            ex,
            title: "Guardarian API Error",
            context: context,
          );
          // await showDialog<void>(
          //   context: context,
          //   builder: (_) => EPErrorDialog(
          //     title: "Guardarian API Error",
          //     info: ex.toString(),
          //   ),
          // );
        }
        return;
      }

      if (mounted) {
        await Logging.uiLog(
          result,
          title: "Guardarian create transaction result",
          context: context,
        );
      }
    } finally {
      _acceptPressedLock = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
          centerTitle: true,
          title: const StepProgressDots(
            activeCount: 3,
            totalCount: 3,
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
                        "You will send",
                        textAlign: TextAlign.center,
                        style: STextStyles.titleH3(context),
                      ),
                      SizedBox(
                        height: height < 600 ? 4 : 12,
                      ),
                      RoundedWhiteContainer(
                        child: Center(
                          child: Text(
                            "${widget.sendAmount} ${widget.option.ticker.toUpperCase()}",
                            style: STextStyles.titleH3(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .buttonTextSecondary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height < 600 ? 12 : 48,
                      ),
                      Text(
                        "You will receive approximately",
                        textAlign: TextAlign.center,
                        style: STextStyles.titleH3(context),
                      ),
                      SizedBox(
                        height: height < 600 ? 4 : 12,
                      ),
                      RoundedWhiteContainer(
                        child: Center(
                          child: Text(
                            "${widget.estimate.value} ${widget.estimate.toCurrency.toUpperCase()}",
                            style: STextStyles.titleH3(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .buttonTextSecondary,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedWhiteContainer(
                        child: Text(
                          "This estimate is provided by Guardarian.",
                          style: STextStyles.w400_12_18h(context),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SecondaryButton(
                        label: "GET ANOTHER QUOTE",
                        onPressed: () => Navigator.of(context).popUntil(
                          ModalRoute.withName(
                            BuyWithFiatStep1.routeName,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      PrimaryButton(
                        label: "CONTINUE",
                        onPressed: _acceptPressed,
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
