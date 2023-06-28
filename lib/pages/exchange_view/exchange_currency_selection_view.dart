import 'dart:async';

import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/swap_data_service.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/custom_loading_overlay.dart';
import 'package:epicpay/widgets/icon_widgets/x_icon.dart';
import 'package:epicpay/widgets/loading_indicator.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:epicpay/widgets/stack_text_field.dart';
import 'package:epicpay/widgets/textfield_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';

class ExchangeCurrencySelectionView extends ConsumerStatefulWidget {
  const ExchangeCurrencySelectionView({
    Key? key,
    required this.willChangeTicker,
    required this.pairedTicker,
    required this.isFixedRate,
    required this.willChangeIsSend,
  }) : super(key: key);

  final String? willChangeTicker;
  final String? pairedTicker;
  final bool isFixedRate;
  final bool willChangeIsSend;

  @override
  ConsumerState<ExchangeCurrencySelectionView> createState() =>
      _ExchangeCurrencySelectionViewState();
}

class _ExchangeCurrencySelectionViewState
    extends ConsumerState<ExchangeCurrencySelectionView> {
  late TextEditingController _searchController;
  final _searchFocusNode = FocusNode();

  List<Currency> _currencies = [];

  bool _loaded = false;
  String _searchString = "";

  bool isStackCoin(String? ticker) {
    if (ticker == null) return false;

    try {
      coinFromTickerCaseInsensitive(ticker);
      return true;
    } on ArgumentError catch (_) {
      return false;
    }
  }

  Future<T> _showUpdatingCurrencies<T>({
    required Future<T> whileFuture,
  }) async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: Theme.of(context)
                .extension<StackColors>()!
                .overlay
                .withOpacity(0.6),
            child: const CustomLoadingOverlay(
              message: "Loading currencies",
              eventBus: null,
            ),
          ),
        ),
      ),
    );

    final result = await whileFuture;

    if (mounted) {
      Navigator.of(context).pop();
    }

    return result;
  }

  Future<List<Currency>> _loadCurrencies() async {
    if (widget.pairedTicker == null) {
      return await _getCurrencies();
    }

    final pairs = await ref
        .read(pSwapDataService)
        .isarDB
        .isar
        .pairs
        .where()
        .exchangeNameEqualToAnyComputedIndex(ChangeNowExchange.exchangeName)
        .filter()
        .group((q) => q.fromNetworkEqualTo("epic").and().fromEqualTo("epic"))
        .or()
        .group((q) => q.toNetworkEqualTo("epic").and().toEqualTo("epic"))
        .findAll();

    List<Currency> currencies = await ref
        .read(pSwapDataService)
        .isarDB
        .isar
        .currencies
        .where()
        .exchangeNameEqualTo(ChangeNowExchange.exchangeName)
        .filter()
        .anyOf(
            pairs,
            (q, e) => q
                .group((q) =>
                    q.networkEqualTo(e.fromNetwork).and().tickerEqualTo(e.from))
                .or()
                .group((q) =>
                    q.networkEqualTo(e.toNetwork).and().tickerEqualTo(e.to)))
        .findAll();

    // final cn = await ChangeNowExchange.instance.getPairedCurrencies(
    //   widget.pairedTicker!,
    //   widget.isFixedRate,
    // );
    //
    // if (cn.value == null) {
    //   // if (cn.exception is UnsupportedCurrencyException) {
    //   //   return currencies;
    //   // }
    //
    //   if (mounted) {
    //     // await showDialog<void>(
    //     //   context: context,
    //     //   builder: (context) => StackDialog(
    //     //     title: "ChangeNOW Error",
    //     //     message: "Failed to load currency data: ${cn.exception}",
    //     //     leftButton: SecondaryButton(
    //     //       label: "Ok",
    //     //       onPressed: Navigator.of(context, rootNavigator: isDesktop).pop,
    //     //     ),
    //     //     rightButton: PrimaryButton(
    //     //       label: "Retry",
    //     //       onPressed: () async {
    //     //         Navigator.of(context, rootNavigator: isDesktop).pop();
    //     //         _currencies = await _showUpdatingCurrencies(
    //     //             whileFuture: _loadCurrencies());
    //     //         setState(() {});
    //     //       },
    //     //     ),
    //     //   ),
    //     // );
    //   }
    // } else {
    //   currencies.addAll(cn.value!);
    // }

    return _getDistinctCurrenciesFrom(currencies);
  }

  Future<List<Currency>> _getCurrencies() async {
    final currencies = await ref
        .read(pSwapDataService)
        .isarDB
        .isar
        .currencies
        .where()
        .filter()
        .isFiatEqualTo(false)
        .and()
        .group((q) => widget.isFixedRate
            ? q
                .rateTypeEqualTo(SupportedRateType.both)
                .or()
                .rateTypeEqualTo(SupportedRateType.fixed)
            : q
                .rateTypeEqualTo(SupportedRateType.both)
                .or()
                .rateTypeEqualTo(SupportedRateType.estimated))
        .sortByName()
        .findAll();

    return _getDistinctCurrenciesFrom(currencies);
  }

  List<Currency> _getDistinctCurrenciesFrom(List<Currency> currencies) {
    final List<Currency> distinctCurrencies = [];
    for (final currency in currencies) {
      if (!distinctCurrencies.any((e) => e.ticker == currency.ticker)) {
        distinctCurrencies.add(currency);
      }
    }
    return distinctCurrencies;
  }

  List<Currency> filter(String text) {
    if (widget.pairedTicker == null) {
      if (text.isEmpty) {
        return _currencies;
      }

      return _currencies
          .where((e) =>
              e.name.toLowerCase().contains(text.toLowerCase()) ||
              e.ticker.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      if (text.isEmpty) {
        return _currencies
            .where((e) =>
                e.ticker.toLowerCase() != widget.pairedTicker!.toLowerCase())
            .toList();
      }

      return _currencies
          .where((e) =>
              e.ticker.toLowerCase() != widget.pairedTicker!.toLowerCase() &&
              (e.name.toLowerCase().contains(text.toLowerCase()) ||
                  e.ticker.toLowerCase().contains(text.toLowerCase())))
          .toList();
    }
  }

  @override
  void initState() {
    _searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      _loaded = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        _currencies =
            await _showUpdatingCurrencies(whileFuture: _loadCurrencies());
        setState(() {});
      });
    }

    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () async {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
                await Future<void>.delayed(const Duration(milliseconds: 50));
              }
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          title: Text(
            "Choose a coin to exchange",
            style: STextStyles.pageTitleH2(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) => setState(() => _searchString = value),
                  style: STextStyles.field(context),
                  decoration: standardInputDecoration(
                    "Search",
                    _searchFocusNode,
                    context,
                  ).copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 16,
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.search,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: UnconstrainedBox(
                              child: Row(
                                children: [
                                  TextFieldIconButton(
                                    child: const XIcon(),
                                    onTap: () async {
                                      setState(() {
                                        _searchController.text = "";
                                        _searchString = "";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Builder(
                  builder: (context) {
                    final coins = Coin.values.where((e) =>
                        e.ticker.toLowerCase() !=
                        widget.pairedTicker?.toLowerCase());

                    final items = filter(_searchString);

                    final walletCoins = items
                        .where((currency) => coins
                            .where((coin) =>
                                coin.ticker.toLowerCase() ==
                                currency.ticker.toLowerCase())
                            .isNotEmpty)
                        .toList();

                    // sort alphabetically by name
                    items.sort((a, b) => a.name.compareTo(b.name));

                    // reverse sort walletCoins to prepare for next step
                    walletCoins.sort((a, b) => b.name.compareTo(a.name));

                    // insert wallet coins at beginning
                    for (final c in walletCoins) {
                      items.remove(c);
                      items.insert(0, c);
                    }

                    return RoundedWhiteContainer(
                      padding: const EdgeInsets.all(0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (builderContext, index) {
                          final bool hasImageUrl =
                              items[index].image.startsWith("http");
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(items[index]);
                              },
                              child: RoundedWhiteContainer(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: isStackCoin(items[index].ticker)
                                          ? getIconForTicker(
                                              items[index].ticker,
                                              size: 24,
                                            )
                                          : hasImageUrl
                                              ? SvgPicture.network(
                                                  items[index].image,
                                                  width: 24,
                                                  height: 24,
                                                  placeholderBuilder: (_) =>
                                                      const LoadingIndicator(),
                                                )
                                              : const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index].name,
                                            style: STextStyles.largeMedium14(
                                                context),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            items[index].ticker.toUpperCase(),
                                            style:
                                                STextStyles.smallMed12(context)
                                                    .copyWith(
                                              color: Theme.of(context)
                                                  .extension<StackColors>()!
                                                  .textSubtitle1,
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
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget? getIconForTicker(
  String ticker, {
  double size = 20,
}) {
  try {
    return SvgPicture.asset(
      Assets.svg.iconFor(
        coin: coinFromTickerCaseInsensitive(ticker),
      ),
      height: size,
      width: size,
    );
  } catch (_) {
    return null;
  }
}
