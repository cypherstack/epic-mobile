import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/wallet_keys_desktop_popup.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog_close_button.dart';
import 'package:epicmobile/widgets/desktop/primary_button.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';
import 'package:epicmobile/widgets/stack_text_field.dart';

class UnlockWalletKeysDesktop extends ConsumerStatefulWidget {
  const UnlockWalletKeysDesktop({
    Key? key,
    required this.walletId,
  }) : super(key: key);

  final String walletId;

  static const String routeName = "/desktopUnlockWalletKeys";

  @override
  ConsumerState<UnlockWalletKeysDesktop> createState() =>
      _UnlockWalletKeysDesktopState();
}

class _UnlockWalletKeysDesktopState
    extends ConsumerState<UnlockWalletKeysDesktop> {
  late final TextEditingController passwordController;

  late final FocusNode passwordFocusNode;

  bool continueEnabled = false;
  bool hidePassword = true;

  @override
  void initState() {
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DesktopDialog(
      maxWidth: 579,
      maxHeight: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DesktopDialogCloseButton(
                onPressedOverride: Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SvgPicture.asset(
            Assets.svg.keys,
            width: 100,
            height: 58,
          ),
          const SizedBox(
            height: 55,
          ),
          Text(
            "Wallet keys",
            style: STextStyles.desktopH2(context),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Enter your password",
            style: STextStyles.desktopTextMedium(context).copyWith(
              color: Theme.of(context).extension<StackColors>()!.textDark3,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Constants.size.circularBorderRadius,
              ),
              child: TextField(
                key: const Key("enterPasswordUnlockWalletKeysDesktopFieldKey"),
                focusNode: passwordFocusNode,
                controller: passwordController,
                style: STextStyles.desktopTextMedium(context).copyWith(
                  height: 2,
                ),
                obscureText: hidePassword,
                enableSuggestions: false,
                autocorrect: false,
                decoration: standardInputDecoration(
                  "Enter password",
                  passwordFocusNode,
                  context,
                ).copyWith(
                  suffixIcon: UnconstrainedBox(
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          GestureDetector(
                            key: const Key(
                                "enterUnlockWalletKeysDesktopFieldShowPasswordButtonKey"),
                            onTap: () async {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              height: 32,
                              width: 32,
                              child: Center(
                                child: SvgPicture.asset(
                                  hidePassword
                                      ? Assets.svg.eye
                                      : Assets.svg.eyeSlash,
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textDark3,
                                  width: 24,
                                  height: 19,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    continueEnabled = newValue.isNotEmpty;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 55,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: "Cancel",
                    onPressed: Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pop,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: PrimaryButton(
                    label: "Continue",
                    enabled: continueEnabled,
                    onPressed: continueEnabled
                        ? () async {
                            // todo: check password
                            // Navigator.of(context).pop();
                            final words = await ref
                                .read(walletsChangeNotifierProvider)
                                .getManager(widget.walletId)
                                .mnemonic;

                            await Navigator.of(context).pushReplacementNamed(
                              WalletKeysDesktopPopup.routeName,
                              arguments: words,
                            );
                            //
                            // await showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false,
                            //   builder: (context) => Navigator(
                            //     initialRoute: WalletKeysDesktopPopup.routeName,
                            //     onGenerateRoute: RouteGenerator.generateRoute,
                            //     onGenerateInitialRoutes: (_, __) {
                            //       return [
                            //         RouteGenerator.generateRoute(
                            //           RouteSettings(
                            //             name: WalletKeysDesktopPopup.routeName,
                            //             arguments: words,
                            //           ),
                            //         )
                            //       ];
                            //     },
                            //   ),
                            // );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
