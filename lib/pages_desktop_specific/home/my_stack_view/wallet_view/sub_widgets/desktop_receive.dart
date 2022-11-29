import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:epicmobile/notifications/show_flush_bar.dart';
import 'package:epicmobile/pages/receive_view/generate_receiving_uri_qr_code_view.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/route_generator.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/clipboard_interface.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/enums/flush_bar_type.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/custom_loading_overlay.dart';
import 'package:epicmobile/widgets/desktop/desktop_dialog.dart';
import 'package:epicmobile/widgets/desktop/secondary_button.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:tuple/tuple.dart';

class DesktopReceive extends ConsumerStatefulWidget {
  const DesktopReceive({
    Key? key,
    required this.walletId,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  final String walletId;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<DesktopReceive> createState() => _DesktopReceiveState();
}

class _DesktopReceiveState extends ConsumerState<DesktopReceive> {
  late final Coin coin;
  late final String walletId;
  late final ClipboardInterface clipboard;

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

    await ref
        .read(walletsChangeNotifierProvider)
        .getManager(walletId)
        .generateNewAddress();

    shouldPop = true;

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  String receivingAddress = "";

  @override
  void initState() {
    walletId = widget.walletId;
    coin = ref.read(walletsChangeNotifierProvider).getManager(walletId).coin;
    clipboard = widget.clipboard;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final address = await ref
          .read(walletsChangeNotifierProvider)
          .getManager(walletId)
          .currentReceivingAddress;
      setState(() {
        receivingAddress = address;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    ref.listen(
        ref
            .read(walletsChangeNotifierProvider)
            .getManagerProvider(walletId)
            .select((value) => value.currentReceivingAddress),
        (previous, next) {
      if (next is Future<String>) {
        next.then((value) => setState(() => receivingAddress = value));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            clipboard.setData(
              ClipboardData(text: receivingAddress),
            );
            showFloatingFlushBar(
              type: FlushBarType.info,
              message: "Copied to clipboard",
              iconAsset: Assets.svg.copy,
              context: context,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).extension<StackColors>()!.background,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                Constants.size.circularBorderRadius,
              ),
            ),
            child: RoundedWhiteContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Your ${coin.ticker} address",
                        style: STextStyles.itemSubtitle(context),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.copy,
                            width: 15,
                            height: 15,
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .infoItemIcons,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Copy",
                            style: STextStyles.link2(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          receivingAddress,
                          style: STextStyles.desktopTextExtraExtraSmall(context)
                              .copyWith(
                            color: Theme.of(context)
                                .extension<StackColors>()!
                                .textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (coin != Coin.epicCash)
          const SizedBox(
            height: 20,
          ),
        if (coin != Coin.epicCash)
          SecondaryButton(
            desktopMed: true,
            onPressed: generateNewAddress,
            label: "Generate new address",
          ),
        const SizedBox(
          height: 32,
        ),
        Center(
          child: QrImage(
            data: "${coin.uriScheme}:$receivingAddress",
            size: 200,
            foregroundColor:
                Theme.of(context).extension<StackColors>()!.accentColorDark,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        // TODO: create transparent button class to account for hover
        GestureDetector(
          onTap: () async {
            if (Util.isDesktop) {
              await showDialog<void>(
                context: context,
                builder: (context) => DesktopDialog(
                  maxHeight: double.infinity,
                  maxWidth: 580,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const AppBarBackButton(
                            size: 40,
                            iconSize: 24,
                          ),
                          Text(
                            "Generate QR code",
                            style: STextStyles.desktopH3(context),
                          ),
                        ],
                      ),
                      IntrinsicHeight(
                        child: Navigator(
                          onGenerateRoute: RouteGenerator.generateRoute,
                          onGenerateInitialRoutes: (_, __) => [
                            RouteGenerator.generateRoute(
                              RouteSettings(
                                name: GenerateUriQrCodeView.routeName,
                                arguments: Tuple2(coin, receivingAddress),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              unawaited(
                Navigator.of(context).push(
                  RouteGenerator.getRoute(
                    shouldUseMaterialRoute: RouteGenerator.useMaterialPageRoute,
                    builder: (_) => GenerateUriQrCodeView(
                      coin: coin,
                      receivingAddress: receivingAddress,
                    ),
                    settings: const RouteSettings(
                      name: GenerateUriQrCodeView.routeName,
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.svg.qrcode,
                  width: 14,
                  height: 16,
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .accentColorBlue,
                ),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    "Create new QR code",
                    style: STextStyles.desktopTextExtraSmall(context).copyWith(
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .accentColorBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
