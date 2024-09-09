import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmCryptoBuyInfoDialog extends StatelessWidget {
  const ConfirmCryptoBuyInfoDialog({
    super.key,
    required this.baseCurrencyTicker,
  });

  final String baseCurrencyTicker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: EPDialogBase(
          expand: true,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buy EPIC",
                        style: STextStyles.titleH3(context),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Send $baseCurrencyTicker to the provided address.",
                        style: STextStyles.subtitle600(context).copyWith(
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .buttonTextSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Send the specified BTC amount to the provided wallet address. "
                        "Scan the QR code or copy the address. "
                        "The exchange is fulfilled by ChangeNOW.",
                        style: STextStyles.w400_16(context),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Wait for the incoming transaction in your EPIC wallet",
                        style: STextStyles.subtitle600(context).copyWith(
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .buttonTextSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Once BTC is received, "
                        "ChangeNOW will send EPIC to your EPIC Pay wallet. "
                        "You can find the incoming EPIC transaction in your transaction list.",
                        style: STextStyles.w400_16(context),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 10,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Constants.size.circularBorderRadius,
                    ),
                  ),
                  onPressed: Navigator.of(context).pop,
                  child: Text(
                    "CLOSE",
                    style: STextStyles.buttonText(context).copyWith(
                      color:
                          Theme.of(context).extension<StackColors>()!.textDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
