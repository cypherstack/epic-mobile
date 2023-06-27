import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/providers/exchange/exchange_form_state_provider.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:epicpay/widgets/toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RateTypeToggle extends ConsumerWidget {
  const RateTypeToggle({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final void Function(SupportedRateType)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("BUILD: $runtimeType");
    final isDesktop = Util.isDesktop;

    return Toggle(
      onValueChanged: (value) {
        if (value) {
          onChanged?.call(SupportedRateType.fixed);
        } else {
          onChanged?.call(SupportedRateType.estimated);
        }
      },
      isOn: ref.watch(efRateTypeProvider) == SupportedRateType.fixed,
      onColor: Theme.of(context).extension<StackColors>()!.textGold,
      // ? Theme.of(context)
      //     .extension<StackColors>()!
      //     .rateTypeToggleDesktopColorOn
      // : Theme.of(context).extension<StackColors>()!.rateTypeToggleColorOn,
      offColor: Theme.of(context).extension<StackColors>()!.accentColorDark,
      // isDesktop
      //     ? Theme.of(context)
      //         .extension<StackColors>()!
      //         .rateTypeToggleDesktopColorOff
      //     : Theme.of(context).extension<StackColors>()!.rateTypeToggleColorOff,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Constants.size.circularBorderRadius,
        ),
      ),
      onIcon: Assets.svg.lockOpen,
      onText: "Estimate rate",
      offIcon: Assets.svg.lock,
      offText: "Fixed rate",
    );
  }
}
