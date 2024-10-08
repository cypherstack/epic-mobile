import 'dart:async';

import 'package:epicpay/pages/buy_view/buy_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_view.dart';
import 'package:epicpay/pages/help/help_view.dart';
import 'package:epicpay/pages/home_view/sub_widgets/connection_status_bar.dart';
import 'package:epicpay/pages/pay_view/pay_qr.dart';
import 'package:epicpay/pages/settings_views/epicbox_settings_view/epicbox_settings_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/network_settings_view.dart';
import 'package:epicpay/pages/settings_views/settings_view.dart';
import 'package:epicpay/pages/wallet_view/wallet_view.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/providers/ui/home_view_index_provider.dart';
import 'package:epicpay/services/event_bus/events/global/epicbox_status_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/refresh_percent_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import 'package:epicpay/services/event_bus/global_event_bus.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/stack_dialog.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    Key? key,
    this.eventBus,
  }) : super(key: key);

  final EventBus? eventBus;

  static const routeName = "/home";

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late final PageController _pageController;

  late final List<Widget> _children;

  DateTime? _cachedTime;

  bool _exitEnabled = false;

  late double _percent;

  late final EventBus eventBus;

  late WalletSyncStatus _currentSyncStatus;
  late EpicBoxStatus _currentEpicBoxStatus;

  late StreamSubscription<dynamic> _syncStatusSubscription;
  late StreamSubscription<dynamic> _epicBoxStatusSubscription;
  // late StreamSubscription<dynamic> _nodeStatusSubscription;
  late StreamSubscription<dynamic> _refreshSubscription;

  bool _pageLock = false;

  Future<bool> _onWillPop() async {
    // go to home view when tapping back on the main exchange view
    if (ref.read(homeViewPageIndexStateProvider.state).state != 0) {
      ref.read(homeViewPageIndexStateProvider.state).state = 0;
      return false;
    }

    if (_exitEnabled) {
      return true;
    }

    final now = DateTime.now();
    const timeout = Duration(milliseconds: 1500);
    if (_cachedTime == null || now.difference(_cachedTime!) > timeout) {
      _cachedTime = now;
      await showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async {
            _exitEnabled = true;
            return true;
          },
          child: const StackDialog(title: "Tap back again to exit"),
        ),
      ).timeout(
        timeout,
        onTimeout: () {
          _exitEnabled = false;
          Navigator.of(context).pop();
        },
      );
    }
    return _exitEnabled;
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _children = [
      WalletView(
        walletId: ref.read(walletProvider)!.walletId,
      ),
      if (Constants.enableExchange) const ExchangeView(),
      if (Constants.enableExchange)
        BuyView(
          walletId: ref.read(walletProvider)!.walletId,
          coin: ref.read(walletProvider)!.coin,
        ),
      PayView(
        walletId: ref.read(walletProvider)!.walletId,
        coin: ref.read(walletProvider)!.coin,
      ),
    ];

    if (ref.read(walletProvider)!.isRefreshing) {
      _currentSyncStatus = WalletSyncStatus.syncing;
    } else {
      _currentSyncStatus = WalletSyncStatus.synced;
      if (ref.read(walletProvider)!.isConnected) {
      } else {
        _currentSyncStatus = WalletSyncStatus.unableToSync;
      }
    }

    if (ref.read(walletProvider)!.isEpicBoxConnected) {
      _currentEpicBoxStatus = EpicBoxStatus.connected;
    } else {
      _currentEpicBoxStatus = EpicBoxStatus.unableToConnect;
    }

    if (_currentSyncStatus == WalletSyncStatus.synced) {
      _percent = 1;
    } else {
      _percent = 0;
    }

    eventBus = widget.eventBus ?? GlobalEventBus.instance;
    // eventBus.on<UpdatedInBackgroundEvent>().listen((event) async {
    //   final count = ref.read(txCountOnStartUpProvider.state).state ?? 0;
    //   final newCount = ref.read(walletProvider)!.txCount;
    //   if (count < newCount) {
    //     ref.read(txCountOnStartUpProvider.state).state = newCount;
    //     await Messages.of(context).show(
    //       context: context,
    //       widget: RoundedContainer(
    //         color: Theme.of(context).extension<StackColors>()!.coal,
    //         child: Center(
    //           child: Text(
    //             "New transaction",
    //             style: STextStyles.bodySmallBold(context).copyWith(
    //               color: Theme.of(context).extension<StackColors>()!.textMedium,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // });

    _syncStatusSubscription =
        eventBus.on<WalletSyncStatusChangedEvent>().listen(
      (event) async {
        if (event.walletId == ref.read(walletProvider)!.walletId) {
          setState(() {
            _currentSyncStatus = event.newStatus;
          });
        }
      },
    );

    _refreshSubscription = eventBus.on<RefreshPercentChangedEvent>().listen(
      (event) async {
        if (event.walletId == ref.read(walletProvider)!.walletId) {
          setState(() {
            _percent = event.percent.clamp(0.0, 1.0);
          });
        }
      },
    );

    _epicBoxStatusSubscription =
        eventBus.on<EpicBoxStatusChangedEvent>().listen(
      (event) async {
        if (event.walletId == ref.read(walletProvider)!.walletId) {
          setState(() {
            _currentEpicBoxStatus = event.newStatus;
          });
        }
      },
    );

    super.initState();
  }

  @override
  dispose() {
    // _nodeStatusSubscription.cancel();
    _epicBoxStatusSubscription.cancel();
    _syncStatusSubscription.cancel();
    _refreshSubscription.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    ref.listen(homeViewPageIndexStateProvider, (previous, next) {
      if (!_pageLock) {
        if ((previous != null && (previous - next).abs() <= 1) ||
            previous == null) {
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        } else {
          _pageController.jumpToPage(next);
        }

        ref.read(prevHomeViewPageIndexStateProvider.state).state =
            previous ?? 0;
      }
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Background(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        SvgPicture.asset(
                          Assets.svg.epicBG,
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Scaffold(
                backgroundColor:
                    Theme.of(context).extension<StackColors>()!.background,
                key: _key,
                appBar: AppBar(
                  leading: AppBarIconButton(
                    icon: SvgPicture.asset(
                      Assets.svg.circleQuestion,
                      width: 22,
                      height: 22,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(HelpView.routeName),
                  ),
                  centerTitle: true,
                  title: SizedBox(
                    height: 32,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            _currentEpicBoxStatus == EpicBoxStatus.connected
                                ? NetworkSettingsView.routeName
                                : EpicBoxSettingsView.routeName);
                      },
                      child: ConnectionStatusBar(
                        currentSyncPercent: _percent,
                        color: Theme.of(context).extension<StackColors>()!.coal,
                        background:
                            Theme.of(context).extension<StackColors>()!.popupBG,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AppBarIconButton(
                          key: const Key("walletsViewSettingsButton"),
                          size: 36,
                          shadows: const [],
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .background,
                          icon: SvgPicture.asset(
                            Assets.svg.menu,
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .topNavIconPrimary,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            debugPrint("main view settings tapped");
                            Navigator.of(context)
                                .pushNamed(SettingsView.routeName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  height: 75,
                  child: BottomNavigationBar(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    unselectedFontSize: 14.0,
                    unselectedLabelStyle: STextStyles.smallMed12(context)
                        .copyWith(
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .bottomNavText),
                    backgroundColor:
                        Theme.of(context).extension<StackColors>()!.popupBG,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(Assets.svg.walletHome),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            Assets.svg.walletHome,
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .buttonBackPrimary,
                          ),
                        ),
                        label: 'WALLET',
                      ),
                      if (Constants.enableExchange)
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Assets.svg.swapArrows),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              Assets.svg.swapArrows,
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .buttonBackPrimary,
                            ),
                          ),
                          label: 'SWAP',
                        ),
                      if (Constants.enableExchange)
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Assets.svg.buy),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              Assets.svg.buy,
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .buttonBackPrimary,
                            ),
                          ),
                          label: 'BUY',
                        ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            Assets.svg.pay,
                          ),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            Assets.svg.pay,
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .buttonBackPrimary,
                          ),
                        ),
                        label: 'PAY',
                      ),
                    ],
                    onTap: (value) => ref
                        .read(homeViewPageIndexStateProvider.state)
                        .state = value,
                    currentIndex:
                        ref.watch(homeViewPageIndexStateProvider.state).state,
                    selectedItemColor: Theme.of(context)
                        .extension<StackColors>()!
                        .buttonBackPrimary,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: _children,
                        onPageChanged: (pageIndex) {
                          _pageLock = true;
                          if (pageIndex !=
                              ref
                                  .read(
                                      prevHomeViewPageIndexStateProvider.state)
                                  .state) {
                            ref
                                    .read(prevHomeViewPageIndexStateProvider.state)
                                    .state =
                                ref
                                    .read(homeViewPageIndexStateProvider.state)
                                    .state;
                          }
                          ref.read(homeViewPageIndexStateProvider.state).state =
                              pageIndex;
                          _pageLock = false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
