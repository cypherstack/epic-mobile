import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:epicpay/external_api_keys.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/services/swap/change_now/DTOs/transaction_dto.dart';
import 'package:epicpay/services/swap/change_now/DTOs/transaction_status_dto.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum CNEstimateType { direct, reverse }

enum CNFlowType implements Comparable<CNFlowType> {
  standard("standard"),
  fixedRate("fixed-rate");

  const CNFlowType(this.value);

  final String value;

  @override
  int compareTo(CNFlowType other) => value.compareTo(other.value);
}

class ChangeNowAPI {
  static const String scheme = "https";
  static const String authority = "api.changenow.io";
  static const String apiVersionV2 = "/v2";

  ChangeNowAPI._();
  static final ChangeNowAPI _instance = ChangeNowAPI._();
  static ChangeNowAPI get instance => _instance;

  Uri _buildUri(String path, Map<String, dynamic>? params) {
    return Uri.https(authority, apiVersionV2 + path, params);
  }

  Future<dynamic> _makeGetRequest(Uri uri) async {
    try {
      final response = await http.get(
        uri,
        headers: {
          'x-changenow-api-key': kChangeNowApiKey,
        },
      );

      final parsed = jsonDecode(response.body);

      return parsed;
    } catch (e, s) {
      Logging.instance.log(
        "_makeGetRequest($uri) threw: $e\n$s",
        level: LogLevel.Error,
      );
      rethrow;
    }
  }

