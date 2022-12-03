import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/desktop/custom_text_button.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.width,
    this.height,
    this.label,
    this.icon,
    this.onPressed,
    this.enabled = true,
    this.desktopMed = false,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? label;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? icon;
  final bool desktopMed;

  TextStyle getStyle(bool isDesktop, BuildContext context) {
    if (isDesktop) {
      if (desktopMed) {
        return STextStyles.desktopTextExtraSmall(context).copyWith(
          color: enabled
              ? Theme.of(context).extension<StackColors>()!.buttonTextSecondary
              : Theme.of(context)
                  .extension<StackColors>()!
                  .buttonTextSecondaryDisabled,
        );
      } else {
        return enabled
            ? STextStyles.desktopButtonSecondaryEnabled(context)
            : STextStyles.desktopButtonSecondaryDisabled(context);
      }
    } else {
      return STextStyles.buttonText(context).copyWith(
        color: enabled
            ? Theme.of(context).extension<StackColors>()!.buttonTextSecondary
            : Theme.of(context)
                .extension<StackColors>()!
                .buttonTextSecondaryDisabled,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;

    return CustomTextButtonBase(
      height: desktopMed ? 56 : height,
      width: width,
      textButton: TextButton(
        onPressed: enabled ? onPressed : null,
        style: enabled
            ? Theme.of(context)
                .extension<StackColors>()!
                .getSecondaryEnabledButtonColor(context)
            : Theme.of(context)
                .extension<StackColors>()!
                .getSecondaryDisabledButtonColor(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null && label != null)
              const SizedBox(
                width: 10,
              ),
            if (label != null)
              Text(
                label!,
                style: getStyle(isDesktop, context),
              ),
          ],
        ),
      ),
    );
  }
}
