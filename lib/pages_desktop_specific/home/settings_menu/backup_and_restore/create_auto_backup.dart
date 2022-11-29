import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stack_wallet_backup/stack_wallet_backup.dart';
import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/settings_views/global_settings_view/stack_backup_views/helpers/restore_create_backup.dart';
import 'package:epicmobile/pages/settings_views/global_settings_view/stack_backup_views/helpers/stack_file_system.dart';
import 'package:epicmobile/providers/global/prefs_provider.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/backup_frequency_type.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/enums/log_level_enum.dart';
import 'package:epicmobile/utilities/flutter_secure_storage_interface.dart';
import 'package:epicmobile/utilities/format.dart';
import 'package:epicmobile/utilities/logger.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog.dart';
import 'package:epicmobile/widgets/desktop/primary_button.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';
import 'package:epicmobile/widgets/progress_bar.dart';
import 'package:epicmobile/widgets/stack_dialog.dart';
import 'package:epicmobile/widgets/stack_text_field.dart';
import 'package:zxcvbn/zxcvbn.dart';

class CreateAutoBackup extends ConsumerStatefulWidget {
  const CreateAutoBackup({
    Key? key,
    this.secureStore = const SecureStorageWrapper(
      FlutterSecureStorage(),
    ),
  }) : super(key: key);

  final FlutterSecureStorageInterface secureStore;

  @override
  ConsumerState<CreateAutoBackup> createState() => _CreateAutoBackup();
}

class _CreateAutoBackup extends ConsumerState<CreateAutoBackup> {
  late final TextEditingController fileLocationController;
  late final TextEditingController passphraseController;
  late final TextEditingController passphraseRepeatController;

  late final FlutterSecureStorageInterface secureStore;

  late final StackFileSystem stackFileSystem;
  late final FocusNode passphraseFocusNode;
  late final FocusNode passphraseRepeatFocusNode;
  final zxcvbn = Zxcvbn();

  bool shouldShowPasswordHint = true;
  bool hidePassword = true;

  String passwordFeedback =
      "Add another word or two. Uncommon words are better. Use a few words, avoid common phrases. No need for symbols, digits, or uppercase letters.";
  double passwordStrength = 0.0;

  bool get shouldEnableCreate {
    return fileLocationController.text.isNotEmpty &&
        passphraseController.text.isNotEmpty &&
        passphraseRepeatController.text.isNotEmpty;
  }

  bool get fieldsMatch =>
      passphraseController.text == passphraseRepeatController.text;

  BackupFrequencyType _currentDropDownValue =
      BackupFrequencyType.everyTenMinutes;

  final List<BackupFrequencyType> _dropDownItems = [
    BackupFrequencyType.everyTenMinutes,
    BackupFrequencyType.everyAppStart,
    BackupFrequencyType.afterClosingAWallet,
  ];

