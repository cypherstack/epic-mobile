import 'package:epicpay/pages/receive_view/receive_view.dart';
import 'package:epicpay/pages/send_view/send_view.dart';
import 'package:epicpay/pages/wallet_view/sub_widgets/transactions_list.dart';
import 'package:epicpay/pages/wallet_view/sub_widgets/wallet_summary_info.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/transaction_search_filter_view.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';

/// [eventBus] should only be set during testing
class WalletView extends ConsumerStatefulWidget {
  const WalletView({
    Key? key,
    required this.walletId,
    this.eventBus,
  }) : super(key: key);

  static const String routeName = "/wallet";
  static const double navBarHeight = 65.0;

  final String walletId;
  final EventBus? eventBus;

  @override
  ConsumerState<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends ConsumerState<WalletView> {
  @override
  void initState() {
    ref.read(walletProvider)!.isActiveWallet = true;
    ref.read(walletProvider)!.shouldAutoSync = true;

    if (!ref.read(walletProvider)!.isRefreshing) {
      ref.read(walletProvider)!.refresh();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    final height = MediaQuery.of(context).size.height;

    final coin = ref.watch(walletProvider)!.coin;

    return Container(
      color: Theme.of(context).extension<StackColors>()!.background,
      child: Column(
        children: [
          if (height > 600)
            const SizedBox(
              height: 10,
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: WalletSummaryInfo(
                walletId: widget.walletId,
                isSendView: false,
              ),
            ),
          ),
          if (height > 600)
            const SizedBox(
              height: 15,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _SendButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        SendView.routeName,
                        arguments: Tuple2(widget.walletId, coin),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: _ReceiveButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        ReceiveView.routeName,
                        arguments: Tuple2(widget.walletId, coin),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height > 600 ? 20 : 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TRANSACTIONS",
                  style: STextStyles.overLineBold(context),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      TransactionSearchFilterView.routeName,
                      arguments: Coin.epicCash,
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 36,
                    height: 36,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.filter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TransactionsList(
                walletId: widget.walletId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _ButtonBase(
      label: "SEND",
      color: Theme.of(context).extension<StackColors>()!.accentColorRed,
      iconAsset: Assets.svg.upload,
      onPressed: onPressed,
    );
  }
}

class _ReceiveButton extends StatelessWidget {
  const _ReceiveButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _ButtonBase(
      label: "RECEIVE",
      color: Theme.of(context).extension<StackColors>()!.accentColorGreen,
      iconAsset: Assets.svg.download,
      onPressed: onPressed,
    );
  }
}

class _ButtonBase extends StatelessWidget {
  const _ButtonBase({
    super.key,
    required this.label,
    this.onPressed,
    required this.color,
    required this.iconAsset,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).extension<StackColors>()!.popupBG,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(
                    color: color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              bottom: 8,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconAsset,
                    width: 20,
                    height: 20,
                    color: Theme.of(context).extension<StackColors>()!.popupBG,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 16,
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: STextStyles.buttonText(context).copyWith(
                      color: color,
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
