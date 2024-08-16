import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/services/swap/change_now/change_now_api.dart';
import 'package:epicpay/services/swap/exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';

class ChangeNowExchange extends Exchange {
  ChangeNowExchange._();

  static ChangeNowExchange? _instance;
  static ChangeNowExchange get instance => _instance ??= ChangeNowExchange._();

  static const exchangeName = "ChangeNOW";

  @override
  String get name => exchangeName;

  @override
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
    required bool zBuy,
  }) async {
    final result = await ChangeNowAPI.instance.createExchangeTransaction(
      from: from,
      to: to,
      receivingAddress: addressTo,
      amount: amount,
      flow: fixedRate ? CNFlowType.fixedRate : CNFlowType.standard,
      type: reversed ? CNEstimateType.reverse : CNEstimateType.direct,
      refundAddress: addressRefund,
      refundExtraId: refundExtraId,
      extraId: extraId ?? "",
      rateId: estimate?.rateId ?? "",
    );

    Trade? trade;
    if (result.value != null) {
      final t = result.value!;
      trade = Trade(
        exchangeName: exchangeName,
        fromAmount: t.fromAmount.toString(),
        toAmount: t.toAmount.toString(),
        flow: t.flow,
        type: t.type,
        payinAddress: t.payinAddress,
        payoutAddress: t.payoutAddress,
        payoutExtraId: t.payoutExtraId,
        fromCurrency: t.fromCurrency,
        toCurrency: t.toCurrency,
        refundAddress: t.refundAddress,
        refundExtraId: t.refundExtraId,
        tradeId: t.id,
        fromNetwork: t.fromNetwork,
        toNetwork: t.toNetwork,
        status: "new",
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        payinHash: null,
        payoutHash: null,
        zBuy: zBuy,
      );
    }

    return ExchangeResponse(
      value: trade,
      exception: result.exception,
    );
  }

  @override
  Future<ExchangeResponse<List<Currency>>> getAllCurrencies(
    bool fixedRate,
  ) async {
    return await ChangeNowAPI.instance.getCurrencies(
      flow: fixedRate ? CNFlowType.fixedRate : CNFlowType.standard,
    );
  }

  @override
  Future<ExchangeResponse<List<Estimate>>> getEstimate(
    Currency from,
    Currency to,
    Decimal amount,
    bool fixedRate,
    bool reversed,
  ) async {
    final result = await ChangeNowAPI.instance.getEstimatedExchangeAmount(
      from: from,
      to: to,
      type: reversed ? CNEstimateType.reverse : CNEstimateType.direct,
      flow: fixedRate ? CNFlowType.fixedRate : CNFlowType.standard,
      amount: amount,
    );

    if (result.value != null) {
      return ExchangeResponse(
        value: [result.value!],
        exception: result.exception,
      );
    } else {
      return ExchangeResponse(
        exception: result.exception,
      );
    }
  }

  // @override
  // Future<ExchangeResponse<List<Currency>>> getPairedCurrencies(
  //   Currency currency,
  //   bool fixedRate,
  // ) async {
  //   // TODO: implement getPairedCurrencies
  //   throw UnimplementedError();
  // }

  @override
  Future<ExchangeResponse<List<Pair>>> getPairs(
    Currency? fromCurrency,
    Currency? toCurrency,
  ) async {
    return await ChangeNowAPI.instance.getAvailablePairs(
      from: fromCurrency,
      to: toCurrency,
    );
  }

  @override
  Future<ExchangeResponse<Range>> getRange(
    Currency from,
    Currency to,
    bool fixedRate,
  ) async {
    return await ChangeNowAPI.instance.getRange(
      from: from,
      to: to,
      flow: fixedRate ? CNFlowType.fixedRate : CNFlowType.standard,
    );
  }

  @override
  Future<ExchangeResponse<Trade>> getTrade(String tradeId) async {
    // TODO: implement getTrade
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<List<Trade>>> getTrades() async {
    // TODO: implement getTrades
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Trade>> updateTrade(Trade trade) async {
    final result =
        await ChangeNowAPI.instance.getTransactionStatus(id: trade.tradeId);

    Trade? newTrade;
    if (result.value != null) {
      final t = result.value!;
      newTrade = trade.copyWith(
        fromAmount:
            t.amountFrom?.toString() ?? t.expectedAmountFrom?.toString() ?? "0",
        toAmount:
            t.amountTo?.toString() ?? t.expectedAmountTo?.toString() ?? "0",
        payinAddress: t.payinAddress,
        payinHash: t.payinHash,
        payoutAddress: t.payoutAddress,
        payoutExtraId: t.payoutExtraId,
        payoutHash: t.payoutHash,
        createdAt: t.createdAt,
        updatedAt: t.updatedAt,
        status: t.status,
      );
    }

    return ExchangeResponse(
      value: newTrade,
      exception: result.exception,
    );
  }
}
