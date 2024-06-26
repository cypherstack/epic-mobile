/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:flutter/material.dart';

enum StepIndicatorStatus { current, completed, incomplete }

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    Key? key,
    // required this.step,
    required this.status,
    this.size = 12,
  }) : super(key: key);

  // final int step;
  final StepIndicatorStatus status;

  final double size;

  Color background(BuildContext context) {
    switch (status) {
      case StepIndicatorStatus.current:
        return Theme.of(context)
            .extension<StackColors>()!
            .stepIndicatorBGNumber;
      case StepIndicatorStatus.completed:
        return Theme.of(context).extension<StackColors>()!.stepIndicatorBGCheck;
      case StepIndicatorStatus.incomplete:
        return Theme.of(context)
            .extension<StackColors>()!
            .stepIndicatorBGInactive;
    }
  }

  Widget centered(BuildContext context) {
    switch (status) {
      case StepIndicatorStatus.completed:
      case StepIndicatorStatus.current:
        return Text(
          "",
          // step.toString(),
          style: STextStyles.stepIndicator(context).copyWith(
            color: Theme.of(context)
                .extension<StackColors>()!
                .stepIndicatorIconNumber,
          ),
        );
      case StepIndicatorStatus.incomplete:
        return Text(
          // step.toString(),
          "",
          style: STextStyles.stepIndicator(context).copyWith(
            color: Theme.of(context)
                .extension<StackColors>()!
                .stepIndicatorIconInactive,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: background(context),
      ),
      child: Center(
        child: centered(context),
      ),
    );
  }
}
