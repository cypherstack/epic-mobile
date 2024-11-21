import 'dart:async';
import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tuple/tuple.dart';

class PriceAPI {
  static const refreshInterval = 60;

  // initialize to older than current time minus at least refreshInterval
  static DateTime _lastCalled =
      DateTime.now().subtract(const Duration(seconds: refreshInterval + 10));

  static String _lastUsedBaseCurrency = "";

  static const Duration refreshIntervalDuration =
      Duration(seconds: refreshInterval);

  final Client client;

  PriceAPI(this.client);

  @visibleForTesting
  void resetLastCalledToForceNextCallToUpdateCache() {
    _lastCalled = DateTime(1970);
  }

  Future<void> _updateCachedPrices(
      Map<Coin, Tuple2<Decimal, double>> data) async {
    final Map<String, dynamic> map = {};

    for (final coin in Coin.values) {
      final entry = data[coin];
      if (entry == null) {
        map[coin.prettyName] = ["0", 0.0];
      } else {
        map[coin.prettyName] = [entry.item1.toString(), entry.item2];
      }
    }

    await DB.instance.put<dynamic>(
      boxName: DB.boxNamePriceCache,
      key: 'cache',
      value: map,
    );
  }

  Map<Coin, Tuple2<Decimal, double>> get _cachedPrices {
    final map = DB.instance.get<dynamic>(
          boxName: DB.boxNamePriceCache,
          key: 'cache',
        ) as Map? ??
        {};
    // init with 0
    final result = {
      for (final coin in Coin.values) coin: Tuple2(Decimal.zero, 0.0)
    };

    for (final entry in map.entries) {
      result[coinFromPrettyName(entry.key as String)] = Tuple2(
        Decimal.parse(entry.value[0] as String),
        entry.value[1] as double,
      );
    }

    return result;
  }

  Future<Map<Coin, Tuple2<Decimal, double>>> getPricesAnd24hChange(
      {required String baseCurrency}) async {
    final now = DateTime.now();
    if (_lastUsedBaseCurrency != baseCurrency ||
        now.difference(_lastCalled) > refreshIntervalDuration) {
      _lastCalled = now;
      _lastUsedBaseCurrency = baseCurrency;
    } else {
      return _cachedPrices;
    }

    Map<Coin, Tuple2<Decimal, double>> result = {};
    try {
      final uri = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?"
        "vs_currency=${baseCurrency.toLowerCase()}"
        "&ids=epic-cash"
        "&order=market_cap_desc"
        "&per_page=10"
        "&page=1"
        "&sparkline=false",
      );

      final coinGeckoResponse = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      final coinGeckoData = jsonDecode(coinGeckoResponse.body) as List<dynamic>;

      Logging.instance.log(
        "coinGeckoData: $coinGeckoData",
        level: LogLevel.Info,
      );

      for (final map in coinGeckoData) {
        final String coinName = map["name"] as String;
        final coin = coinFromPrettyName(coinName);

        final price = Decimal.parse(map["current_price"].toString());
        final change24h =
            double.parse(map["price_change_percentage_24h"].toString());

        result[coin] = Tuple2(price, change24h);
      }

      // update cache
      await _updateCachedPrices(result);

      return _cachedPrices;
    } catch (e, s) {
      Logging.instance.log(
        "getPricesAnd24hChange($baseCurrency): $e\n$s",
        level: LogLevel.Error,
      );
      // return previous cached values
      return _cachedPrices;
    }
  }

  static Future<List<String>?> availableBaseCurrencies() async {
    const uriString =
        "https://api.coingecko.com/api/v3/simple/supported_vs_currencies";
    try {
      final uri = Uri.parse(uriString);
      final response = await Client().get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      final json = jsonDecode(response.body) as List<dynamic>;
      return List<String>.from(json);
    } catch (e, s) {
      Logging.instance.log(
        "availableBaseCurrencies() using $uriString: $e\n$s",
        level: LogLevel.Error,
      );
      return null;
    }
  }
}
