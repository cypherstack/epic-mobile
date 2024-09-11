import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class StepProgressDots extends StatelessWidget {
  const StepProgressDots({
    super.key,
    required this.activeCount,
    required this.totalCount,
  }) : assert(totalCount > 0 && activeCount >= 0 && activeCount <= totalCount);

  final int activeCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final on = Theme.of(context).extension<StackColors>()!.stepIndicatorBGCheck;

    final off =
        Theme.of(context).extension<StackColors>()!.stepIndicatorBGInactive;

    return SizedBox(
      width: totalCount * 11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedContainer(
            width: 6,
            height: 6,
            color: activeCount > 0 ? on : off,
          ),
          for (int i = 1; i < totalCount; i++)
            RoundedContainer(
              width: 6,
              height: 6,
              color: activeCount > i ? on : off,
            )
        ],
      ),
    );
  }
}
