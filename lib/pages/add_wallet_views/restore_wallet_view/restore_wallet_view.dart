import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip39/src/wordlists/english.dart' as bip39wordlist;
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/services/coins/coin_service.dart';
import 'package:epicpay/services/coins/manager.dart';
import 'package:epicpay/utilities/address_utils.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/barcode_scanner_interface.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/custom_text_selection_controls.dart';
import 'package:epicpay/utilities/default_nodes.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/enums/form_input_status_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/desktop_scaffold.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/fullscreen_message.dart';
import 'package:epicpay/widgets/icon_widgets/clipboard_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class RestoreWalletView extends ConsumerStatefulWidget {
  const RestoreWalletView({
    Key? key,
    required this.walletName,
    required this.coin,
    required this.seedWordsLength,
    required this.restoreFromDate,
    this.barcodeScanner = const BarcodeScannerWrapper(),
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const routeName = "/restoreWallet";

  final String walletName;
  final Coin coin;
  final int seedWordsLength;
  final DateTime restoreFromDate;

  final BarcodeScannerInterface barcodeScanner;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<RestoreWalletView> createState() => _RestoreWalletViewState();
}

class _RestoreWalletViewState extends ConsumerState<RestoreWalletView> {
  final _formKey = GlobalKey<FormState>();
  late final int _seedWordCount;
  late final bool isDesktop;

  final HashSet<String> _wordListHashSet = HashSet.from(bip39wordlist.WORDLIST);
  final ScrollController controller = ScrollController();

  final List<TextEditingController> _controllers = [];
  final List<FormInputStatus> _inputStatuses = [];
  final List<FocusNode> _focusNodes = [];

  late final BarcodeScannerInterface scanner;

  late final TextSelectionControls textSelectionControls;

  Future<void> onControlsPaste(TextSelectionDelegate delegate) async {
    final data = await widget.clipboard.getData(Clipboard.kTextPlain);
    if (data?.text == null) {
      return;
    }

    final text = data!.text!.trim();
    if (text.isEmpty || _controllers.isEmpty) {
      unawaited(delegate.pasteText(SelectionChangedCause.toolbar));
      return;
    }

    final words = text.split(" ");
    if (words.isEmpty) {
      unawaited(delegate.pasteText(SelectionChangedCause.toolbar));
      return;
    }

    if (words.length == 1) {
      _controllers.first.text = words.first;
      if (_isValidMnemonicWord(words.first.toLowerCase())) {
        setState(() {
          _inputStatuses.first = FormInputStatus.valid;
        });
      } else {
        setState(() {
          _inputStatuses.first = FormInputStatus.invalid;
        });
      }
      return;
    }

    _clearAndPopulateMnemonic(words);
  }

  // TODO: check for wownero wordlist?
  bool _isValidMnemonicWord(String word) {
    // TODO: get the actual language
    return _wordListHashSet.contains(word);
  }

  OutlineInputBorder _buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(Constants.size.circularBorderRadius),
    );
  }

  Future<void> attemptRestore() async {
    // wait for keyboard to disappear
    FocusScope.of(context).unfocus();
    await Future<void>.delayed(
      const Duration(milliseconds: 80),
    );

    if (_formKey.currentState!.validate()) {
      String mnemonic = "";
      for (var element in _controllers) {
        mnemonic += " ${element.text.trim().toLowerCase()}";
      }
      mnemonic = mnemonic.trim();

      int height = 0;

      // TODO: make more robust estimate of date maybe using https://explorer.epic.tech/api-index
      if (widget.coin == Coin.epicCash) {
        int secondsSinceEpoch =
            widget.restoreFromDate.millisecondsSinceEpoch ~/ 1000;
        const int epicCashFirstBlock = 1565370278;
        const double overestimateSecondsPerBlock = 61;
        int chosenSeconds = secondsSinceEpoch - epicCashFirstBlock;
        int approximateHeight = chosenSeconds ~/ overestimateSecondsPerBlock;
        // todo: check if print needed
        debugPrint(
            "approximate height: $approximateHeight chosen_seconds: $chosenSeconds");
        height = approximateHeight;
        if (height < 0) {
          height = 0;
        }
      }

      if (bip39.validateMnemonic(mnemonic) == false) {
        // unawaited(showFloatingFlushBar(
        //   type: FlushBarType.warning,
        //   message: "Invalid seed phrase!",
        //   context: context,
        // ));
      } else {
        if (!Platform.isLinux) await WakelockPlus.enable();
        final walletsService = ref.read(walletsServiceChangeNotifierProvider);

        final walletId = await walletsService.addNewWallet(
          name: widget.walletName,
          coin: widget.coin,
          shouldNotifyListeners: false,
        );
        bool isRestoring = true;
        // show restoring in progress
        final controller = FullScreenMessageController();
        unawaited(
          showDialog<void>(
            context: context,
            builder: (context) => FullScreenMessage(
              message: "Restoring wallet.\nIt may take a while.",
              icon: SvgPicture.asset(
                Assets.svg.loader,
              ),
              controller: controller,
            ),
          ),
        );

        var node = ref
            .read(nodeServiceChangeNotifierProvider)
            .getPrimaryNodeFor(coin: widget.coin);

        if (node == null) {
          node = DefaultNodes.getNodeFor(widget.coin);
          await ref.read(nodeServiceChangeNotifierProvider).setPrimaryNodeFor(
                coin: widget.coin,
                node: node,
              );
        }

        final failovers = ref
            .read(nodeServiceChangeNotifierProvider)
            .failoverNodesFor(coin: widget.coin);

        final wallet = CoinServiceAPI.from(
          widget.coin,
          walletId!,
          widget.walletName,
          node,
          ref.read(prefsChangeNotifierProvider),
          failovers,
        );

        final manager = Manager(wallet);

        try {
          // TODO GUI option to set maxUnusedAddressGap?
          // default is 20 but it may miss some transactions if
          // the previous wallet software generated many addresses
          // without using them
          await manager.recoverFromMnemonic(
            mnemonic: mnemonic,
            maxUnusedAddressGap: 20,
            maxNumberOfIndexesToCheck: 1000,
            height: height,
          );

          // check if state is still active before continuing
          if (mounted) {
            await ref
                .read(walletsServiceChangeNotifierProvider)
                .setMnemonicVerified(
                  walletId: manager.walletId,
                );

            ref.read(walletStateProvider.state).state = manager;

            if (mounted) {
              controller.forcePop?.call();

              unawaited(
                Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeView.routeName,
                  (route) => false,
                ),
              );
            }

            await showDialog<void>(
              context: context,
              builder: (context) => FullScreenMessage(
                message: "Wallet has been restored.",
                icon: SvgPicture.asset(
                  Assets.svg.circleCheck,
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            if (!Platform.isLinux && !isDesktop) {
              await WakelockPlus.disable();
            }
          }
        } catch (e) {
          if (!Platform.isLinux && !isDesktop) {
            await WakelockPlus.disable();
          }

          // if (e is HiveError &&
          //     e.message == "Box has already been closed.") {
          //   // restore was cancelled
          //   return;
          // }

          // check if state is still active and restore wasn't cancelled
          // before continuing
          if (mounted && isRestoring) {
            // pop waiting dialog
            controller.forcePop?.call();

            // show restoring wallet failed dialog
            await showDialog<void>(
              context: context,
              builder: (context) => FullScreenMessage(
                message:
                    "Unable to restore wallet.\nCheck your seed again.\n${e.toString()}",
                icon: SvgPicture.asset(
                  Assets.svg.circleRedX,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }

        if (!Platform.isLinux && !isDesktop) {
          await WakelockPlus.disable();
        }
      }
    }
  }

  Color _getColor(FormInputStatus status, bool hasFocus) {
    switch (status) {
      case FormInputStatus.empty:
        if (hasFocus) {
          return Theme.of(context).extension<StackColors>()!.accentColorYellow;
        }
        return Theme.of(context).extension<StackColors>()!.textFieldDefaultBG;

      case FormInputStatus.invalid:
        return Theme.of(context).extension<StackColors>()!.accentColorRed;

      case FormInputStatus.valid:
        return Theme.of(context).extension<StackColors>()!.accentColorGreen;
    }
  }

  InputDecoration _getInputDecorationFor(
    FormInputStatus status,
    bool hasFocus,
  ) {
    Color color = _getColor(status, hasFocus);

    Widget? suffixIcon;
    switch (status) {
      case FormInputStatus.empty:
        break;
      case FormInputStatus.invalid:
        suffixIcon = SvgPicture.asset(
          Assets.svg.alertCircle,
          width: 16,
          height: 16,
          color: Theme.of(context).extension<StackColors>()!.accentColorRed,
        );
        break;
      case FormInputStatus.valid:
        suffixIcon = SvgPicture.asset(
          Assets.svg.check,
          width: 16,
          height: 16,
          color: Theme.of(context).extension<StackColors>()!.accentColorGreen,
        );
        break;
    }
    return InputDecoration(
      fillColor: Theme.of(context).extension<StackColors>()!.textFieldDefaultBG,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      suffixIconConstraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
        maxWidth: 28,
        maxHeight: 24,
      ),
      suffixIcon: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: suffixIcon,
        ),
      ),
      isCollapsed: true,
      enabledBorder: _buildOutlineInputBorder(color),
      focusedBorder: _buildOutlineInputBorder(color),
      // Theme.of(context).extension<StackColors>()!.accentColorYellow),
      errorBorder: _buildOutlineInputBorder(color),
      disabledBorder: _buildOutlineInputBorder(color),
      focusedErrorBorder: _buildOutlineInputBorder(color),
    );
  }

  void _clearAndPopulateMnemonic(List<String> words) {
    final count = min(_controllers.length, words.length);

    // replace field content with listed words
    for (int i = 0; i < count; i++) {
      final word = words[i].trim();
      _controllers[i].text = words[i];
      if (_isValidMnemonicWord(word.toLowerCase())) {
        setState(() {
          _inputStatuses[i] = FormInputStatus.valid;
        });
      } else {
        setState(() {
          _inputStatuses[i] = FormInputStatus.invalid;
        });
      }
    }

    // clear remaining fields
    for (int i = count; i < _controllers.length; i++) {
      _controllers[i].text = "";
      setState(() {
        _inputStatuses[i] = FormInputStatus.empty;
      });
    }

    if (!isDesktop) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    }
  }

  Future<void> scanMnemonicQr() async {
    try {
      final qrResult = await scanner.scan();

      final results = AddressUtils.decodeQRSeedData(qrResult.rawContent);

      Logging.instance.log("scan parsed: $results", level: LogLevel.Info);

      if (results["mnemonic"] != null) {
        final list = (results["mnemonic"] as List)
            .map((value) => value as String)
            .toList(growable: false);
        if (list.isNotEmpty) {
          _clearAndPopulateMnemonic(list);
          Logging.instance.log("mnemonic populated", level: LogLevel.Info);
        } else {
          Logging.instance
              .log("mnemonic failed to populate", level: LogLevel.Info);
        }
      }
    } on PlatformException catch (e) {
      // likely failed to get camera permissions
      Logging.instance
          .log("Restore wallet qr scan failed: $e", level: LogLevel.Warning);
    }
  }

  Future<void> pasteMnemonic() async {
    final ClipboardData? data =
        await widget.clipboard.getData(Clipboard.kTextPlain);

    if (data?.text != null && data!.text!.isNotEmpty) {
      final content = data.text!.trim();
      final list = content.split(" ");
      _clearAndPopulateMnemonic(list);
    }
  }

  @override
  void initState() {
    _seedWordCount = widget.seedWordsLength;
    isDesktop = Util.isDesktop;

    textSelectionControls = Platform.isIOS
        ? CustomCupertinoTextSelectionControls(onPaste: onControlsPaste)
        : CustomMaterialTextSelectionControls(onPaste: onControlsPaste);

    scanner = widget.barcodeScanner;
    for (int i = 0; i < _seedWordCount; i++) {
      _controllers.add(TextEditingController());
      _inputStatuses.add(FormInputStatus.empty);
      final node = FocusNode();
      node.addListener(() {
        setState(() {});
      });
      _focusNodes.add(node);
    }

    super.initState();
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;
    return MasterScaffold(
      isDesktop: isDesktop,
      appBar: AppBar(
        leading: AppBarBackButton(
          onPressed: () async {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
              await Future<void>.delayed(const Duration(milliseconds: 50));
            }
            if (mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 10,
          //     bottom: 10,
          //     right: 10,
          //   ),
          //   child: AspectRatio(
          //     aspectRatio: 1,
          //     child: AppBarIconButton(
          //       key: const Key("restoreWalletViewQrCodeButton"),
          //       size: 36,
          //       shadows: const [],
          //       color: Theme.of(context).extension<StackColors>()!.background,
          //       icon: QrCodeIcon(
          //         width: 20,
          //         height: 20,
          //         color: Theme.of(context)
          //             .extension<StackColors>()!
          //             .accentColorDark,
          //       ),
          //       onPressed: scanMnemonicQr,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: AppBarIconButton(
                key: const Key("restoreWalletPasteButton"),
                size: 36,
                shadows: const [],
                color: Theme.of(context).extension<StackColors>()!.background,
                icon: ClipboardIcon(
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .accentColorDark,
                ),
                onPressed: pasteMnemonic,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).extension<StackColors>()!.background,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (isDesktop)
                  const Spacer(
                    flex: 10,
                  ),
                if (!isDesktop)
                  Text(
                    widget.walletName,
                    style: STextStyles.itemSubtitle(context),
                  ),
                SizedBox(
                  height: isDesktop ? 0 : 4,
                ),
                Text(
                  "Recovery phrase",
                  style: isDesktop
                      ? STextStyles.desktopH2(context)
                      : STextStyles.pageTitleH1(context),
                ),
                SizedBox(
                  height: isDesktop ? 16 : 8,
                ),
                Text(
                  "Enter your $_seedWordCount-word recovery phrase.",
                  style: isDesktop
                      ? STextStyles.desktopSubtitleH2(context)
                      : STextStyles.subtitle(context),
                ),
                SizedBox(
                  height: isDesktop ? 16 : 10,
                ),
                if (!isDesktop)
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          left: 4,
                          right: 16,
                          bottom: 4,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (int i = 1; i <= _seedWordCount; i++)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 22.0),
                                      child: SizedBox(
                                        width: 24,
                                        child: Text(
                                          "$i",
                                          style: STextStyles.bodySmall(context)
                                              .copyWith(
                                            color: _getColor(
                                                _inputStatuses[i - 1],
                                                _focusNodes[i - 1].hasFocus),
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              key: Key(
                                                  "restoreMnemonicFormField_$i"),
                                              decoration:
                                                  _getInputDecorationFor(
                                                      _inputStatuses[i - 1],
                                                      _focusNodes[i - 1]
                                                          .hasFocus),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              selectionControls: i == 1
                                                  ? textSelectionControls
                                                  : null,
                                              focusNode: _focusNodes[i - 1],
                                              onChanged: (value) {
                                                if (value.isEmpty) {
                                                  setState(() {
                                                    _inputStatuses[i - 1] =
                                                        FormInputStatus.empty;
                                                  });
                                                } else if (_isValidMnemonicWord(
                                                    value
                                                        .trim()
                                                        .toLowerCase())) {
                                                  setState(() {
                                                    _inputStatuses[i - 1] =
                                                        FormInputStatus.valid;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _inputStatuses[i - 1] =
                                                        FormInputStatus.invalid;
                                                  });
                                                }
                                              },
                                              controller: _controllers[i - 1],
                                              style: STextStyles.body(context),
                                            ),
                                          ),
                                          if (_inputStatuses[i - 1] ==
                                              FormInputStatus.invalid)
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  bottom: 4.0,
                                                ),
                                                child: Text(
                                                  "Please check spelling",
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      STextStyles.label(context)
                                                          .copyWith(
                                                    color: Theme.of(context)
                                                        .extension<
                                                            StackColors>()!
                                                        .accentColorRed,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                  ],
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  left: 24,
                                  right: 24,
                                  bottom: 16,
                                ),
                                child: PrimaryButton(
                                  onPressed: attemptRestore,
                                  label: "RESTORE",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
