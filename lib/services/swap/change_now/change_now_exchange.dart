// import 'package:decimal/decimal.dart';
// import 'package:epicpay/models/exchange/estimate.dart';
// import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/services/swap/exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';

// import 'package:epicpay/services/swap/exchange_response.dart';
//
class ChangeNowExchange extends Exchange {
  ChangeNowExchange._();

  static ChangeNowExchange? _instance;
  static ChangeNowExchange get instance => _instance ??= ChangeNowExchange._();

  static const exchangeName = "ChangeNOW";

  @override
  String get name => exchangeName;

  @override
  Future<ExchangeResponse<Trade>> createTrade(
      {required Currency from,
      required Currency to,
      required bool fixedRate,
      required Decimal amount,
      required String addressTo,
      String? extraId,
      required String addressRefund,
      required String refundExtraId,
      Estimate? estimate,
      required bool reversed}) {
    // TODO: implement createTrade
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Currency>>> getAllCurrencies(bool fixedRate) {
    // TODO: implement getAllCurrencies
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Pair>>> getAllPairs(bool fixedRate) {
    // TODO: implement getAllPairs
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Estimate>>> getEstimates(
      String from, String to, Decimal amount, bool fixedRate, bool reversed) {
    // TODO: implement getEstimates
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Currency>>> getPairedCurrencies(
      Currency currency, bool fixedRate) {
    // TODO: implement getPairedCurrencies
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Pair>>> getPairsFor(
      Currency currency, bool fixedRate) {
    // TODO: implement getPairsFor
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Range>> getRange(
      String from, String to, bool fixedRate) {
    // TODO: implement getRange
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Trade>> getTrade(String tradeId) {
    // TODO: implement getTrade
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Trade>>> getTrades() {
    // TODO: implement getTrades
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Trade>> updateTrade(Trade trade) {
    // TODO: implement updateTrade
    throw UnimplementedError();
  }
}
