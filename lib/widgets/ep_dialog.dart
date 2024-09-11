import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/desktop/secondary_button.dart';
import 'package:flutter/material.dart';

class EPDialogBase extends StatelessWidget {
  const EPDialogBase({
    super.key,
    required this.child,
    this.expand = false,
    this.expandError = false,
  });

  final Widget child;
  final bool expand;
  final bool expandError;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (expandError)
          const SizedBox(
            height: 20,
          ),
        ConditionalParent(
          condition: expand,
          builder: (child) => Expanded(child: child),
          child: Material(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.transparent,
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
        ),
        if (expandError)
          const SizedBox(
            height: 40,
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

class EPErrorDialog extends StatelessWidget {
  const EPErrorDialog({
    super.key,
    required this.title,
    this.info,
    this.expand = false,
  });
  final String title;
  final String? info;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return EPDialogBase(
      expand: expand,
      expandError: expand,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: STextStyles.baseXS(context),
            ),
            if (info != null)
              const SizedBox(
                height: 16,
              ),
            if (info != null)
              ConditionalParent(
                condition: expand,
                builder: (child) => Expanded(
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
                child: Text(
                  info!,
                  style: STextStyles.baseXS(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
