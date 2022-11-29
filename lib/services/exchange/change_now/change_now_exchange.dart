import 'package:decimal/decimal.dart';
import 'package:epicmobile/models/exchange/change_now/exchange_transaction.dart';
import 'package:epicmobile/models/exchange/response_objects/currency.dart';
import 'package:epicmobile/models/exchange/response_objects/estimate.dart';
import 'package:epicmobile/models/exchange/response_objects/pair.dart';
import 'package:epicmobile/models/exchange/response_objects/range.dart';
import 'package:epicmobile/models/exchange/response_objects/trade.dart';
import 'package:epicmobile/services/exchange/change_now/change_now_api.dart';
import 'package:epicmobile/services/exchange/exchange.dart';
import 'package:epicmobile/services/exchange/exchange_response.dart';
import 'package:uuid/uuid.dart';

class ChangeNowExchange extends Exchange {
  static const exchangeName = "ChangeNOW";

  @override
  String get name => exchangeName;

  @override
  Future<ExchangeResponse<Trade>> createTrade({
    required String from,
    required String to,
    required bool fixedRate,
    required Decimal amount,
    required String addressTo,
    String? extraId,
    required String addressRefund,
    required String refundExtraId,
    String? rateId,
    required bool reversed,
  }) async {
    late final ExchangeResponse<ExchangeTransaction> response;
    if (fixedRate) {
      response = await ChangeNowAPI.instance.createFixedRateExchangeTransaction(
        fromTicker: from,
        toTicker: to,
        receivingAddress: addressTo,
        amount: amount,
        rateId: rateId!,
        extraId: extraId ?? "",
        refundAddress: addressRefund,
        refundExtraId: refundExtraId,
        reversed: reversed,
      );
    } else {
      response = await ChangeNowAPI.instance.createStandardExchangeTransaction(
        fromTicker: from,
        toTicker: to,
        receivingAddress: addressTo,
        amount: amount,
        extraId: extraId ?? "",
        refundAddress: addressRefund,
        refundExtraId: refundExtraId,
      );
    }
    if (response.exception != null) {
      return ExchangeResponse(exception: response.exception);
    }

    final statusResponse = await ChangeNowAPI.instance
        .getTransactionStatus(id: response.value!.id);
    if (statusResponse.exception != null) {
      return ExchangeResponse(exception: statusResponse.exception);
    }

    return ExchangeResponse(
      value: Trade.fromExchangeTransaction(
        response.value!.copyWith(
          statusObject: statusResponse.value!,
        ),
        reversed,
      ),
    );
  }

  @override
  Future<ExchangeResponse<List<Currency>>> getAllCurrencies(
    bool fixedRate,
  ) async {
    return await ChangeNowAPI.instance.getAvailableCurrencies(
      fixedRate: fixedRate ? true : null,
      active: true,
    );
  }

  @override
  Future<ExchangeResponse<List<Pair>>> getAllPairs(bool fixedRate) async {
    // TODO: implement getAllPairs
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Estimate>> getEstimate(
    String from,
    String to,
    Decimal amount,
    bool fixedRate,
    bool reversed,
  ) async {
    late final ExchangeResponse<Estimate> response;
    if (fixedRate) {
      response =
          await ChangeNowAPI.instance.getEstimatedExchangeAmountFixedRate(
        fromTicker: from,
        toTicker: to,
        fromAmount: amount,
        reversed: reversed,
      );
    } else {
      response = await ChangeNowAPI.instance.getEstimatedExchangeAmount(
        fromTicker: from,
        toTicker: to,
        fromAmount: amount,
      );
    }
    return response;
  }

  @override
  Future<ExchangeResponse<Range>> getRange(
    String from,
    String to,
    bool fixedRate,
  ) async {
    return await ChangeNowAPI.instance.getRange(
      fromTicker: from,
      toTicker: to,
      isFixedRate: fixedRate,
    );
  }

  @override
  Future<ExchangeResponse<List<Pair>>> getPairsFor(
    String currency,
    bool fixedRate,
  ) async {
    // TODO: implement getPairsFor
    throw UnimplementedError();
  }

  @override
  Future<ExchangeResponse<Trade>> getTrade(String tradeId) async {
    final response =
        await ChangeNowAPI.instance.getTransactionStatus(id: tradeId);
    if (response.exception != null) {
      return ExchangeResponse(exception: response.exception);
    }
    final t = response.value!;
    final timestamp = DateTime.tryParse(t.createdAt) ?? DateTime.now();

    final trade = Trade(
      uuid: const Uuid().v1(),
      tradeId: tradeId,
      rateType: "",
      direction: "",
      timestamp: timestamp,
      updatedAt: DateTime.tryParse(t.updatedAt) ?? timestamp,
      payInCurrency: t.fromCurrency,
      payInAmount: t.expectedSendAmountDecimal,
      payInAddress: t.payinAddress,
      payInNetwork: "",
      payInExtraId: t.payinExtraId,
      payInTxid: t.payinHash,
      payOutCurrency: t.toCurrency,
      payOutAmount: t.expectedReceiveAmountDecimal,
      payOutAddress: t.payoutAddress,
      payOutNetwork: "",
      payOutExtraId: t.payoutExtraId,
      payOutTxid: t.payoutHash,
      refundAddress: t.refundAddress,
      refundExtraId: t.refundExtraId,
      status: t.status.name,
      exchangeName: ChangeNowExchange.exchangeName,
    );

    return ExchangeResponse(value: trade);
  }

  @override
  Future<ExchangeResponse<Trade>> updateTrade(Trade trade) async {
    final response =
        await ChangeNowAPI.instance.getTransactionStatus(id: trade.tradeId);
    if (response.exception != null) {
      return ExchangeResponse(exception: response.exception);
    }
    final t = response.value!;
    final timestamp = DateTime.tryParse(t.createdAt) ?? DateTime.now();

    final _trade = Trade(
      uuid: trade.uuid,
      tradeId: trade.tradeId,
      rateType: trade.rateType,
      direction: trade.direction,
      timestamp: timestamp,
      updatedAt: DateTime.tryParse(t.updatedAt) ?? timestamp,
      payInCurrency: t.fromCurrency,
      payInAmount: t.amountSendDecimal.isEmpty
          ? t.expectedSendAmountDecimal
          : t.amountSendDecimal,
      payInAddress: t.payinAddress,
      payInNetwork: trade.payInNetwork,
      payInExtraId: t.payinExtraId,
      payInTxid: t.payinHash,
      payOutCurrency: t.toCurrency,
      payOutAmount: t.amountReceiveDecimal.isEmpty
          ? t.expectedReceiveAmountDecimal
          : t.amountReceiveDecimal,
      payOutAddress: t.payoutAddress,
      payOutNetwork: trade.payOutNetwork,
      payOutExtraId: t.payoutExtraId,
      payOutTxid: t.payoutHash,
      refundAddress: t.refundAddress,
      refundExtraId: t.refundExtraId,
      status: t.status.name,
      exchangeName: ChangeNowExchange.exchangeName,
    );

    return ExchangeResponse(value: _trade);
  }

  @override
  Future<ExchangeResponse<List<Trade>>> getTrades() async {
    // TODO: implement getTrades
    throw UnimplementedError();
  }
}
