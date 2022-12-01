import 'dart:async';
import 'dart:math';

import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/add_wallet_views/new_wallet_recovery_phrase_view/new_wallet_recovery_phrase_view.dart';
import 'package:epicmobile/pages/add_wallet_views/verify_recovery_phrase_view/sub_widgets/word_table.dart';
import 'package:epicmobile/pages/home_view/home_view.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/services/coins/manager.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/desktop/desktop_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class VerifyRecoveryPhraseView extends ConsumerStatefulWidget {
  const VerifyRecoveryPhraseView({
    Key? key,
    required this.manager,
    required this.mnemonic,
  }) : super(key: key);

  static const routeName = "/verifyRecoveryPhrase";

  final Manager manager;
  final List<String> mnemonic;

  @override
  ConsumerState<VerifyRecoveryPhraseView> createState() =>
      _VerifyRecoveryPhraseViewState();
}

class _VerifyRecoveryPhraseViewState
    extends ConsumerState<VerifyRecoveryPhraseView>
// with WidgetsBindingObserver
{
  late Manager _manager;
  late List<String> _mnemonic;
  late final bool isDesktop;

  @override
  void initState() {
    _manager = widget.manager;
    _mnemonic = widget.mnemonic;
    isDesktop = Util.isDesktop;
    // WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  dispose() {
    // WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       debugPrint(
  //           "VerifyRecoveryPhraseView ========================= Inactive");
  //       break;
  //     case AppLifecycleState.paused:
  //       debugPrint("VerifyRecoveryPhraseView ========================= Paused");
  //       break;
  //     case AppLifecycleState.resumed:
  //       debugPrint(
  //           "VerifyRecoveryPhraseView ========================= Resumed");
  //       break;
  //     case AppLifecycleState.detached:
  //       debugPrint(
  //           "VerifyRecoveryPhraseView ========================= Detached");
  //       break;
  //   }
  // }

  Future<void> _continue(bool isMatch) async {
    if (isMatch) {
      await ref.read(walletsServiceChangeNotifierProvider).setMnemonicVerified(
            walletId: _manager.walletId,
          );

      ref
          .read(walletsChangeNotifierProvider.notifier)
          .addWallet(walletId: _manager.walletId, manager: _manager);

      if (mounted) {
        if (isDesktop) {
        } else {
          unawaited(
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeView.routeName,
              (route) => false,
            ),
          );
        }
      }

      unawaited(showFloatingFlushBar(
        type: FlushBarType.success,
        message: "Correct! Your wallet is set up.",
        iconAsset: Assets.svg.check,
        context: context,
      ));
    } else {
      unawaited(showFloatingFlushBar(
        type: FlushBarType.warning,
        message: "Incorrect. Please try again.",
        iconAsset: Assets.svg.circleX,
        context: context,
      ));

      final int next = Random().nextInt(_mnemonic.length);
      ref
          .read(verifyMnemonicWordIndexStateProvider.state)
          .update((state) => next);

      ref
          .read(verifyMnemonicCorrectWordStateProvider.state)
          .update((state) => _mnemonic[next]);

      ref
          .read(verifyMnemonicSelectedWordStateProvider.state)
          .update((state) => "");
    }
  }

  Tuple2<List<String>, String> randomize(
      List<String> mnemonic, int chosenIndex, int wordsToShow) {
    final List<String> remaining = [];
    final String chosenWord = mnemonic[chosenIndex];

    for (int i = 0; i < mnemonic.length; i++) {
      if (chosenWord != mnemonic[i]) {
        remaining.add(mnemonic[i]);
      }
    }

    final random = Random();

    final List<String> result = [];

    for (int i = 0; i < wordsToShow - 1; i++) {
      final randomIndex = random.nextInt(remaining.length);
      result.add(remaining.removeAt(randomIndex));
    }

    result.insert(random.nextInt(wordsToShow), chosenWord);

    debugPrint("Mnemonic game correct word: $chosenWord");

    return Tuple2(result, chosenWord);
  }

  Future<bool> onWillPop() async {
    // await delete();
    Navigator.of(context).popUntil(
      ModalRoute.withName(
        // NewWalletRecoveryPhraseWarningView.routeName,
        NewWalletRecoveryPhraseView.routeName,
      ),
    );
    return false;
  }

  Future<void> delete() async {
    await ref
        .read(walletsServiceChangeNotifierProvider)
        .deleteWallet(_manager.walletName, false);
    await _manager.exitCurrentWallet();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    final correctIndex =
        ref.watch(verifyMnemonicWordIndexStateProvider.state).state;

    return WillPopScope(
      onWillPop: onWillPop,
      child: MasterScaffold(
        isDesktop: isDesktop,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () async {
              Navigator.of(context).popUntil(
                ModalRoute.withName(
                  NewWalletRecoveryPhraseView.routeName,
                ),
              );
            },
          ),
        ),
        body: SizedBox(
          width: isDesktop ? 410 : null,
          child: Padding(
            padding:
                isDesktop ? const EdgeInsets.all(0) : const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isDesktop)
                  const Spacer(
                    flex: 10,
                  ),
                SizedBox(
                  height: isDesktop ? 24 : 4,
                ),
                Text(
                  "Verify recovery phrase",
                  textAlign: TextAlign.center,
                  style: isDesktop
                      ? STextStyles.desktopH2(context)
                      : STextStyles.label(context).copyWith(
                          fontSize: 12,
                        ),
                ),
                SizedBox(
                  height: isDesktop ? 16 : 4,
                ),
                Text(
                  isDesktop ? "Select word number" : "Tap word number ",
                  textAlign: TextAlign.center,
                  style: isDesktop
                      ? STextStyles.desktopSubtitleH1(context)
                      : STextStyles.pageTitleH1(context),
                ),
                SizedBox(
                  height: isDesktop ? 16 : 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .extension<StackColors>()!
                        .textFieldDefaultBG,
                    borderRadius: BorderRadius.circular(
                        Constants.size.circularBorderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Text(
                      "${correctIndex + 1}",
                      textAlign: TextAlign.center,
                      style: STextStyles.subtitle600(context).copyWith(
                        fontSize: 32,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ),
                if (isDesktop)
                  const SizedBox(
                    height: 40,
                  ),
                WordTable(
                  words: randomize(_mnemonic, correctIndex, 9).item1,
                  isDesktop: isDesktop,
                ),
                if (!isDesktop) const Spacer(),
                if (isDesktop)
                  const SizedBox(
                    height: 40,
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer(
                        builder: (_, ref, __) {
                          final selectedWord = ref
                              .watch(
                                  verifyMnemonicSelectedWordStateProvider.state)
                              .state;
                          final correctWord = ref
                              .watch(
                                  verifyMnemonicCorrectWordStateProvider.state)
                              .state;

                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: isDesktop ? 70 : 0,
                            ),
                            child: TextButton(
                              onPressed: selectedWord.isNotEmpty
                                  ? () async {
                                      await _continue(
                                          correctWord == selectedWord);
                                    }
                                  : null,
                              style: selectedWord.isNotEmpty
                                  ? Theme.of(context)
                                      .extension<StackColors>()!
                                      .getPrimaryEnabledButtonColor(context)
                                  : Theme.of(context)
                                      .extension<StackColors>()!
                                      .getPrimaryDisabledButtonColor(context),
                              child: isDesktop
                                  ? Text(
                                      "Verify",
                                      style: selectedWord.isNotEmpty
                                          ? STextStyles.desktopButtonEnabled(
                                              context)
                                          : STextStyles.desktopButtonDisabled(
                                              context),
                                    )
                                  : Text(
                                      "Continue",
                                      style: STextStyles.button(context),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (isDesktop)
                  const Spacer(
                    flex: 15,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
