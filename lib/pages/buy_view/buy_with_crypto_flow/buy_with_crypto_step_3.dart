import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_refund_address_entry.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/utilities/assets.dart';
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

class BuyWithCryptoStep3 extends ConsumerStatefulWidget {
  const BuyWithCryptoStep3({
    super.key,
    required this.option,
    required this.estimate,
  });

  final CryptoBuyOption option;
  final Estimate estimate;

  static const routeName = "/buyWithCryptoStep3";

  @override
  ConsumerState<BuyWithCryptoStep3> createState() => _BuyWithCryptoStep3State();
}

class _BuyWithCryptoStep3State extends ConsumerState<BuyWithCryptoStep3> {
  bool _acceptPressedLock = false;

  void _acceptPressed() async {
    if (_acceptPressedLock) {
      return;
    }
    _acceptPressedLock = true;
    try {
      if (mounted) {
        await Navigator.of(context).pushNamed(
          BuyRefundAddressEntry.routeName,
          arguments: (
            option: widget.option,
            estimate: widget.estimate,
          ),
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
                            "${widget.estimate.fromAmount} ${widget.option.ticker.toUpperCase()}",
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
                            "${widget.estimate.toAmount} EPIC",
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
                          "This quote is provided by ChangeNOW.",
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
                            BuyWithCryptoStep1.routeName,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      PrimaryButton(
                        label: "ACCEPT QUOTE",
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
