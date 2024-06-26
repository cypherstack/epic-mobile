import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DesktopDialogCloseButton extends StatelessWidget {
  const DesktopDialogCloseButton({
    Key? key,
    this.onPressedOverride,
  }) : super(key: key);

  final VoidCallback? onPressedOverride;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBarIconButton(
            color:
                Theme.of(context).extension<StackColors>()!.textFieldDefaultBG,
            size: 40,
            icon: SvgPicture.asset(
              Assets.svg.x,
              color: Theme.of(context).extension<StackColors>()!.textLight,
              width: 22,
              height: 22,
            ),
            onPressed: () {
              if (onPressedOverride == null) {
                Navigator.of(context).pop();
              } else {
                onPressedOverride!.call();
              }
            },
          ),
        ],
      ),
    );
  }
}
