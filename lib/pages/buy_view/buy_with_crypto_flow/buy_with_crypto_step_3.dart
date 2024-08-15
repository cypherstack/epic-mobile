import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyWithCryptoStep3 extends StatefulWidget {
  const BuyWithCryptoStep3({
    super.key,
    required this.option,
    required this.amount,
  });

  final BuyOption option;
  final Amount amount;

  static const routeName = "/buyWithCryptoStep3";

  @override
  State<BuyWithCryptoStep3> createState() => _BuyWithCryptoStep3State();
}

class _BuyWithCryptoStep3State extends State<BuyWithCryptoStep3> {
  int? _selectedIndex;

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
          title: const StepIndicatorRow(
            activeCount: 3,
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
          ],
        ),
      ),
    );
  }
}
