import 'package:epicmobile/pages/add_wallet_views/add_wallet_view/sub_widgets/coin_select_item.dart';
import 'package:epicmobile/providers/global/prefs_provider.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchableCoinList extends ConsumerWidget {
  const SearchableCoinList({
    Key? key,
    required this.coins,
    required this.isDesktop,
    required this.searchTerm,
  }) : super(key: key);

  final List<Coin> coins;
  final bool isDesktop;
  final String searchTerm;

  List<Coin> filterCoins(String text, bool showTestNetCoins) {
    final _coins = [...coins];
    if (text.isNotEmpty) {
      final lowercaseTerm = text.toLowerCase();
      _coins.retainWhere((e) =>
          e.ticker.toLowerCase().contains(lowercaseTerm) ||
          e.prettyName.toLowerCase().contains(lowercaseTerm) ||
          e.name.toLowerCase().contains(lowercaseTerm));
    }
    if (!showTestNetCoins) {
      _coins.removeWhere(
          (e) => e.name.endsWith("TestNet") || e == Coin.bitcoincashTestnet);
    }

    return _coins;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showTestNet = ref.watch(
      prefsChangeNotifierProvider.select((value) => value.showTestNetCoins),
    );

    final _coins = filterCoins(searchTerm, showTestNet);

    return ListView.builder(
      itemCount: _coins.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: CoinSelectItem(
            coin: _coins[index],
          ),
        );
      },
    );
  }
}
