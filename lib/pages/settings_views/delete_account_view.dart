import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/pages/intro_view.dart';
import 'package:epicpay/providers/global/prefs_provider.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/providers/global/wallets_service_provider.dart';
import 'package:epicpay/utilities/delete_everything.dart';
import 'package:epicpay/utilities/flutter_secure_storage_interface.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/desktop_app_bar.dart';
import 'package:epicpay/widgets/desktop/desktop_scaffold.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeleteAccountView extends ConsumerStatefulWidget {
  const DeleteAccountView({
    Key? key,
    this.secureStorageInterface = const SecureStorageWrapper(
      FlutterSecureStorage(),
    ),
  }) : super(key: key);

  static const String routeName = "/deleteAccountView";
  final FlutterSecureStorageInterface secureStorageInterface;

  @override
  ConsumerState<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends ConsumerState<DeleteAccountView> {
  final isDesktop = Util.isDesktop;

  Future<void> onConfirmDeleteAccount() async {
    // TODO delete everything then pop to intro view

    await showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (_) => StackDialog(
        title: "Are you sure you want to delete all Wallets?",
        leftButton: TextButton(
          style: Theme.of(context)
              .extension<StackColors>()!
              .getSecondaryEnabledButtonColor(context),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: STextStyles.buttonText(context).copyWith(
                color: Theme.of(context)
                    .extension<StackColors>()!
                    .accentColorDark),
          ),
        ),
        rightButton: TextButton(
          style: Theme.of(context)
              .extension<StackColors>()!
              .getPrimaryEnabledButtonColor(context),
          onPressed: () async {
            await ref.read(walletProvider)!.exitCurrentWallet();

            await ref
                .read(walletsServiceChangeNotifierProvider)
                .deleteWallet(ref.read(walletProvider)!.walletName, true);
            await widget.secureStorageInterface.delete(key: "stack_pin");

            await deleteEverything();

            await DB.instance.init();

            await ref.read(prefsChangeNotifierProvider).reinit();
            if (mounted) {
              await Navigator.of(context).pushNamedAndRemoveUntil(
                IntroView.routeName,
                (route) => false,
              );
            }
          },
          child: Text(
            "Delete",
            style: STextStyles.buttonText(context),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScaffold(
      isDesktop: isDesktop,
      appBar: isDesktop
          ? DesktopAppBar(isCompactHeight: true)
          : AppBar(
              leading: AppBarBackButton(
                onPressed: () async {
                  if (FocusScope.of(context).hasFocus) {
                    FocusScope.of(context).unfocus();
                    await Future<void>.delayed(
                        const Duration(milliseconds: 75));
                  }
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              title: Text(
                "Delete account",
                style: STextStyles.titleH4(context),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            RoundedWhiteContainer(
              child: Text(
                "There is no account to delete, but Apple requires that we have a way to 'delete accounts' in the app and will reject our app updates if we don't, so here it is. Clicking this will delete all app data (not from our servers, because we never had it in the first place).\n\nWhen you click confirm, all app data will be deleted, including wallets and preferences, and you will be taken back to the very first onboarding screen. BE SURE TO BACKUP ALL SEEDS!!\n\nAre you sure you want to delete your \"account\"?",
                style: STextStyles.smallMed12(context),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: "Confirm",
              onPressed: onConfirmDeleteAccount,
            )
          ],
        ),
      ),
    );
  }
}
