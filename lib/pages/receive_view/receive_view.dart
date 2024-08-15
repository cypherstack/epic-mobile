import 'dart:async';

import 'package:epicpay/pages/home_view/sub_widgets/connection_status_bar.dart';
import 'package:epicpay/pages/settings_views/epicbox_settings_view/epicbox_settings_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/network_settings_view.dart';
import 'package:epicpay/pages/settings_views/settings_view.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/services/event_bus/events/global/epicbox_status_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/refresh_percent_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import 'package:epicpay/services/event_bus/global_event_bus.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/custom_loading_overlay.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveView extends ConsumerStatefulWidget {
  const ReceiveView({
    Key? key,
    required this.coin,
    required this.walletId,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/receiveView";

  final Coin coin;
  final String walletId;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends ConsumerState<ReceiveView> {
  late final Coin coin;
  late final String walletId;
  late final ClipboardInterface clipboard;

  late double _percent;

  late final EventBus eventBus;

  late WalletSyncStatus _currentSyncStatus;
  late EpicBoxStatus _currentEpicBoxStatus;

  late StreamSubscription<dynamic> _syncStatusSubscription;
  late StreamSubscription<dynamic> _epicBoxStatusSubscription;
  // late StreamSubscription<dynamic> _nodeStatusSubscription;
  late StreamSubscription<dynamic> _refreshSubscription;

  Future<void> generateNewAddress() async {
    bool shouldPop = false;
    unawaited(
      showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => shouldPop,
            child: Container(
              color: Theme.of(context)
                  .extension<StackColors>()!
                  .overlay
                  .withOpacity(0.5),
              child: const CustomLoadingOverlay(
                message: "Generating address",
                eventBus: null,
              ),
            ),
          );
        },
      ),
    );

    await ref.read(walletProvider)!.currentReceivingAddress;

    shouldPop = true;

    if (mounted) {
      Navigator.of(context)
          .popUntil(ModalRoute.withName(ReceiveView.routeName));
    }
  }

  String receivingAddress = "";

  String assetName = Assets.svg.copy;
  void onCopy() {
    setState(() {
      assetName = Assets.svg.check;
    });
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          assetName = Assets.svg.copy;
        });
      }
    });
  }

  @override
  void initState() {
    walletId = widget.walletId;
    coin = widget.coin;
    clipboard = widget.clipboard;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final address = await ref.read(walletProvider)!.currentReceivingAddress;
      if (mounted) {
        setState(() {
          receivingAddress = address;
        });
      }
    });

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

    eventBus = GlobalEventBus.instance;

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
    _epicBoxStatusSubscription.cancel();
    _syncStatusSubscription.cancel();
    _refreshSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    final width = MediaQuery.of(context).size.width;

    ref.listen(
      walletProvider.select((value) => value!.currentReceivingAddress),
      (previous, next) {
        next.then((value) {
          if (mounted) {
            setState(() => receivingAddress = value);
          }
        });
      },
    );

    return Background(
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
          Positioned.fill(
            child: Scaffold(
              backgroundColor:
                  Theme.of(context).extension<StackColors>()!.background,
              appBar: AppBar(
                leading: AppBarIconButton(
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF222227),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.arrowLeft,
                        width: 24,
                        height: 24,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textMedium,
                      ),
                    ),
                  ),
                  onPressed: Navigator.of(context).pop,
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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Text(
                    "My Wallet",
                    style: STextStyles.titleH3(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .buttonBackPrimary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Receive Epic to this address:",
                    style: STextStyles.smallMed14(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: width < 350 ? 10 : 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: QrImage(
                                data: "${coin.uriScheme}:$receivingAddress",
                                size: width / 2,
                                foregroundColor: Theme.of(context)
                                    .extension<StackColors>()!
                                    .accentColorDark),
                          ),
                          SizedBox(
                            height: width < 350 ? 10 : 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              clipboard.setData(
                                ClipboardData(text: receivingAddress),
                              );
                              onCopy();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: RoundedWhiteContainer(
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            receivingAddress,
                                            style: STextStyles.itemSubtitle12(
                                                context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    SvgPicture.asset(
                                      assetName,
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .textMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