  @override
  void initState() {
    secureStore = widget.secureStore;
    stackFileSystem = StackFileSystem();

    fileLocationController = TextEditingController();
    passphraseController = TextEditingController();
    passphraseRepeatController = TextEditingController();

    passphraseFocusNode = FocusNode();
    passphraseRepeatFocusNode = FocusNode();

    if (Platform.isAndroid) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final dir = await stackFileSystem.prepareStorage();
        if (mounted) {
          setState(() {
            fileLocationController.text = dir.path;
          });
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    fileLocationController.dispose();
    passphraseController.dispose();
    passphraseRepeatController.dispose();

    passphraseFocusNode.dispose();
    passphraseRepeatFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType ");

    bool isEnabledAutoBackup = ref.watch(prefsChangeNotifierProvider
        .select((value) => value.isAutoBackupEnabled));

    String? selectedItem = "Every 10 minutes";
    final isDesktop = Util.isDesktop;
    return DesktopDialog(
      maxHeight: 680,
      maxWidth: 600,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  "Create auto backup",
                  style: STextStyles.desktopH3(context),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppBarIconButton(
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .textFieldDefaultBG,
                  size: 40,
                  icon: SvgPicture.asset(
                    Assets.svg.x,
                    color: Theme.of(context).extension<StackColors>()!.textDark,
                    width: 22,
                    height: 22,
                  ),
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              "Choose file location",
              style: STextStyles.desktopTextExtraSmall(context).copyWith(
                color: Theme.of(context).extension<StackColors>()!.textDark3,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!Platform.isAndroid)
                  Consumer(builder: (context, ref, __) {
                    return Container(
                      color: Colors.transparent,
                      child: TextField(
                        autocorrect: false,
                        enableSuggestions: false,
                        onTap: Platform.isAndroid
                            ? null
                            : () async {
                                try {
                                  await stackFileSystem.prepareStorage();

                                  if (mounted) {
                                    await stackFileSystem.pickDir(context);
                                  }

                                  if (mounted) {
                                    setState(() {
                                      fileLocationController.text =
                                          stackFileSystem.dirPath ?? "";
                                    });
                                  }
                                } catch (e, s) {
                                  Logging.instance
                                      .log("$e\n$s", level: LogLevel.Error);
                                }
                              },
                        controller: fileLocationController,
                        style: STextStyles.field(context),
                        decoration: InputDecoration(
                          hintText: "Save to...",
                          hintStyle: STextStyles.fieldLabel(context),
                          suffixIcon: UnconstrainedBox(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                SvgPicture.asset(
                                  Assets.svg.folder,
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textDark3,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                        key: const Key(
                            "createBackupSaveToFileLocationTextFieldKey"),
                        readOnly: true,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: false,
                          paste: false,
                          selectAll: false,
                        ),
                        onChanged: (newValue) {},
                      ),
                    );
                  }),
                if (!Platform.isAndroid)
                  const SizedBox(
                    height: 24,
                  ),
                if (isDesktop)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Create a passphrase",
                      style: STextStyles.desktopTextExtraSmall(context)
                          .copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textDark3),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius,
                  ),
                  child: TextField(
                    key: const Key("createBackupPasswordFieldKey1"),
                    focusNode: passphraseFocusNode,
                    controller: passphraseController,
                    style: STextStyles.field(context),
                    obscureText: hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: standardInputDecoration(
                      "Create passphrase",
                      passphraseFocusNode,
                      context,
                    ).copyWith(
                      labelStyle:
                          isDesktop ? STextStyles.fieldLabel(context) : null,
                      suffixIcon: UnconstrainedBox(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              key: const Key(
                                  "createBackupPasswordFieldShowPasswordButtonKey"),
                              onTap: () async {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              child: SvgPicture.asset(
                                hidePassword
                                    ? Assets.svg.eye
                                    : Assets.svg.eyeSlash,
                                color: Theme.of(context)
                                    .extension<StackColors>()!
                                    .textDark3,
                                width: 16,
                                height: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      if (newValue.isEmpty) {
                        setState(() {
                          passwordFeedback = "";
                        });
                        return;
                      }
                      final result = zxcvbn.evaluate(newValue);
                      String suggestionsAndTips = "";
                      for (var sug in result.feedback.suggestions!.toSet()) {
                        suggestionsAndTips += "$sug\n";
                      }
                      suggestionsAndTips += result.feedback.warning!;
                      String feedback =
                          // "Password Strength: ${((result.score! / 4.0) * 100).toInt()}%\n"
                          suggestionsAndTips;

                      passwordStrength = result.score! / 4;

                      // hack fix to format back string returned from zxcvbn
                      if (feedback.contains("phrasesNo need")) {
                        feedback = feedback.replaceFirst(
                            "phrasesNo need", "phrases\nNo need");
                      }

                      if (feedback.endsWith("\n")) {
                        feedback = feedback.substring(0, feedback.length - 2);
                      }

                      setState(() {
                        passwordFeedback = feedback;
                      });
                    },
                  ),
                ),
                if (passphraseFocusNode.hasFocus ||
                    passphraseRepeatFocusNode.hasFocus ||
                    passphraseController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: passwordFeedback.isNotEmpty ? 4 : 0,
                    ),
                    child: passwordFeedback.isNotEmpty
                        ? Text(
                            passwordFeedback,
                            style: STextStyles.infoSmall(context),
                          )
                        : null,
                  ),
                if (passphraseFocusNode.hasFocus ||
                    passphraseRepeatFocusNode.hasFocus ||
                    passphraseController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 10,
                    ),
                    child: ProgressBar(
                      key: const Key("createStackBackUpProgressBar"),
                      width: 512,
                      height: 5,
                      fillColor: passwordStrength < 0.51
                          ? Theme.of(context)
                              .extension<StackColors>()!
                              .accentColorRed
                          : passwordStrength < 1
                              ? Theme.of(context)
                                  .extension<StackColors>()!
                                  .accentColorYellow
                              : Theme.of(context)
                                  .extension<StackColors>()!
                                  .accentColorGreen,
                      backgroundColor: Theme.of(context)
                          .extension<StackColors>()!
                          .buttonBackSecondary,
                      percent:
                          passwordStrength < 0.25 ? 0.03 : passwordStrength,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius,
                  ),
                  child: TextField(
                    key: const Key("createBackupPasswordFieldKey2"),
                    focusNode: passphraseRepeatFocusNode,
                    controller: passphraseRepeatController,
                    style: STextStyles.field(context),
                    obscureText: hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: standardInputDecoration(
                      "Confirm passphrase",
                      passphraseRepeatFocusNode,
                      context,
                    ).copyWith(
                      labelStyle: STextStyles.fieldLabel(context),
                      suffixIcon: UnconstrainedBox(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              key: const Key(
                                  "createBackupPasswordFieldShowPasswordButtonKey"),
                              onTap: () async {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              child: SvgPicture.asset(
                                hidePassword
                                    ? Assets.svg.eye
                                    : Assets.svg.eyeSlash,
                                color: Theme.of(context)
                                    .extension<StackColors>()!
                                    .textDark3,
                                width: 16,
                                height: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onChanged: (newValue) {
                      setState(() {});
                      // TODO: ? check if passwords match?
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              "Auto Backup frequency",
              style: STextStyles.desktopTextExtraSmall(context).copyWith(
                color: Theme.of(context).extension<StackColors>()!.textDark3,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
            ),
            child: isDesktop
                ? DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      offset: Offset(0, -10),
                      isExpanded: true,
                      dropdownElevation: 0,
                      value: _currentDropDownValue,
                      items: [
                        ..._dropDownItems.map(
                          (e) {
                            String message = "";
                            switch (e) {
                              case BackupFrequencyType.everyTenMinutes:
                                message = "Every 10 minutes";
                                break;
                              case BackupFrequencyType.everyAppStart:
                                message = "Every app startup";
                                break;
                              case BackupFrequencyType.afterClosingAWallet:
                                message =
                                    "After closing a cryptocurrency wallet";
                                break;
                            }

                            return DropdownMenuItem(
                              value: e,
                              child: Text(message),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        if (value is BackupFrequencyType) {
                          if (ref
                                  .read(prefsChangeNotifierProvider)
                                  .backupFrequencyType !=
                              value) {
                            ref
                                .read(prefsChangeNotifierProvider)
                                .backupFrequencyType = value;
                          }
                          setState(() {
                            _currentDropDownValue = value;
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        Assets.svg.chevronDown,
                        width: 10,
                        height: 5,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark3,
                      ),
                      buttonPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      buttonDecoration: BoxDecoration(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textFieldDefaultBG,
                        borderRadius: BorderRadius.circular(
                          Constants.size.circularBorderRadius,
                        ),
                      ),
                      dropdownDecoration: BoxDecoration(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textFieldDefaultBG,
                        borderRadius: BorderRadius.circular(
                          Constants.size.circularBorderRadius,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: "Cancel",
                    onPressed: () {
                      int count = 0;
                      !isEnabledAutoBackup
                          ? Navigator.of(context).popUntil((_) => count++ >= 2)
                          : Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: PrimaryButton(
                    label: "Enable Auto Backup",
                    enabled: shouldEnableCreate,
                    onPressed: !shouldEnableCreate
                        ? null
                        : () async {
                            final String pathToSave =
                                fileLocationController.text;
                            final String passphrase = passphraseController.text;
                            final String repeatPassphrase =
                                passphraseRepeatController.text;

                            if (pathToSave.isEmpty) {
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: "Directory not chosen",
                                context: context,
                              );
                              return;
                            }
                            if (!(await Directory(pathToSave).exists())) {
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: "Directory does not exist",
                                context: context,
                              );
                              return;
                            }
                            if (passphrase.isEmpty) {
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: "A passphrase is required",
                                context: context,
                              );
                              return;
                            }
                            if (passphrase != repeatPassphrase) {
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: "Passphrase does not match",
                                context: context,
                              );
                              return;
                            }

                            showDialog<dynamic>(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const StackDialog(
                                title: "Encrypting initial backup",
                                message: "This shouldn't take long",
                              ),
                            );

                            // make sure the dialog is able to be displayed for at least some time
                            final fut = Future<void>.delayed(
                                const Duration(milliseconds: 300));

                            String adkString;
                            int adkVersion;
                            try {
                              final adk =
                                  await compute(generateAdk, passphrase);
                              adkString = Format.uint8listToString(adk.item2);
                              adkVersion = adk.item1;
                            } on Exception catch (e, s) {
                              String err = getErrorMessageFromSWBException(e);
                              Logging.instance
                                  .log("$err\n$s", level: LogLevel.Error);
                              // pop encryption progress dialog
                              Navigator.of(context).pop();
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: err,
                                context: context,
                              );
                              return;
                            } catch (e, s) {
                              Logging.instance
                                  .log("$e\n$s", level: LogLevel.Error);
                              // pop encryption progress dialog
                              Navigator.of(context).pop();
                              showFloatingFlushBar(
                                type: FlushBarType.warning,
                                message: "$e",
                                context: context,
                              );
                              return;
                            }

                            await secureStore.write(
                                key: "auto_adk_string", value: adkString);
                            await secureStore.write(
                                key: "auto_adk_version_string",
                                value: adkVersion.toString());

                            final DateTime now = DateTime.now();
                            final String fileToSave =
                                createAutoBackupFilename(pathToSave, now);

                            final backup = await SWB.createepicmobileJSON();

                            bool result = await SWB.encryptepicmobileWithADK(
                              fileToSave,
                              adkString,
                              jsonEncode(backup),
                              adkVersion: adkVersion,
                            );

                            // this future should already be complete unless there was an error encrypting
                            await Future.wait([fut]);

                            if (mounted) {
                              // pop encryption progress dialog
                              int count = 0;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 2);

                              if (result) {
                                ref
                                    .read(prefsChangeNotifierProvider)
                                    .autoBackupLocation = pathToSave;
                                ref
                                    .read(prefsChangeNotifierProvider)
                                    .lastAutoBackup = now;

                                ref
                                    .read(prefsChangeNotifierProvider)
                                    .isAutoBackupEnabled = true;

                                await showDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => Platform.isAndroid
                                      ? StackOkDialog(
                                          title:
                                              "Stack Auto Backup enabled and saved to:",
                                          message: fileToSave,
                                        )
                                      : const StackOkDialog(
                                          title: "Stack Auto Backup enabled!"),
                                );
                                if (mounted) {
                                  passphraseController.text = "";
                                  passphraseRepeatController.text = "";

                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                }
                              } else {
                                await showDialog<dynamic>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const StackOkDialog(
                                      title: "Failed to enable Auto Backup"),
                                );
                              }
                            }
                          },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
