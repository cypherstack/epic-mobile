import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/add_wallet_views/new_wallet_recovery_phrase_view/sub_widgets/mnemonic_table.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/qr_code_desktop_popup_content.dart';
import 'package:epicmobile/utilities/address_utils.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/clipboard_interface.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog_close_button.dart';
import 'package:epicmobile/widgets/desktop/primary_button.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';

class WalletKeysDesktopPopup extends StatelessWidget {
  const WalletKeysDesktopPopup({
    Key? key,
    required this.words,
    this.clipboardInterface = const ClipboardWrapper(),
  }) : super(key: key);

  final List<String> words;
  final ClipboardInterface clipboardInterface;

  static const String routeName = "walletKeysDesktopPopup";

  @override
  Widget build(BuildContext context) {
    return DesktopDialog(
      maxWidth: 614,
      maxHeight: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                ),
                child: Text(
                  "Wallet keys",
                  style: STextStyles.desktopH3(context),
                ),
              ),
              DesktopDialogCloseButton(
                onPressedOverride: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            "Recovery phrase",
            style: STextStyles.desktopTextMedium(context),
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Text(
                "Please write down your recovery phrase in the correct order and save it to keep your funds secure. You will also be asked to verify the words on the next screen.",
                style: STextStyles.desktopTextExtraExtraSmall(context),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: MnemonicTable(
              words: words,
              isDesktop: true,
              itemBorderColor: Theme.of(context)
                  .extension<StackColors>()!
                  .buttonBackSecondary,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: "Show QR code",
                    onPressed: () {
                      final String value = AddressUtils.encodeQRSeedData(words);
                      Navigator.of(context).pushNamed(
                        QRCodeDesktopPopupContent.routeName,
                        arguments: value,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: PrimaryButton(
                    label: "Copy",
                    onPressed: () async {
                      await clipboardInterface.setData(
                        ClipboardData(text: words.join(" ")),
                      );
                      unawaited(
                        showFloatingFlushBar(
                          type: FlushBarType.info,
                          message: "Copied to clipboard",
                          iconAsset: Assets.svg.copy,
                          context: context,
                        ),
                      );
                    },
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
