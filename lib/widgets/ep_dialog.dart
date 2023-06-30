import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:flutter/material.dart';

class EPDialogBase extends StatelessWidget {
  const EPDialogBase({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(
            20,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).extension<StackColors>()!.popupBG,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class EPDialog extends StatelessWidget {
  const EPDialog({
    super.key,
    required this.title,
    required this.info,
    this.confirmButtonTitle,
    this.cancelButtonTitle,
    this.onCancelPressed,
    this.onConfirmPressed,
  });

  final String title;
  final String? info;
  final String? confirmButtonTitle;
  final String? cancelButtonTitle;
  final VoidCallback? onConfirmPressed;
  final VoidCallback? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return EPDialogBase(
      child: Column(
        children: [
          Text(
            title,
            style: STextStyles.baseXS(context),
          ),
          if (info != null)
            Text(
              info!,
              style: STextStyles.baseXS(context),
            ),
          if (confirmButtonTitle != null || cancelButtonTitle != null)
            Row(
              children: [
                cancelButtonTitle == null
                    ? const Spacer()
                    : Expanded(
                        child: SecondaryButton(
                          label: cancelButtonTitle,
                          onPressed: onCancelPressed,
                        ),
                      ),
                const SizedBox(
                  width: 12,
                ),
                confirmButtonTitle == null
                    ? const Spacer()
                    : Expanded(
                        child: PrimaryButton(
                          label: confirmButtonTitle,
                          onPressed: onConfirmPressed,
                        ),
                      ),
              ],
            )
        ],
      ),
    );
  }
}
