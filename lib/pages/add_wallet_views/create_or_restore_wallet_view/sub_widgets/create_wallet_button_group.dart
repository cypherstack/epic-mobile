import 'package:flutter/material.dart';
import 'package:epicmobile/pages/add_wallet_views/name_your_wallet_view/name_your_wallet_view.dart';
import 'package:epicmobile/utilities/enums/add_wallet_type_enum.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:tuple/tuple.dart';

class CreateWalletButtonGroup extends StatelessWidget {
  const CreateWalletButtonGroup({
    Key? key,
    required this.coin,
    required this.isDesktop,
  }) : super(key: key);

  final Coin coin;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isDesktop ? 70 : 0,
            minWidth: isDesktop ? 480 : 0,
          ),
          child: TextButton(
            style: Theme.of(context)
                .extension<StackColors>()!
                .getPrimaryEnabledButtonColor(context),
            onPressed: () {
              Navigator.of(context).pushNamed(
                NameYourWalletView.routeName,
                arguments: Tuple2(
                  AddWalletType.New,
                  coin,
                ),
              );
            },
            child: Text(
              "Create new wallet",
              style: isDesktop
                  ? STextStyles.desktopButtonEnabled(context)
                  : STextStyles.button(context),
            ),
          ),
        ),
        SizedBox(
          height: isDesktop ? 16 : 12,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isDesktop ? 70 : 0,
            minWidth: isDesktop ? 480 : 0,
          ),
          child: TextButton(
            style: Theme.of(context)
                .extension<StackColors>()!
                .getSecondaryEnabledButtonColor(context),
            onPressed: () {
              Navigator.of(context).pushNamed(
                NameYourWalletView.routeName,
                arguments: Tuple2(
                  AddWalletType.Restore,
                  coin,
                ),
              );
            },
            child: Text(
              "Restore wallet",
              style: isDesktop
                  ? STextStyles.desktopButtonSecondaryEnabled(context)
                  : STextStyles.button(context).copyWith(
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .accentColorDark),
            ),
          ),
        ),
      ],
    );
  }
}
