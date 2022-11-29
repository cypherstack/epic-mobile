import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/electrumx_rpc/electrumx.dart';
import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/settings_views/global_settings_view/manage_nodes_views/add_edit_node_view.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/flutter_secure_storage_interface.dart';
import 'package:epicmobile/utilities/logger.dart';
import 'package:epicmobile/utilities/test_epic_box_connection.dart';
import 'package:epicmobile/utilities/test_monero_node_connection.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/conditional_parent.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/desktop/delete_button.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog.dart';
import 'package:epicmobile/widgets/desktop/primary_button.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';
import 'package:tuple/tuple.dart';

class NodeDetailsView extends ConsumerStatefulWidget {
  const NodeDetailsView({
    Key? key,
    required this.coin,
    required this.nodeId,
    required this.popRouteName,
    this.secureStore = const SecureStorageWrapper(
      FlutterSecureStorage(),
    ),
  }) : super(key: key);

  static const String routeName = "/nodeDetails";

  final FlutterSecureStorageInterface secureStore;
  final Coin coin;
  final String nodeId;
  final String popRouteName;

  @override
  ConsumerState<NodeDetailsView> createState() => _NodeDetailsViewState();
}

class _NodeDetailsViewState extends ConsumerState<NodeDetailsView> {
  late final FlutterSecureStorageInterface secureStore;
  late final Coin coin;
  late final String nodeId;
  late final String popRouteName;

  bool _desktopReadOnly = true;

  @override
  initState() {
    secureStore = widget.secureStore;
    coin = widget.coin;
    nodeId = widget.nodeId;
    popRouteName = widget.popRouteName;
    super.initState();
  }

  Future<void> _testConnection(WidgetRef ref, BuildContext context) async {
    final node =
        ref.watch(nodeServiceChangeNotifierProvider).getNodeById(id: nodeId);

    bool testPassed = false;

    switch (coin) {
      case Coin.epicCash:
        try {
          final uri = Uri.parse(node!.host);
          if (uri.scheme.startsWith("http")) {
            final String path = uri.path.isEmpty ? "/v1/version" : uri.path;

            String uriString = "${uri.scheme}://${uri.host}:${node.port}$path";

            testPassed = await testEpicBoxNodeConnection(Uri.parse(uriString));
          }
        } catch (e, s) {
          Logging.instance.log("$e\n$s", level: LogLevel.Warning);
          testPassed = false;
        }
        break;

      case Coin.monero:
      case Coin.wownero:
        try {
          final uri = Uri.parse(node!.host);
          if (uri.scheme.startsWith("http")) {
            final String path = uri.path.isEmpty ? "/json_rpc" : uri.path;

            String uriString = "${uri.scheme}://${uri.host}:${node.port}$path";

            final response = await testMoneroNodeConnection(
              Uri.parse(uriString),
              false,
            );

            if (response.cert != null) {
              if (mounted) {
                final shouldAllowBadCert = await showBadX509CertificateDialog(
                  response.cert!,
                  response.url!,
                  response.port!,
                  context,
                );

                if (shouldAllowBadCert) {
                  final response = await testMoneroNodeConnection(
                      Uri.parse(uriString), true);
                  testPassed = response.success;
                }
              }
            } else {
              testPassed = response.success;
            }
          }
        } catch (e, s) {
          Logging.instance.log("$e\n$s", level: LogLevel.Warning);
        }

        break;

      case Coin.bitcoin:
      case Coin.litecoin:
      case Coin.dogecoin:
      case Coin.firo:
      case Coin.bitcoinTestNet:
      case Coin.firoTestNet:
      case Coin.dogecoinTestNet:
      case Coin.bitcoincash:
      case Coin.namecoin:
      case Coin.litecoinTestNet:
      case Coin.bitcoincashTestnet:
        final client = ElectrumX(
          host: node!.host,
          port: node.port,
          useSSL: node.useSSL,
          failovers: [],
          prefs: ref.read(prefsChangeNotifierProvider),
        );

        try {
          testPassed = await client.ping();
        } catch (_) {
          testPassed = false;
        }

        break;
    }

    if (testPassed) {
      unawaited(
        showFloatingFlushBar(
          type: FlushBarType.success,
          message: "Server ping success",
          context: context,
        ),
      );
    } else {
      unawaited(
        showFloatingFlushBar(
          type: FlushBarType.warning,
          message: "Server unreachable",
          context: context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Util.isDesktop;

    final node = ref.watch(nodeServiceChangeNotifierProvider
        .select((value) => value.getNodeById(id: nodeId)));

    return ConditionalParent(
      condition: !isDesktop,
      builder: (child) => Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () async {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
                await Future<void>.delayed(const Duration(milliseconds: 75));
              }
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          title: Text(
            "Node details",
            style: STextStyles.navBarTitle(context),
          ),
          actions: [
            if (!nodeId.startsWith("default"))
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppBarIconButton(
                    key: const Key("nodeDetailsEditNodeAppBarButtonKey"),
                    size: 36,
                    shadows: const [],
                    color:
                        Theme.of(context).extension<StackColors>()!.background,
                    icon: SvgPicture.asset(
                      Assets.svg.pencil,
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .accentColorDark,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AddEditNodeView.routeName,
                        arguments: Tuple4(
                          AddEditNodeViewType.edit,
                          coin,
                          nodeId,
                          popRouteName,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight - 8),
                    child: IntrinsicHeight(
                      child: child,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      child: ConditionalParent(
        condition: isDesktop,
        builder: (child) => DesktopDialog(
          maxWidth: 580,
          maxHeight: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  const AppBarBackButton(
                    iconSize: 24,
                    size: 40,
                  ),
                  Text(
                    "Node details",
                    style: STextStyles.desktopH3(context),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 16,
                  bottom: 32,
                ),
                child: child,
              ),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NodeForm(
              node: node,
              secureStore: secureStore,
              readOnly: isDesktop ? _desktopReadOnly : true,
              coin: coin,
            ),
            if (!isDesktop) const Spacer(),
            if (isDesktop)
              const SizedBox(
                height: 22,
              ),
            if (isDesktop)
              SizedBox(
                height: 56,
                child: _desktopReadOnly
                    ? null
                    : Row(
                        children: [
                          Expanded(
                            child: DeleteButton(
                              label: "Delete node",
                              desktopMed: true,
                              onPressed: () async {
                                Navigator.of(context).pop();

                                await ref
                                    .read(nodeServiceChangeNotifierProvider)
                                    .delete(
                                      node!.id,
                                      true,
                                    );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Spacer(),
                        ],
                      ),
              ),
            if (isDesktop && !_desktopReadOnly)
              const SizedBox(
                height: 45,
              ),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: "Test connection",
                    desktopMed: true,
                    onPressed: () async {
                      await _testConnection(ref, context);
                    },
                  ),
                ),
                if (isDesktop)
                  const SizedBox(
                    width: 16,
                  ),
                if (isDesktop)
                  Expanded(
                    child: !nodeId.startsWith("default")
                        ? PrimaryButton(
                            label: _desktopReadOnly ? "Edit" : "Save",
                            desktopMed: true,
                            onPressed: () async {
                              final shouldSave = _desktopReadOnly == false;
                              setState(() {
                                _desktopReadOnly = !_desktopReadOnly;
                              });

                              if (shouldSave) {
                                // todo save node
                              }
                            },
                          )
                        : Container(),
                  ),
              ],
            ),
            if (!isDesktop)
              const SizedBox(
                height: 16,
              ),
          ],
        ),
      ),
    );
  }
}
