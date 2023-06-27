import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';

class AggregateCurrency {
  final Map<String, Currency?> _map = {};

  AggregateCurrency({
    required List<({String exchangeName, Currency currency})>
        exchangeCurrencyPairs,
  }) {
    assert(exchangeCurrencyPairs.isNotEmpty);

    for (final item in exchangeCurrencyPairs) {
      _map[item.exchangeName] = item.currency;
    }
  }

  Currency? forExchange(String exchangeName) {
    return _map[exchangeName];
  }

  String get ticker => _map.values.first!.ticker;

  String get name => _map.values.first!.name;

  String get image => _map.values.first!.image;

  SupportedRateType get rateType => _map.values.first!.rateType;

  bool get isStackCoin => _map.values.first!.isStackCoin;

  @override
  String toString() {
    String str = "AggregateCurrency: {";
    for (final key in _map.keys) {
      str += " $key: ${_map[key]},";
    }
    str += " }";
    return str;
  }
}
