import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/services/swap/exchange_response.dart';

abstract class Exchange {
  // static Exchange get defaultExchange => ChangeNowExchange.instance;

  static Exchange fromName(String name) {
    switch (name) {
      // case ChangeNowExchange.exchangeName:
      //   return ChangeNowExchange.instance;
      // case SimpleSwapExchange.exchangeName:
      //   return SimpleSwapExchange.instance;
      // case MajesticBankExchange.exchangeName:
      //   return MajesticBankExchange.instance;
      // case TrocadorExchange.exchangeName:
      //   return TrocadorExchange.instance;
      default:
        final split = name.split(" ");
        if (split.length >= 2) {
          // silly way to check for 'Trocador ($providerName)'
          return fromName(split.first);
        }
        throw ArgumentError("Unknown exchange name");
    }
  }

  String get name;

  Future<ExchangeResponse<List<Currency>>> getAllCurrencies(bool fixedRate);

  Future<ExchangeResponse<List<Currency>>> getPairedCurrencies(
    Currency currency,
    bool fixedRate,
  );

  Future<ExchangeResponse<List<Pair>>> getPairsFor(
    Currency currency,
    bool fixedRate,
  );

  Future<ExchangeResponse<List<Pair>>> getAllPairs(bool fixedRate);

  Future<ExchangeResponse<Trade>> getTrade(String tradeId);
  Future<ExchangeResponse<Trade>> updateTrade(Trade trade);

  Future<ExchangeResponse<List<Trade>>> getTrades();

  Future<ExchangeResponse<Range>> getRange(
    String from,
    String to,
    bool fixedRate,
  );

  Future<ExchangeResponse<List<Estimate>>> getEstimates(
    String from,
    String to,
    Decimal amount,
    bool fixedRate,
    bool reversed,
  );

  Future<ExchangeResponse<Trade>> createTrade({
    required Currency from,
    required Currency to,
    required bool fixedRate,
    required Decimal amount,
    required String addressTo,
    String? extraId,
    required String addressRefund,
    required String refundExtraId,
    Estimate? estimate,
    required bool reversed,
  });
}
