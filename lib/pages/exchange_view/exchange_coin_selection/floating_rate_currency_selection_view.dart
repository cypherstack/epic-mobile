import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:epicmobile/models/exchange/response_objects/currency.dart';
import 'package:epicmobile/utilities/assets.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicmobile/widgets/icon_widgets/x_icon.dart';
import 'package:epicmobile/widgets/loading_indicator.dart';
import 'package:epicmobile/widgets/rounded_white_container.dart';
import 'package:epicmobile/widgets/stack_text_field.dart';
import 'package:epicmobile/widgets/textfield_icon_buttons FloatingRateCurrencySelectionView extends StatefulWidget {
  const FloatingRateCurrencySelectionView({
    Key? key,
    required this.currencies,
  }) : super(key: key);

  final List<Currency> currencies;

  @override
  State<FloatingRateCurrencySelectionView> createState() =>
      _FloatingRateCurrencySelectionViewState();
}

class _FloatingRateCurrencySelectionViewState
    extends State<FloatingRateCurrencySelectionView> {
  late TextEditingController _searchController;
  final _searchFocusNode = FocusNode();

  late final List<Currency> currencies;
  late List<Currency> _currencies;

  void filter(String text) {
    setState(() {
      _currencies = [
        ...currencies.where((e) =>
            e.name.toLowerCase().contains(text.toLowerCase()) ||
            e.ticker.toLowerCase().contains(text.toLowerCase()))
      ];
    });
  }

  @override
  void initState() {
    _searchController = TextEditingController();

    currencies = [...widget.currencies];
    currencies.sort(
        (a, b) => a.ticker.toLowerCase().compareTo(b.ticker.toLowerCase()));
    for (Coin coin in Coin.values.reversed) {
      int index = currencies.indexWhere((element) =>
          element.ticker.toLowerCase() == coin.ticker.toLowerCase());
      if (index > 0) {
        final currency = currencies.removeAt(index);
        currencies.insert(0, currency);
      }
    }

    _currencies = [...currencies];

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
    return Scaffold(
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
          children: [
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                Constants.size.circularBorderRadius,
              ),
              child: TextField(
                autocorrect: Util.isDesktop ? false : true,
                enableSuggestions: Util.isDesktop ? false : true,
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: filter,
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
                                    });
                                    filter("");
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
              height: 10,
            ),
            Text(
              "Popular coins",
              style: STextStyles.smallMed12(context),
            ),
            const SizedBox(
              height: 12,
            ),
            Builder(builder: (context) {
              final items = _currencies
                  .where((e) => Coin.values
                      .where((coin) =>
                          coin.ticker.toLowerCase() == e.ticker.toLowerCase())
                      .isNotEmpty)
                  .toList(growable: false);

              return RoundedWhiteContainer(
                padding: const EdgeInsets.all(0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (builderContext, index) {
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
                                child: SvgPicture.network(
                                  items[index].image,
                                  width: 24,
                                  height: 24,
                                  placeholderBuilder: (_) =>
                                      const LoadingIndicator(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items[index].name,
                                      style: STextStyles.largeMedium14(context),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      items[index].ticker.toUpperCase(),
                                      style: STextStyles.smallMed12(context)
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
            }),
            const SizedBox(
              height: 20,
            ),
            Text(
              "All coins",
              style: STextStyles.smallMed12(context),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: RoundedWhiteContainer(
                padding: const EdgeInsets.all(0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _currencies.length,
                  itemBuilder: (builderContext, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(_currencies[index]);
                        },
                        child: RoundedWhiteContainer(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.network(
                                  _currencies[index].image,
                                  width: 24,
                                  height: 24,
                                  placeholderBuilder: (_) =>
                                      const LoadingIndicator(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _currencies[index].name,
                                      style: STextStyles.largeMedium14(context),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      _currencies[index].ticker.toUpperCase(),
                                      style: STextStyles.smallMed12(context)
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
