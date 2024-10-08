import 'package:decimal/decimal.dart';
import 'package:epicpay/pages/wallet_view/sub_widgets/wallet_balance_toggle_dialog.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/providers/wallet/wallet_balance_toggle_state_provider.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/enums/wallet_balance_toggle_state.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/animated_text.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletSummaryInfo extends StatefulWidget {
  const WalletSummaryInfo(
      {Key? key, required this.walletId, required this.isSendView})
      : super(key: key);

  final String walletId;
  final bool isSendView;

  @override
  State<WalletSummaryInfo> createState() => _WalletSummaryInfoState();
}

class _WalletSummaryInfoState extends State<WalletSummaryInfo> {
  late final String walletId;
  late final bool isSendView;

  void showSheet() {
    showDialog<void>(
      context: context,
      builder: (context) => const WalletBalanceToggleDialog(),
    );
  }

  Decimal? _balanceTotalCached;
  Decimal? _balanceCached;

  @override
  void initState() {
    walletId = widget.walletId;
    isSendView = widget.isSendView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    return Consumer(
      builder: (_, ref, __) {
        final Coin coin =
            ref.watch(walletProvider.select((value) => value!.coin));

        Future<Decimal>? totalBalanceFuture;
        Future<Decimal>? availableBalanceFuture;
        totalBalanceFuture =
            ref.watch(walletProvider.select((value) => value!.totalBalance));

        availableBalanceFuture = ref
            .watch(walletProvider.select((value) => value!.availableBalance));

        final locale = ref.watch(localeServiceChangeNotifierProvider
            .select((value) => value.locale));

        final baseCurrency = ref.watch(
            prefsChangeNotifierProvider.select((value) => value.currency));

        final priceTuple = ref.watch(priceAnd24hChangeNotifierProvider
            .select((value) => value.getPrice(coin)));

        final _showAvailable = isSendView
            ? true
            : ref.watch(walletBalanceToggleStateProvider.state).state ==
                WalletBalanceToggleState.available;

        return FutureBuilder(
          future: _showAvailable ? availableBalanceFuture : totalBalanceFuture,
          builder: (fbContext, AsyncSnapshot<Decimal> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              if (_showAvailable) {
                _balanceCached = snapshot.data!;
              } else {
                _balanceTotalCached = snapshot.data!;
              }
            }
            Decimal? balanceToShow =
                _showAvailable ? _balanceCached : _balanceTotalCached;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSendView == false)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TODO ??
                      // if (!_showAvailable)
                      //   SvgPicture.asset(
                      //     Assets.svg.lockFilled,
                      //     color: Theme.of(context)
                      //         .extension<StackColors>()!
                      //         .textGold,
                      //   ),
                      // if (!_showAvailable)
                      //   const SizedBox(
                      //     width: 5,
                      //   ),
                      Text(
                        "WALLET BALANCE",
                        style: STextStyles.overLineBold(context).copyWith(
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .textDark,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                balanceToShow != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${Format.localizedStringAsFixed(
                              value: balanceToShow,
                              locale: locale,
                              decimalPlaces: 3,
                            )} EPIC",
                            style: STextStyles.titleH3(context).copyWith(
                              fontSize: 30,
                              height: 1,
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textGold,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            "${Format.localizedStringAsFixed(
                              value: priceTuple.item1 * balanceToShow,
                              locale: locale,
                              decimalPlaces: 2,
                            )} $baseCurrency",
                            style: STextStyles.titleH3(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textMedium,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedText(
                            stringsToLoopThrough: const [
                              "Loading balance",
                              "Loading balance.",
                              "Loading balance..",
                              "Loading balance..."
                            ],
                            style: STextStyles.pageTitleH1(context).copyWith(
                              fontSize: 24,
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textGold,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          AnimatedText(
                            stringsToLoopThrough: const [
                              "Loading balance",
                              "Loading balance.",
                              "Loading balance..",
                              "Loading balance..."
                            ],
                            style: STextStyles.subtitle500(context).copyWith(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .textGold,
                            ),
                          ),
                        ],
                      ),
                if (isSendView == false)
                  const SizedBox(
                    height: 15,
                  ),
                if (isSendView == false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: showSheet,
                        child: RoundedContainer(
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .popupBG,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          radiusMultiplier: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${_showAvailable ? "AVAILABLE" : "FULL"} BALANCE",
                                style: STextStyles.overLine(context).copyWith(
                                  color: Theme.of(context)
                                      .extension<StackColors>()!
                                      .textLight,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              SvgPicture.asset(
                                Assets.svg.chevronDown,
                                width: 8,
                                height: 4,
                                color: Theme.of(context)
                                    .extension<StackColors>()!
                                    .textLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
