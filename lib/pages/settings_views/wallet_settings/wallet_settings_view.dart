import 'package:epicpay/pages/pinpad_views/lock_screen_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/delete_wallet_recovery_phrase_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/refresh_period_view.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/route_generator.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletSettingsView extends ConsumerWidget {
  const WalletSettingsView({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/walletSettings";

  Future<void> requestDelete(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return StackDialogBase(
          mainAxisAlignment: MainAxisAlignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                "Delete wallet",
                style: STextStyles.titleH3(context).copyWith(
                  color: Theme.of(context).extension<StackColors>()!.textMedium,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  style: STextStyles.bodyBold(context),
                  children: const [
                    TextSpan(
                        text: "You are about to delete your Epic Cash wallet. "
                            "Are you sure you want to do that?"),
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CANCEL",
                          style: STextStyles.buttonText(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      final mnemonic = await ref.read(walletProvider)!.mnemonic;

                      // pop dialog before pushing next view
                      navigator.pop();
                      await navigator.push(
                        RouteGenerator.getRoute(
                          shouldUseMaterialRoute:
                              RouteGenerator.useMaterialPageRoute,
                          builder: (_) => LockscreenView(
                            routeOnSuccessArguments: mnemonic,
                            showBackButton: true,
                            routeOnSuccess:
                                DeleteWalletRecoveryPhraseView.routeName,
                            biometricsCancelButtonString: "CANCEL",
                            biometricsLocalizedReason:
                                "Authenticate to delete wallet",
                            biometricsAuthenticationTitle: "Delete wallet",
                          ),
                          settings: const RouteSettings(
                              name: "/deleteWalletLockscreen"),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "YES, DELETE",
                          style: STextStyles.buttonText(context).copyWith(
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .textGold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            "Wallet Settings",
            style: STextStyles.titleH4(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RefreshPeriodView.routeName);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Refresh period",
                                  style: STextStyles.bodyBold(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const _Div(),
                    GestureDetector(
                      onTap: () {
                        requestDelete(context, ref);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Delete wallet",
                                  style: STextStyles.bodyBold(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _Div extends StatelessWidget {
  const _Div({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        height: 0.5,
        color: Theme.of(context).extension<StackColors>()!.popupBG,
      ),
    );
  }
}