  Future<dynamic> _makePostRequest(
    Uri uri,
    Map<String, String> body,
  ) async {
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-changenow-api-key': kChangeNowApiKey,
        },
        body: jsonEncode(body),
      );

      try {
        final parsed = jsonDecode(response.body);

        return parsed;
      } catch (_) {
        Logging.instance.log("ChangeNOW api failed to parse: ${response.body}",
            level: LogLevel.Error);
        rethrow;
      }
    } catch (e, s) {
      Logging.instance
          .log("_makePostRequest($uri) threw: $e\n$s", level: LogLevel.Error);
      rethrow;
    }
  }

  /// This API endpoint returns the list of currencies.
  ///
  /// Set [active] to true to return only active currencies.
  /// Set [fixedRate] to true to return only currencies available on a fixed-rate flow.
  Future<ExchangeResponse<List<Currency>>> getCurrencies({
    CNFlowType flow = CNFlowType.standard,
    bool active = true,
  }) async {
    Map<String, dynamic> params = {
      "active": active.toString(),
    };

    params.addAll({"flow": flow.value});

    final uri = _buildUri("/exchange/currencies", params);

    try {
      // json array is expected here
      final jsonArray = await _makeGetRequest(uri);

      try {
        final result = await compute(
          _parseV2CurrenciesJson,
          jsonArray as List<dynamic>,
        );
        return result;
      } catch (e, s) {
        Logging.instance.log(
          "getCurrencies exception: $e\n$s",
          level: LogLevel.Error,
        );
        return ExchangeResponse(
          exception: ExchangeException(
            "Error: $jsonArray",
          ),
        );
      }
    } catch (e, s) {
      Logging.instance.log(
        "getCurrencies exception: $e\n$s",
        level: LogLevel.Error,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }

  ExchangeResponse<List<Currency>> _parseV2CurrenciesJson(
    List<dynamic> args,
  ) {
    try {
      List<Currency> currencies = [];

      for (final json in args) {
        try {
          final map = Map<String, dynamic>.from(json as Map);
          currencies.add(
            Currency.fromJson(
              map,
              ChangeNowExchange.exchangeName,
            ),
          );
        } catch (_) {
          return ExchangeResponse(
            exception: ExchangeException(
              "Failed to serialize $json",
            ),
          );
        }
      }

      return ExchangeResponse(value: currencies);
    } catch (_) {
      rethrow;
    }
  }

  Future<ExchangeResponse<List<Pair>>> getAvailablePairs({
    required Currency? from,
    required Currency? to,
  }) async {
    Map<String, dynamic> params = {
      "fromCurrency": from?.ticker ?? "",
      "fromNetwork": from?.network ?? "",
      "toCurrency": to?.ticker ?? "",
      "toNetwork": to?.network ?? "",
    };

    final uri = _buildUri("/exchange/available-pairs", params);

    try {
      // json array is expected here
      final response = await _makeGetRequest(uri);

      if (response is Map && response["error"] != null) {
        return ExchangeResponse(
          exception: ExchangeException(
            response["message"] as String? ?? response["error"].toString(),
          ),
        );
      }

      final jsonArray = response as List;

      List<Pair> pairs = [];
      try {
        for (final json in jsonArray) {
          try {
            final map = Map<String, dynamic>.from(json as Map);
            pairs.add(
              Pair.fromJson(
                map,
                ChangeNowExchange.exchangeName,
              ),
            );
          } catch (_) {
            return ExchangeResponse(
              exception: ExchangeException(
                "Failed to serialize $json",
              ),
            );
          }
        }
      } catch (e, s) {
        Logging.instance.log(
          "getPairedCurrencies exception: $e\n$s",
          level: LogLevel.Error,
        );
        return ExchangeResponse(
          exception: ExchangeException(
            "Error: $jsonArray",
          ),
        );
      }
      return ExchangeResponse(value: pairs);
    } catch (e, s) {
      Logging.instance.log(
        "getPairedCurrencies exception: $e\n$s",
        level: LogLevel.Error,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }

  /// The API endpoint returns minimal payment amount and maximum payment amount
  /// required to make an exchange. If you try to exchange less than minimum or
  /// more than maximum, the transaction will most likely fail. Any pair of
  /// assets has minimum amount and some of pairs have maximum amount.
  Future<ExchangeResponse<Range>> getRange({
    required Currency from,
    required Currency to,
    required CNFlowType flow,
  }) async {
    final uri = _buildUri(
      "/exchange/range",
      {
        "fromCurrency": from.ticker,
        "fromNetwork": from.network,
        "toCurrency": to.ticker,
        "toNetwork": to.network,
        "flow": flow.value,
      },
    );

    try {
      final jsonObject = await _makeGetRequest(uri);

      final json = Map<String, dynamic>.from(jsonObject as Map);
      return ExchangeResponse(
        value: Range.fromJson(json),
      );
    } catch (e, s) {
      Logging.instance.log(
        "getRange exception: $e\n$s",
        level: LogLevel.Error,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }

  /// Get estimated amount of [toTicker] cryptocurrency to receive
  /// for [fromAmount] of [fromTicker]
  Future<ExchangeResponse<Estimate>> getEstimatedExchangeAmount({
    required Currency from,
    required Currency to,
    required CNEstimateType type,
    required Decimal amount,
    CNFlowType flow = CNFlowType.standard,
  }) async {
    Map<String, dynamic>? params = {
      "fromCurrency": from.ticker,
      "toCurrency": to.ticker,
      "fromNetwork": from.network,
      "toNetwork": to.network,
      "flow": flow.value,
      "type": type.name,
    };

    switch (type) {
      case CNEstimateType.direct:
        params["fromAmount"] = amount.toString();
        break;
      case CNEstimateType.reverse:
        params["toAmount"] = amount.toString();
        break;
    }

    if (flow == CNFlowType.fixedRate) {
      params["useRateId"] = "true";
    }

    final uri = _buildUri("/exchange/estimated-amount", params);

    try {
      // simple json object is expected here
      final json = await _makeGetRequest(uri);

      try {
        final value = Estimate.fromMap(
          Map<String, dynamic>.from(json as Map),
          exchangeProvider: ChangeNowExchange.exchangeName,
        );
        return ExchangeResponse(value: value);
      } catch (_) {
        return ExchangeResponse(
          exception: ExchangeException(
            "Failed to serialize $json",
          ),
        );
      }
    } catch (e, s) {
      Logging.instance.log("getEstimatedExchangeAmount exception: $e\n$s",
          level: LogLevel.Error);
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }

  /// The API endpoint creates a transaction, generates an address for
  /// sending funds and returns transaction attributes.
  Future<ExchangeResponse<TransactionDTO>> createExchangeTransaction({
    required Currency from,
    required Currency to,
    required String receivingAddress,
    required Decimal amount,
    required CNFlowType flow,
    required CNEstimateType type,
    String rateId = "",
    String extraId = "",
    String userId = "",
    String contactEmail = "",
    String refundAddress = "",
    String refundExtraId = "",
    String payload = "",
  }) async {
    final Map<String, String> map = {
      "fromCurrency": from.ticker,
      "fromNetwork": from.network,
      "toCurrency": to.ticker,
      "toNetwork": to.network,
      "address": receivingAddress,
      "extraId": extraId,
      "refundAddress": refundAddress,
      "refundExtraId": refundExtraId,
      "userId": userId,
      "payload": payload,
      "contactEmail": contactEmail,
      "flow": flow.value,
      "type": type.name,
      "rateId": rateId,
    };

    switch (type) {
      case CNEstimateType.direct:
        map.addAll({
          "fromAmount": amount.toString(),
        });
        break;

      case CNEstimateType.reverse:
        map.addAll({
          "toAmount": amount.toString(),
        });
        break;
    }

    final uri = _buildUri("/exchange", null);

    try {
      // simple json object is expected here
      final json = await _makePostRequest(uri, map);

      try {
        final value = TransactionDTO.fromJson(
          Map<String, dynamic>.from(json as Map),
        );
        return ExchangeResponse(value: value);
      } catch (_) {
        return ExchangeResponse(
          exception: ExchangeException(
            "Failed to serialize $json",
          ),
        );
      }
    } catch (e, s) {
      Logging.instance.log(
        "createExchangeTransaction exception: $e\n$s",
        level: LogLevel.Error,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }

  Future<ExchangeResponse<TransactionStatusDTO>> getTransactionStatus({
    required String id,
  }) async {
    final uri = _buildUri(
      "/exchange/by-id",
      {
        "id": id,
      },
    );

    try {
      // simple json object is expected here
      final json = await _makeGetRequest(uri);

      try {
        final value = TransactionStatusDTO.fromJson(
          Map<String, dynamic>.from(json as Map),
        );
        return ExchangeResponse(value: value);
      } catch (_) {
        return ExchangeResponse(
          exception: ExchangeException(
            "Failed to serialize $json",
          ),
        );
      }
    } catch (e, s) {
      Logging.instance.log(
        "getTransactionStatus exception: $e\n$s",
        level: LogLevel.Error,
      );
      return ExchangeResponse(
        exception: ExchangeException(
          e.toString(),
        ),
      );
    }
  }
}
