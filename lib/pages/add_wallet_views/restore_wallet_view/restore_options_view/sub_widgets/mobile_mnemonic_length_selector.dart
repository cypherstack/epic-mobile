import 'package:epicpay/providers/ui/verify_recovery_phrase/mnemonic_word_count_state_provider.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class MobileMnemonicLengthSelector extends ConsumerWidget {
  const MobileMnemonicLengthSelector({
    Key? key,
    required this.chooseMnemonicLength,
  }) : super(key: key);

  final VoidCallback chooseMnemonicLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        TextField(
          autocorrect: Util.isDesktop ? false : true,
          enableSuggestions: Util.isDesktop ? false : true,
          // controller: _lengthController,
          readOnly: true,
          textInputAction: TextInputAction.none,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: RawMaterialButton(
            splashColor: Theme.of(context).extension<StackColors>()!.highlight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Constants.size.circularBorderRadius,
              ),
            ),
            onPressed: chooseMnemonicLength,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${ref.watch(mnemonicWordCountStateProvider.state).state} words",
                  style: STextStyles.itemSubtitle12(context),
                ),
                SvgPicture.asset(
                  Assets.svg.chevronDown,
                  width: 8,
                  height: 4,
                  color:
                      Theme.of(context).extension<StackColors>()!.textSubtitle2,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
