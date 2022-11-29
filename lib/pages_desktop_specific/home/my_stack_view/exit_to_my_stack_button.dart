import 'package:flutter/material.dart';
import 'package:epicmobile/pages_desktop_specific/home/desktop_home_view.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';

class ExitToMyStackButton extends StatelessWidget {
  const ExitToMyStackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 24,
      ),
      child: SizedBox(
        height: 56,
        child: TextButton(
          style: Theme.of(context)
              .extension<StackColors>()!
              .getSmallSecondaryEnabledButtonColor(context),
          onPressed: onPressed ??
              () {
                Navigator.of(context).popUntil(
                  ModalRoute.withName(DesktopHomeView.routeName),
                );
              },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              "Exit to My Stack",
              style: STextStyles.desktopButtonSmallSecondaryEnabled(context),
            ),
          ),
        ),
      ),
    );
  }
}
