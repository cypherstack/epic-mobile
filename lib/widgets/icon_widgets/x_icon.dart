import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class XIcon extends StatelessWidget {
  const XIcon({
    Key? key,
    this.width = 24,
    this.height = 24,
    this.color,
  }) : super(key: key);

  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.svg.x,
      width: width,
      height: height,
      color: color ??
          Theme.of(context)
              .extension<StackColors>()!
              .textFieldActiveSearchIconRight,
    );
  }
}
