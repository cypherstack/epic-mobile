import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/exchange_view/sub_widgets/exchange_rate_sheet.dart';
import 'package:epicmobile/pages/exchange_view/wallet_initiated_exchange_view.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/desktop_wallet_summary.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/my_wallet.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/network_info_button.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/recent_desktop_transactions.dart';
import 'package:epicmobile/pages_desktop_specific/home/my_stack_view/wallet_view/sub_widgets/wallet_keys_button.dart';
import 'package:epicmobile/providers/global/auto_swb_service_provider.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/providers/ui/transaction_filter_provider.dart';
import 'package:epicmobile/services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import 'package:epicmobile/services/event_bus/global_event_bus.dart';
import 'package:epicmobile/services/exchange/change_now/change_now_exchange.dart';
import 'package:epicmobile/services/exchange/exchange_data_loading_service.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/enums/backup_frequency_type.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/logger.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/desktop/desktop_app_bar.dart';
import 'package:epicmobile/widgets/desktop/desktop_scaffold.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';
import 'package:epicmobile/widgets/hover_text_field.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:epicmobile/widgets/stack_dialog.dart';
import 'package:tuple/tuple.dart';

/// [eventBus] should only be set during testing
class DesktopWalletView extends ConsumerStatefulWidget {
  const DesktopWalletView({
    Key? key,
    required this.walletId,
    this.eventBus,
  }) : super(key: key);

  static const String routeName = "/desktopWalletView";

  final String walletId;
  final EventBus? eventBus;

  @override
  ConsumerState<DesktopWalletView> createState() => _DesktopWalletViewState();
}

class _DesktopWalletViewState extends ConsumerState<DesktopWalletView> {
  late final TextEditingController controller;
  late final String walletId;
  late final EventBus eventBus;

  late final bool _shouldDisableAutoSyncOnLogOut;

  final _cnLoadingService = ExchangeDataLoadingService();

