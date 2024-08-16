import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/pages/buy_view/confirm_buy_view.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyWithCryptoStep4 extends ConsumerStatefulWidget {
  const BuyWithCryptoStep4({
    super.key,
    required this.option,
    required this.trade,
  });

  final BuyOption option;
  final Trade trade;

  static const routeName = "/buyWithCryptoStep4";

  @override
  ConsumerState<BuyWithCryptoStep4> createState() => _BuyWithCryptoStep4State();
}

class _BuyWithCryptoStep4State extends ConsumerState<BuyWithCryptoStep4> {
  bool _acceptPressedLock = false;

  void _acceptPressed() async {
    if (_acceptPressedLock) {
      return;
    }
    _acceptPressedLock = true;
    try {
      await ref.read(pIsarDB).isar.writeTxn(() async {
        await ref.read(pIsarDB).isar.trades.put(widget.trade);
      });

      if (mounted) {
        await Navigator.of(context).pushNamed(
          ConfirmBuyView.routeName,
          arguments: widget.trade,
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
          title: const StepIndicatorRow(
            activeCount: 4,
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
                            "${widget.trade.fromAmount} ${widget.trade.fromCurrency.toUpperCase()}",
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
                            "${widget.trade.toAmount} ${widget.trade.toCurrency.toUpperCase()}",
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
                        onPressed: Navigator.of(context).pop,
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
