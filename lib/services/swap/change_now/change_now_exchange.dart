// import 'package:decimal/decimal.dart';
// import 'package:epicpay/models/exchange/estimate.dart';
// import 'package:epicpay/models/isar/models/exchange/trade.dart';
// import 'package:epicpay/services/swap/exchange.dart';
// import 'package:epicpay/services/swap/exchange_response.dart';
//
// class ChangeNowExchange extends Exchange {
//   ChangeNowExchange._();
//
//   static ChangeNowExchange? _instance;
//   static ChangeNowExchange get instance => _instance ??= ChangeNowExchange._();
//
//   static const exchangeName = "ChangeNOW";
//
//   @override
//   String get name => exchangeName;
//
//   @override
//   Future<ExchangeResponse<Trade>> createTrade({
//     required String from,
//     required String to,
//     required bool fixedRate,
//     required Decimal amount,
//     required String addressTo,
//     String? extraId,
//     required String addressRefund,
//     required String refundExtraId,
//     Estimate? estimate,
//     required bool reversed,
//   }) async {
//     late final ExchangeResponse<Trade> response;
//     if (fixedRate) {
//       response = await ChangeNowAPI.instance.createFixedRateExchangeTransaction(
//         fromTicker: from,
//         toTicker: to,
//         receivingAddress: addressTo,
//         amount: amount,
//         rateId: estimate!.rateId!,
//         extraId: extraId ?? "",
//         refundAddress: addressRefund,
//         refundExtraId: refundExtraId,
//         reversed: reversed,
//       );
//     } else {
//       response = await ChangeNowAPI.instance.createStandardExchangeTransaction(
//         fromTicker: from,
//         toTicker: to,
//         receivingAddress: addressTo,
//         amount: amount,
//         extraId: extraId ?? "",
//         refundAddress: addressRefund,
//         refundExtraId: refundExtraId,
//       );
//     }
//     if (response.exception != null) {
//       return ExchangeResponse(exception: response.exception);
//     }
//
//     final statusResponse = await ChangeNowAPI.instance
//         .getTransactionStatus(id: response.value!.id);
//     if (statusResponse.exception != null) {
//       return ExchangeResponse(exception: statusResponse.exception);
//     }
//
//     return ExchangeResponse(
//       value: Trade.fromExchangeTransaction(
//         response.value!.copyWith(
//           statusObject: statusResponse.value!,
//         ),
//         reversed,
//       ),
//     );
//   }
//
//   @override
//   Future<ExchangeResponse<List<Currency>>> getAllCurrencies(
//     bool fixedRate,
//   ) async {
//     return await ChangeNowAPI.instance.getCurrenciesV2();
//     // return await ChangeNowAPI.instance.getAvailableCurrencies(
//     //   fixedRate: fixedRate ? true : null,
//     //   active: true,
//     // );
//   }
//
//   @override
//   Future<ExchangeResponse<List<Currency>>> getPairedCurrencies(
//     String forCurrency,
//     bool fixedRate,
//   ) async {
//     return await ChangeNowAPI.instance.getPairedCurrencies(
//       ticker: forCurrency,
//       fixedRate: fixedRate,
//     );
//   }
//
//   @override
//   Future<ExchangeResponse<List<Pair>>> getAllPairs(bool fixedRate) async {
//     if (fixedRate) {
//       final markets =
//           await ChangeNowAPI.instance.getAvailableFixedRateMarkets();
//
//       if (markets.value == null) {
//         return ExchangeResponse(exception: markets.exception);
//       }
//
//       final List<Pair> pairs = [];
//       for (final market in markets.value!) {
//         pairs.add(
//           Pair(
//             exchangeName: ChangeNowExchange.exchangeName,
//             from: market.from,
//             to: market.to,
//             rateType: SupportedRateType.fixed,
//           ),
//         );
//       }
//       return ExchangeResponse(value: pairs);
//     } else {
//       return await ChangeNowAPI.instance.getAvailableFloatingRatePairs();
//     }
//   }
//
//   @override
//   Future<ExchangeResponse<List<Estimate>>> getEstimates(
//     String from,
//     String to,
//     Decimal amount,
//     bool fixedRate,
//     bool reversed,
//   ) async {
//     late final ExchangeResponse<Estimate> response;
//     if (fixedRate) {
//       response =
//           await ChangeNowAPI.instance.getEstimatedExchangeAmountFixedRate(
//         fromTicker: from,
//         toTicker: to,
//         fromAmount: amount,
//         reversed: reversed,
//       );
//     } else {
//       response = await ChangeNowAPI.instance.getEstimatedExchangeAmount(
//         fromTicker: from,
//         toTicker: to,
//         fromAmount: amount,
//       );
//     }
//     return ExchangeResponse(
//       value: response.value == null ? null : [response.value!],
//       exception: response.exception,
//     );
//   }
//
//   @override
//   Future<ExchangeResponse<Range>> getRange(
//     String from,
//     String to,
//     bool fixedRate,
//   ) async {
//     return await ChangeNowAPI.instance.getRange(
//       fromTicker: from,
//       toTicker: to,
//       isFixedRate: fixedRate,
//     );
//   }
//
//   @override
//   Future<ExchangeResponse<List<Pair>>> getPairsFor(
//     String currency,
//     bool fixedRate,
//   ) async {
//     // TODO: implement getPairsFor
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<ExchangeResponse<Trade>> getTrade(String tradeId) async {
//     final response =
//         await ChangeNowAPI.instance.getTransactionStatus(id: tradeId);
//     if (response.exception != null) {
//       return ExchangeResponse(exception: response.exception);
//     }
//     final t = response.value!;
//     final timestamp = DateTime.tryParse(t.createdAt) ?? DateTime.now();
//
//     final trade = Trade(
//       uuid: const Uuid().v1(),
//       tradeId: tradeId,
//       rateType: "",
//       direction: "",
//       timestamp: timestamp,
//       updatedAt: DateTime.tryParse(t.updatedAt) ?? timestamp,
//       payInCurrency: t.fromCurrency,
//       payInAmount: t.expectedSendAmountDecimal,
//       payInAddress: t.payinAddress,
//       payInNetwork: "",
//       payInExtraId: t.payinExtraId,
//       payInTxid: t.payinHash,
//       payOutCurrency: t.toCurrency,
//       payOutAmount: t.expectedReceiveAmountDecimal,
//       payOutAddress: t.payoutAddress,
//       payOutNetwork: "",
//       payOutExtraId: t.payoutExtraId,
//       payOutTxid: t.payoutHash,
//       refundAddress: t.refundAddress,
//       refundExtraId: t.refundExtraId,
//       status: t.status.name,
//       exchangeName: ChangeNowExchange.exchangeName,
//     );
//
//     return ExchangeResponse(value: trade);
//   }
//
//   @override
//   Future<ExchangeResponse<Trade>> updateTrade(Trade trade) async {
//     final response =
//         await ChangeNowAPI.instance.getTransactionStatus(id: trade.tradeId);
//     if (response.exception != null) {
//       return ExchangeResponse(exception: response.exception);
//     }
//     final t = response.value!;
//     final timestamp = DateTime.tryParse(t.createdAt) ?? DateTime.now();
//
//     final _trade = Trade(
//       uuid: trade.uuid,
//       tradeId: trade.tradeId,
//       rateType: trade.rateType,
//       direction: trade.direction,
//       timestamp: timestamp,
//       updatedAt: DateTime.tryParse(t.updatedAt) ?? timestamp,
//       payInCurrency: t.fromCurrency,
//       payInAmount: t.amountSendDecimal.isEmpty
//           ? t.expectedSendAmountDecimal
//           : t.amountSendDecimal,
//       payInAddress: t.payinAddress,
//       payInNetwork: trade.payInNetwork,
//       payInExtraId: t.payinExtraId,
//       payInTxid: t.payinHash,
//       payOutCurrency: t.toCurrency,
//       payOutAmount: t.amountReceiveDecimal.isEmpty
//           ? t.expectedReceiveAmountDecimal
//           : t.amountReceiveDecimal,
//       payOutAddress: t.payoutAddress,
//       payOutNetwork: trade.payOutNetwork,
//       payOutExtraId: t.payoutExtraId,
//       payOutTxid: t.payoutHash,
//       refundAddress: t.refundAddress,
//       refundExtraId: t.refundExtraId,
//       status: t.status.name,
//       exchangeName: ChangeNowExchange.exchangeName,
//     );
//
//     return ExchangeResponse(value: _trade);
//   }
//
//   @override
//   Future<ExchangeResponse<List<Trade>>> getTrades() async {
//     // TODO: implement getTrades
//     throw UnimplementedError();
//   }
// }