  Future<void> onBackPressed() async {
    await _logout();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _logout() async {
    final managerProvider =
        ref.read(walletsChangeNotifierProvider).getManagerProvider(walletId);
    if (_shouldDisableAutoSyncOnLogOut) {
      // disable auto sync if it was enabled only when loading wallet
      ref.read(managerProvider).shouldAutoSync = false;
    }
    ref.read(managerProvider.notifier).isActiveWallet = false;
    ref.read(transactionFilterProvider.state).state = null;
    if (ref.read(prefsChangeNotifierProvider).isAutoBackupEnabled &&
        ref.read(prefsChangeNotifierProvider).backupFrequencyType ==
            BackupFrequencyType.afterClosingAWallet) {
      unawaited(ref.read(autoSWBServiceProvider).doBackup());
    }
  }

  void _loadCNData() {
    // unawaited future
    if (ref.read(prefsChangeNotifierProvider).externalCalls) {
      _cnLoadingService.loadAll(ref,
          coin: ref
              .read(walletsChangeNotifierProvider)
              .getManager(walletId)
              .coin);
    } else {
      Logging.instance.log("User does not want to use external calls",
          level: LogLevel.Info);
    }
  }

  void _onExchangePressed(BuildContext context) async {
    final managerProvider =
        ref.read(walletsChangeNotifierProvider).getManagerProvider(walletId);
    unawaited(_cnLoadingService.loadAll(ref));

    final coin = ref.read(managerProvider).coin;

    if (coin == Coin.epicCash) {
      await showDialog<void>(
        context: context,
        builder: (_) => const StackOkDialog(
          title: "Exchange not available for Epic Cash",
        ),
      );
    } else if (coin.name.endsWith("TestNet")) {
      await showDialog<void>(
        context: context,
        builder: (_) => const StackOkDialog(
          title: "Exchange not available for test net coins",
        ),
      );
    } else {
      ref.read(currentExchangeNameStateProvider.state).state =
          ChangeNowExchange.exchangeName;
      final walletId = ref.read(managerProvider).walletId;
      ref.read(prefsChangeNotifierProvider).exchangeRateType =
          ExchangeRateType.estimated;

      ref.read(exchangeFormStateProvider).exchange = ref.read(exchangeProvider);
      ref.read(exchangeFormStateProvider).exchangeType =
          ExchangeRateType.estimated;

      final currencies = ref
          .read(availableChangeNowCurrenciesProvider)
          .currencies
          .where((element) =>
              element.ticker.toLowerCase() == coin.ticker.toLowerCase());

      if (currencies.isNotEmpty) {
        ref.read(exchangeFormStateProvider).setCurrencies(
              currencies.first,
              ref
                  .read(availableChangeNowCurrenciesProvider)
                  .currencies
                  .firstWhere(
                    (element) =>
                        element.ticker.toLowerCase() !=
                        coin.ticker.toLowerCase(),
                  ),
            );
      }

      if (mounted) {
        unawaited(
          Navigator.of(context).pushNamed(
            WalletInitiatedExchangeView.routeName,
            arguments: Tuple3(
              walletId,
              coin,
              _loadCNData,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    controller = TextEditingController();
    walletId = widget.walletId;
    final managerProvider =
        ref.read(walletsChangeNotifierProvider).getManagerProvider(walletId);

    controller.text = ref.read(managerProvider).walletName;

    eventBus =
        widget.eventBus != null ? widget.eventBus! : GlobalEventBus.instance;

    ref.read(managerProvider).isActiveWallet = true;
    if (!ref.read(managerProvider).shouldAutoSync) {
      // enable auto sync if it wasn't enabled when loading wallet
      ref.read(managerProvider).shouldAutoSync = true;
      _shouldDisableAutoSyncOnLogOut = true;
    } else {
      _shouldDisableAutoSyncOnLogOut = false;
    }

    ref.read(managerProvider).refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(walletsChangeNotifierProvider
        .select((value) => value.getManager(walletId)));
    final coin = manager.coin;
    final managerProvider = ref.watch(walletsChangeNotifierProvider
        .select((value) => value.getManagerProvider(walletId)));

    return DesktopScaffold(
      appBar: DesktopAppBar(
        background: Theme.of(context).extension<StackColors>()!.popupBG,
        leading: Expanded(
          child: Row(
            children: [
              const SizedBox(
                width: 32,
              ),
              AppBarIconButton(
                size: 32,
                color: Theme.of(context)
                    .extension<StackColors>()!
                    .textFieldDefaultBG,
                shadows: const [],
                icon: SvgPicture.asset(
                  Assets.svg.arrowLeft,
                  width: 18,
                  height: 18,
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .topNavIconPrimary,
                ),
                onPressed: onBackPressed,
              ),
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                Assets.svg.iconFor(coin: coin),
                width: 32,
                height: 32,
              ),
              const SizedBox(
                width: 12,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 48,
                ),
                child: IntrinsicWidth(
                  child: HoverTextField(
                    controller: controller,
                    style: STextStyles.desktopH3(context),
                    readOnly: true,
                    onDone: () async {
                      final currentWalletName =
                          ref.read(managerProvider).walletName;
                      final newName = controller.text;
                      if (newName != currentWalletName) {
                        final success = await ref
                            .read(walletsServiceChangeNotifierProvider)
                            .renameWallet(
                              from: currentWalletName,
                              to: newName,
                              shouldNotifyListeners: true,
                            );
                        if (success) {
                          ref
                              .read(walletsChangeNotifierProvider)
                              .getManager(walletId)
                              .walletName = newName;
                          unawaited(
                            showFloatingFlushBar(
                              type: FlushBarType.success,
                              message: "Wallet renamed",
                              context: context,
                            ),
                          );
                        } else {
                          unawaited(
                            showFloatingFlushBar(
                              type: FlushBarType.warning,
                              message:
                                  "Wallet named \"$newName\" already exists",
                              context: context,
                            ),
                          );
                          controller.text = currentWalletName;
                        }
                      }
                    },
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  NetworkInfoButton(
                    walletId: walletId,
                    eventBus: eventBus,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  WalletKeysButton(
                    walletId: walletId,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
            ],
          ),
        ),
        useSpacers: false,
        isCompactHeight: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            RoundedWhiteContainer(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.iconFor(coin: coin),
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DesktopWalletSummary(
                    walletId: walletId,
                    managerProvider: managerProvider,
                    initialSyncStatus: ref.watch(managerProvider
                            .select((value) => value.isRefreshing))
                        ? WalletSyncStatus.syncing
                        : WalletSyncStatus.synced,
                  ),
                  const Spacer(),
                  SecondaryButton(
                    width: 180,
                    desktopMed: true,
                    onPressed: () {
                      _onExchangePressed(context);
                    },
                    label: "Exchange",
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .buttonBackPrimary
                            .withOpacity(0.2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.arrowRotate2,
                          width: 14,
                          height: 14,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .buttonTextSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 450,
                    child: MyWallet(
                      walletId: walletId,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: RecentDesktopTransactions(
                      walletId: walletId,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
