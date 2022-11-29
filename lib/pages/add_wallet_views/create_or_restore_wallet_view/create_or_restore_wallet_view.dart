import 'package:flutter/material.dart';
import 'package:epicmobile/pages/add_wallet_views/create_or_restore_wallet_view/sub_widgets/coin_image.dart';
import 'package:epicmobile/pages/add_wallet_views/create_or_restore_wallet_view/sub_widgets/create_or_restore_wallet_subtitle.dart';
import 'package:epicmobile/pages/add_wallet_views/create_or_restore_wallet_view/sub_widgets/create_or_restore_wallet_title.dart';
import 'package:epicmobile/pages/add_wallet_views/create_or_restore_wallet_view/sub_widgets/create_wallet_button_group.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/exit_to_my_stack_button.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/desktop/desktop_app_bar.dart';
import 'package:epicmobile/widgets/desktop/desktop_scaffold.dart';

class CreateOrRestoreWalletView extends StatelessWidget {
  const CreateOrRestoreWalletView({
    Key? key,
    required this.coin,
  }) : super(key: key);

  static const routeName = "/createOrRestoreWallet";

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    final isDesktop = Util.isDesktop;

    if (isDesktop) {
      return DesktopScaffold(
        appBar: const DesktopAppBar(
          isCompactHeight: false,
          leading: AppBarBackButton(),
          trailing: ExitToMyStackButton(),
        ),
        body: SizedBox(
          width: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 10,
              ),
              CreateRestoreWalletTitle(
                coin: coin,
                isDesktop: isDesktop,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 324,
                child: CreateRestoreWalletSubTitle(
                  isDesktop: isDesktop,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CoinImage(
                coin: coin,
                isDesktop: isDesktop,
              ),
              const SizedBox(
                height: 32,
              ),
              CreateWalletButtonGroup(
                coin: coin,
                isDesktop: isDesktop,
              ),
              const Spacer(
                flex: 15,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          color: Theme.of(context).extension<StackColors>()!.background,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(31),
                  child: CoinImage(
                    coin: coin,
                    isDesktop: isDesktop,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                CreateRestoreWalletTitle(
                  coin: coin,
                  isDesktop: isDesktop,
                ),
                const SizedBox(
                  height: 8,
                ),
                CreateRestoreWalletSubTitle(
                  isDesktop: isDesktop,
                ),
                const Spacer(
                  flex: 5,
                ),
                CreateWalletButtonGroup(
                  coin: coin,
                  isDesktop: isDesktop,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
