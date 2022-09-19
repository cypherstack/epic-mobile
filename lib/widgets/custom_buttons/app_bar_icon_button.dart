import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackwallet/utilities/assets.dart';
import 'package:stackwallet/utilities/cfcolors.dart';
import 'package:stackwallet/utilities/util.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    // this.circularBorderRadius = 10.0,
    this.size = 36.0,
    this.shadows = const [],
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;
  // final double circularBorderRadius;
  final double size;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: color ?? CFColors.white,
        boxShadow: shadows,
      ),
      child: MaterialButton(
        splashColor: CFColors.splashLight,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key? key, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;
    return Padding(
      padding: isDesktop
          ? const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 24,
            )
          : const EdgeInsets.all(10),
      child: AppBarIconButton(
        size: isDesktop ? 56 : 32,
        color: isDesktop
            ? CFColors.textFieldDefaultBackground
            : CFColors.almostWhite,
        shadows: const [],
        icon: SvgPicture.asset(
          Assets.svg.arrowLeft,
          width: 24,
          height: 24,
        ),
        onPressed: onPressed ?? Navigator.of(context).pop,
      ),
    );
  }
}
