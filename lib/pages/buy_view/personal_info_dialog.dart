import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:flutter/material.dart';

class PersonalInfoDialog extends StatelessWidget {
  const PersonalInfoDialog({
    super.key,
  });

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
                        "Why is my information needed?",
                        style: STextStyles.titleH3(context),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Epic Pay does not store any personal identifying information (PII). "
                        "This data is required by our purchasing partner Guardarian.com. "
                        "Please see their Privacy Policy for information on how your PII is used.",
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
