import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:epicmobile/widgets/wallet_info_row/sub_widgets/wallet_info_row_balance_future.dart';
import 'package:epicmobile/widgets/wallet_info_row/sub_widgets/wallet_info_row_coin_icon.dart';

class ChooseFromStackView extends ConsumerStatefulWidget {
  const ChooseFromStackView({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  static const String routeName = "/chooseFromStack";

  @override
  ConsumerState<ChooseFromStackView> createState() =>
      _ChooseFromStackViewState();
}

class _ChooseFromStackViewState extends ConsumerState<ChooseFromStackView> {
  late final Coin coin;

  @override
  void initState() {
    coin = widget.coin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final walletIds = ref.watch(walletsChangeNotifierProvider
        .select((value) => value.getWalletIdsFor(coin: coin)));

    return Scaffold(
      backgroundColor: Theme.of(context).extension<StackColors>()!.background,
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(
          "Choose your ${coin.ticker.toUpperCase()} wallet",
          style: STextStyles.navBarTitle(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: walletIds.isEmpty
            ? Column(
                children: [
                  RoundedWhiteContainer(
                    child: Center(
                      child: Text(
                        "No ${coin.ticker.toUpperCase()} wallets",
                        style: STextStyles.itemSubtitle(context),
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: walletIds.length,
                itemBuilder: (context, index) {
                  final manager = ref.watch(walletsChangeNotifierProvider
                      .select((value) => value.getManager(walletIds[index])));

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: RawMaterialButton(
                      splashColor:
                          Theme.of(context).extension<StackColors>()!.highlight,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Constants.size.circularBorderRadius,
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      // color: Theme.of(context).extension<StackColors>()!.popupBG,
                      elevation: 0,
                      onPressed: () async {
                        if (mounted) {
                          Navigator.of(context).pop(manager.walletId);
                        }
                      },
                      child: RoundedWhiteContainer(
                        // color: Colors.transparent,
                        child: Row(
                          children: [
                            WalletInfoCoinIcon(coin: coin),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    manager.walletName,
                                    style: STextStyles.titleBold12(context),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  WalletInfoRowBalanceFuture(
                                    walletId: walletIds[index],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
