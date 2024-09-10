import 'dart:async';

import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_1.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/services/geo_service.dart';
import 'package:epicpay/services/guardarian/enums.dart';
import 'package:epicpay/services/guardarian/guardarian_api.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/buy_card.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';

class BuyView extends ConsumerStatefulWidget {
  const BuyView({
    Key? key,
    required this.coin,
    required this.walletId,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/buyView";

  final Coin coin;
  final String walletId;
  final ClipboardInterface clipboard;
  @override
  ConsumerState<BuyView> createState() => _BuyViewState();
}

class _BuyViewState extends ConsumerState<BuyView> {
  late final Coin coin;
  late final String walletId;
  late final ClipboardInterface clipboard;

  bool _onBuyWithCryptoLock = false;
  Future<void> _onBuyWithCryptoPressed() async {
    if (_onBuyWithCryptoLock) {
      return;
    }
    _onBuyWithCryptoLock = true;
    try {
      await Navigator.of(context).pushNamed(BuyWithCryptoStep1.routeName);
    } finally {
      _onBuyWithCryptoLock = false;
    }
  }

  Future<(List<GCurrency>, GCurrency)> _loading() async {
    final countries = await GuardarianAPI.getCountries();
    if (countries.value == null) {
      throw countries.exception!;
    }

    GeoService.guardarianCountries = countries.value!;

    final myCountryCode = await GeoService.externalIpCountryCode().timeout(
      const Duration(seconds: 3),
      onTimeout: () => null,
    );
    if (myCountryCode != null) {
      final possibleCountries = GeoService.guardarianCountries.where(
        (e) => e.codeIsoAlpha2 == myCountryCode,
      );

      if (possibleCountries.length == 1) {
        if (!possibleCountries.first.supported) {
          throw Exception(
            "Guardarian does not support ${possibleCountries.first.countryName} at this time.",
          );
        }
      }
    }

    // todo get country from device external ip or geolocation
    // todo check countries and pop up warning? (throw exception in this case)
    final epic = await GuardarianAPI.getCurrency("EPIC");
    if (epic.value == null) {
      throw epic.exception!;
    }

    final currencies = await GuardarianAPI.getCurrenciesFiat(true);
    if (currencies.value == null) {
      throw currencies.exception!;
    }

    // sort and filter
    currencies.value!
        .removeWhere((e) => e.enabled == false || e.isAvailable == false);
    currencies.value!.removeWhere((e) => !e.paymentMethods
        .any((e) => e.paymentCategory == EGPaymentCategory.VISA_MC));
    final List<GCurrency> eurUsdGbp = [];
    final strings = ["EUR", "USD", "GBP"];
    for (final string in strings) {
      final index = currencies.value!.indexWhere((e) => e.ticker == string);
      if (index >= 0) {
        eurUsdGbp.add(currencies.value!.removeAt(index));
      }
    }
    currencies.value!.sort((a, b) => a.name.compareTo(b.name));
    currencies.value!.insertAll(0, eurUsdGbp);
    return (currencies.value!, epic.value!);
  }

  bool _onBuyWithFiatLock = false;
  Future<void> _onBuyWithFiatPressed() async {
    if (_onBuyWithFiatLock) {
      return;
    }
    _onBuyWithFiatLock = true;
    try {
      Exception? ex;
      final result = await showLoading(
        whileFuture: _loading(),
        context: context,
        onException: (e) => ex = e,
      );

      if (ex != null) {
        if (mounted) {
          await showDialog<void>(
            context: context,
            builder: (_) => EPErrorDialog(
              title: "Guardarian API Error",
              info: ex.toString(),
            ),
          );
        }
        return;
      }

      if (mounted) {
        await Navigator.of(context).pushNamed(
          BuyWithFiatStep1.routeName,
          arguments: result!,
        );
      }
    } catch (e, s) {
      Logging.instance.log("$e\n$s", level: LogLevel.Error);
    } finally {
      _onBuyWithFiatLock = false;
    }
  }

  @override
  void initState() {
    walletId = widget.walletId;
    coin = widget.coin;
    clipboard = widget.clipboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return NestedScrollView(
      floatHeaderSlivers: false,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: height < 600 ? 2 : 10,
                    ),
                    Text(
                      "Buy EPIC",
                      style: STextStyles.titleH2(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height < 600 ? 8 : 20,
                    ),
                    _CryptoButton(
                      onPressed: () {
                        if (mounted) {
                          _onBuyWithCryptoPressed();
                        }
                      },
                    ),
                    SizedBox(
                      height: height < 600 ? 4 : 16,
                    ),
                    _FiatButton(
                      onPressed: () {
                        if (mounted) {
                          _onBuyWithFiatPressed();
                        }
                      },
                    ),
                    SizedBox(
                      height: height < 600 ? 10 : 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: StreamBuilder(
        stream: ref.watch(pIsarDB).isar.trades.watchLazy(),
        builder: (buildContext, snapshot) {
          final internalTradeIds = ref
              .watch(pIsarDB)
              .isar
              .trades
              .where()
              .filter()
              .zBuyEqualTo(true)
              .sortByTimestampUTCDesc()
              .idProperty()
              .findAllSync();
          final hasHistory = internalTradeIds.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    buildContext,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "PREVIOUS QUOTES",
                          style: STextStyles.overLineBold(context),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                if (hasHistory)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return StreamBuilder<Trade?>(
                          stream: ref
                              .watch(pIsarDB)
                              .isar
                              .trades
                              .watchObject(internalTradeIds[index]),
                          builder: (
                            context,
                            AsyncSnapshot<Trade?> snapshot,
                          ) {
                            final trade = snapshot.data ??
                                ref
                                    .read(pIsarDB)
                                    .isar
                                    .trades
                                    .where()
                                    .idEqualTo(internalTradeIds[index])
                                    .findFirstSync()!;

                            return ConditionalParent(
                              condition: index > 0,
                              builder: (child) => Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: child,
                              ),
                              child: BuyCard(
                                key: Key(
                                  "buyCard_${trade.tradeId + trade.updatedAt.toString()}",
                                ),
                                trade: trade,
                              ),
                            );
                          },
                        );
                      },
                      childCount: internalTradeIds.length,
                    ),
                  ),
                if (!hasHistory)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .popupBG,
                          borderRadius: BorderRadius.circular(
                            Constants.size.circularBorderRadius,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Buys will appear here",
                            textAlign: TextAlign.center,
                            style: STextStyles.itemSubtitle(context),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CryptoButton extends StatelessWidget {
  const _CryptoButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: RawMaterialButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              elevation: 0,
              fillColor: Theme.of(context).extension<StackColors>()!.popupBG,
            ),
          ),
          Positioned(
            top: -2,
            right: 100,
            child: IgnorePointer(
              child: SizedBox(
                width: 101.2,
                height: 88,
                child: SvgPicture.asset(
                  Assets.svg.layerUsdt,
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: 0,
            child: IgnorePointer(
              child: SizedBox(
                width: 90,
                height: 90,
                child: SvgPicture.asset(
                  Assets.svg.layerUsdc,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -8,
            right: 49,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerBtc,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        Assets.svg.bitcoin,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textGold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Buy with crypto",
                      style: STextStyles.bodyBold(context),
                    ),
                    Text(
                      "Buy EPIC with BTC, USDT, and more",
                      style: STextStyles.label(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiatButton extends StatelessWidget {
  const _FiatButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: RawMaterialButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              elevation: 0,
              fillColor: Theme.of(context).extension<StackColors>()!.popupBG,
            ),
          ),
          Positioned(
            top: -8,
            right: 80,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerDollar,
                ),
              ),
            ),
          ),
          Positioned(
            top: 13,
            right: -14,
            child: IgnorePointer(
              child: SizedBox(
                width: 92,
                height: 106,
                child: SvgPicture.asset(
                  Assets.svg.layerEpic,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 65,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerEuro,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        Assets.svg.dollar,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textGold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Buy with fiat",
                      style: STextStyles.bodyBold(context),
                    ),
                    Text(
                      "Coming soon",
                      style: STextStyles.label(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
