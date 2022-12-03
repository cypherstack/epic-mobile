import 'dart:async';

import 'package:epicmobile/models/node_model.dart';
import 'package:epicmobile/pages/settings_views/network_settings_view/manage_nodes_views/node_details_view.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/default_nodes.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/enums/sync_type_enum.dart';
import 'package:epicmobile/utilities/logger.dart';
import 'package:epicmobile/utilities/test_epic_box_connection.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';

class NodeOptionsSheet extends ConsumerWidget {
  const NodeOptionsSheet({
    Key? key,
    required this.nodeId,
    required this.coin,
    required this.popBackToRoute,
  }) : super(key: key);

  final String nodeId;
  final Coin coin;
  final String popBackToRoute;

  Future<void> _notifyWalletsOfUpdatedNode(WidgetRef ref) async {
    final managers = [ref.read(walletProvider)!];
    final prefs = ref.read(prefsChangeNotifierProvider);

    switch (prefs.syncType) {
      case SyncingType.currentWalletOnly:
        for (final manager in managers) {
          if (manager.isActiveWallet) {
            manager.updateNode(true);
          } else {
            manager.updateNode(false);
          }
        }
        break;
      case SyncingType.selectedWalletsAtStartup:
        final List<String> walletIdsToSync = prefs.walletIdsSyncOnStartup;
        for (final manager in managers) {
          if (walletIdsToSync.contains(manager.walletId)) {
            manager.updateNode(true);
          } else {
            manager.updateNode(false);
          }
        }
        break;
      case SyncingType.allWalletsOnStartup:
        for (final manager in managers) {
          manager.updateNode(true);
        }
        break;
    }
  }

  Future<bool> _testConnection(
      NodeModel node, BuildContext context, WidgetRef ref) async {
    bool testPassed = false;

    switch (coin) {
      case Coin.epicCash:
        try {
          final String uriString = "${node.host}:${node.port}/v1/version";

          testPassed = await testEpicBoxNodeConnection(Uri.parse(uriString));
        } catch (e, s) {
          Logging.instance.log("$e\n$s", level: LogLevel.Warning);
        }
        break;
    }

    if (testPassed) {
      // showFloatingFlushBar(
      //   type: FlushBarType.success,
      //   message: "Server ping success",
      //   context: context,
      // );
    } else {
      // unawaited(showFloatingFlushBar(
      //   type: FlushBarType.warning,
      //   iconAsset: Assets.svg.circleAlert,
      //   message: "Could not connect to node",
      //   context: context,
      // ));
    }

    return testPassed;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxHeight = MediaQuery.of(context).size.height * 0.60;
    final node = ref.watch(nodeServiceChangeNotifierProvider
        .select((value) => value.getNodeById(id: nodeId)))!;

    final status = ref
                .watch(nodeServiceChangeNotifierProvider
                    .select((value) => value.getPrimaryNodeFor(coin: coin)))
                ?.id !=
            nodeId
        ? "Disconnected"
        : "Connected";

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<StackColors>()!.popupBG,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: LimitedBox(
        maxHeight: maxHeight,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 10,
            bottom: 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .textFieldDefaultBG,
                      borderRadius: BorderRadius.circular(
                        Constants.size.circularBorderRadius,
                      ),
                    ),
                    width: 60,
                    height: 4,
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Text(
                  "Node options",
                  style: STextStyles.pageTitleH2(context),
                  textAlign: TextAlign.left,
                ),
                RoundedWhiteContainer(
                  padding: const EdgeInsets.symmetric(vertical: 38),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: node.name == DefaultNodes.defaultName
                              ? Theme.of(context)
                                  .extension<StackColors>()!
                                  .textSubtitle4
                              : Theme.of(context)
                                  .extension<StackColors>()!
                                  .infoItemIcons
                                  .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.node,
                            height: 15,
                            width: 19,
                            color: node.name == DefaultNodes.defaultName
                                ? Theme.of(context)
                                    .extension<StackColors>()!
                                    .accentColorDark
                                : Theme.of(context)
                                    .extension<StackColors>()!
                                    .infoItemIcons,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            node.name,
                            style: STextStyles.bodyBold(context),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            status,
                            style: STextStyles.label(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.svg.network,
                        color: status == "Connected"
                            ? Theme.of(context)
                                .extension<StackColors>()!
                                .accentColorGreen
                            : Theme.of(context)
                                .extension<StackColors>()!
                                .buttonBackSecondary,
                        width: 18,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // if (!node.id.startsWith("default"))
                    Expanded(
                      child: TextButton(
                        style: Theme.of(context)
                            .extension<StackColors>()!
                            .getSecondaryEnabledButtonColor(context),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(
                            NodeDetailsView.routeName,
                            arguments: Tuple3(
                              coin,
                              node.id,
                              popBackToRoute,
                            ),
                          );
                        },
                        child: Text(
                          "Details",
                          style: STextStyles.button(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .accentColorDark),
                        ),
                      ),
                    ),
                    // if (!node.id.startsWith("default"))
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextButton(
                        style: status == "Connected"
                            ? Theme.of(context)
                                .extension<StackColors>()!
                                .getPrimaryDisabledButtonColor(context)
                            : Theme.of(context)
                                .extension<StackColors>()!
                                .getPrimaryEnabledButtonColor(context),
                        onPressed: status == "Connected"
                            ? null
                            : () async {
                                final canConnect =
                                    await _testConnection(node, context, ref);
                                if (!canConnect) {
                                  return;
                                }

                                await ref
                                    .read(nodeServiceChangeNotifierProvider)
                                    .setPrimaryNodeFor(
                                      coin: coin,
                                      node: node,
                                      shouldNotifyListeners: true,
                                    );

                                await _notifyWalletsOfUpdatedNode(ref);
                              },
                        child: Text(
                          // status == "Connected" ? "Disconnect" : "Connect",
                          "Connect",
                          style: STextStyles.button(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}