import 'dart:convert';

import 'package:epicpay/external_api_keys.dart';
import 'package:epicpay/services/guardarian/enums.dart';
import 'package:epicpay/services/guardarian/g_error.dart';
import 'package:epicpay/services/guardarian/g_response.dart';
import 'package:epicpay/services/guardarian/response_models/g_country.dart';
import 'package:epicpay/services/guardarian/response_models/g_country_by_payment_category.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/services/guardarian/response_models/g_estimate.dart';
import 'package:epicpay/services/guardarian/response_models/g_market_info.dart';
import 'package:epicpay/services/guardarian/response_models/g_payment_category.dart';
import 'package:epicpay/services/guardarian/response_models/g_payment_category_by_country.dart';
import 'package:epicpay/services/guardarian/response_models/g_status.dart';
import 'package:epicpay/services/guardarian/response_models/g_transaction.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:http/http.dart' as http;

/// Guardarian API uses token authentication. Token generated for each partner
/// and must be submitted with x-api-key header for successful authentication.
/// If request to create a transaction is not directly performed from customer’s
/// device, or in other words customer’s IP is not a source of request,
/// IP should be forwarded through a header:
/// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For
///
/// For more information see: https://api-payments.guardarian.com/v1/api-docs
abstract final class GuardarianAPI {
  static const _authority = "api-payments.guardarian.com";

  static Map<String, String>? _buildHeaders(
    bool requiresApiKey,
    String? forwardCustomerIP,
  ) {
    return {
      'Content-Type': 'application/json',
      if (requiresApiKey) "x-api-key": kGrdrnKey,
      if (forwardCustomerIP != null) "x-forwarded-for": forwardCustomerIP,
    };
  }

  static Map<String, dynamic> _processQueryParam(Map<dynamic, dynamic> params) {
    Map<String, dynamic> result = {};

    params.forEach((key, value) {
      String newKey = key.toString();

      if (value is Map) {
        result[newKey] = _processQueryParam(value);
      } else if (value is List) {
        result[newKey] = value
            .map((e) => e is Map ? _processQueryParam(e) : e.toString())
            .toList();
      } else if (value != null) {
        result[newKey] = value.toString();
      }
    });

    return result;
  }

  static Future<dynamic> _get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String version = "/v1",
    bool requiresApiKey = false,
    String? forwardCustomerIP,
  }) async {
    final Map<String, dynamic>? processedParams;
    if (queryParameters == null) {
      processedParams = null;
    } else {
      processedParams = _processQueryParam(queryParameters);
    }

    try {
      final uri = Uri.https(_authority, version + endpoint, processedParams);

      final response = await http.get(
        uri,
        headers: _buildHeaders(requiresApiKey, forwardCustomerIP),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body) as Map;
        error["httpStatusCode"] = response.statusCode;
        throw GException.fromMap(error);
      }

      return jsonDecode(response.body);
    } catch (e, s) {
      Logging.instance.log(
        "_get($endpoint) threw: $e\n$s",
        level: LogLevel.Error,
      );
      rethrow;
    }
  }

  static Map<String, dynamic> _cleanNulls(Map<String, dynamic> body) {
    for (final key in body.keys) {
      if (body[key] is Map) {
        body[key] = _cleanNulls(body[key] as Map<String, dynamic>);
      }
    }
    body.removeWhere((k, v) =>
        v == null || (v is List && v.isEmpty) || (v is Map && v.isEmpty));
    return body;
  }

  static Future<dynamic> _post(
    String endpoint,
    Map<String, dynamic> body, {
    String version = "/v1",
    String? forwardCustomerIP,
  }) async {
    try {
      final uri = Uri.https(_authority, version + endpoint);

      final response = await http.post(
        uri,
        headers: _buildHeaders(true, forwardCustomerIP),
        body: jsonEncode(_cleanNulls(body)),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final error = jsonDecode(response.body) as Map;
        error["httpStatusCode"] = response.statusCode;
        throw GException.fromMap(error);
      }

      return jsonDecode(response.body);
    } catch (e, s) {
      Logging.instance.log(
        "_get($endpoint) threw: $e\n$s",
        level: LogLevel.Error,
      );
      rethrow;
    }
  }

  // ========== Status =========================================================
  /// This is API health check endpoint
  static Future<GResponse<GStatus>> getStatus() async {
    try {
      final result = await _get("/status");
      return GResponse(value: GStatus.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }
  // ===========================================================================

  // ========== Currency =======================================================
  /// This method can be used to fetch a list of all currencies available with
  /// Guardarian.
  static Future<GResponse<List<GCurrency>>> getCurrencies(
    bool filterByActive,
  ) async {
    try {
      final result = await _get(
        "/currencies",
        queryParameters: {"available": filterByActive},
      );
      final list =
          (result["fiat_currencies"] as List).cast<Map<dynamic, dynamic>>();
      list.addAll(
          (result["crypto_currencies"] as List).cast<Map<dynamic, dynamic>>());
      return GResponse(value: list.map(GCurrency.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This method can be used to fetch a specific currency by its [ticker].
  static Future<GResponse<GCurrency>> getCurrency(String ticker) async {
    try {
      final result = await _get("/currencies/$ticker");
      return GResponse(value: GCurrency.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This method can be used to fetch a list of all fiat currencies available
  /// with Guardarian.
  static Future<GResponse<List<GCurrency>>> getCurrenciesFiat(
    bool filterByActive,
  ) async {
    try {
      final result = await _get(
        "/currencies/fiat",
        queryParameters: {"available": filterByActive},
      );
      final list = (result as List).cast<Map<dynamic, dynamic>>();
      return GResponse(value: list.map(GCurrency.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This method can be used to fetch a list of all crypto currencies available
  /// with Guardarian.
  static Future<GResponse<List<GCurrency>>> getCurrenciesCrypto(
    bool filterByActive,
  ) async {
    try {
      final result = await _get(
        "/currencies/crypto",
        queryParameters: {"available": filterByActive},
      );
      final list = (result as List).cast<Map<dynamic, dynamic>>();
      return GResponse(value: list.map(GCurrency.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }
  // ===========================================================================

  // ========== Transaction ====================================================
  /// Create an exchange with provided list of attributes.
  static Future<GResponse<GTransaction>> postTransaction({
    required double fromAmount,
    required String fromCurrency,
    required String toCurrency,
    String? fromNetwork,
    String? toNetwork,
    String? kycSharedToken,
    String? kycSharedTokenProvider,
    // Redirects? redirects, // Maybe later if required
    bool? skipChoosePayoutAddress,
    String? payoutAddress,
    String? extraId,
    Customer? customer,
    EGPaymentCategory? paymentCategory,
    bool? skipChoosePaymentCategory,
    String? customerCountry,
    String? externalPartnerLinkId,
    String? locale,
  }) async {
    try {
      final body = {
        "from_amount": fromAmount,
        "from_currency": fromCurrency,
        "to_currency": toCurrency,
        "from_network": fromNetwork,
        "to_network": toNetwork,
        "kyc_shared_token": kycSharedToken,
        "kyc_shared_token_provider": kycSharedTokenProvider,
        "redirects": {
          "successful": null,
          "cancelled": null,
          "failed": null,
        },
        "payout_info": {
          "skip_choose_payout_address": skipChoosePayoutAddress,
          "payout_address": payoutAddress,
          "extra_id": extraId,
        },
        "customer": {
          "contact_info": {
            "email": customer?.contactInfo?.email,
          },
          "billing_info": {
            "country_alpha_2": customer?.billingInfo.countryAlpha2,
            "us_region_alpha_2": customer?.billingInfo.usRegionAlpha2,
            "region": customer?.billingInfo.region,
            "city": customer?.billingInfo.city,
            "street_address": customer?.billingInfo.streetAddress,
            "apt_number": customer?.billingInfo.aptNumber,
            "post_index": customer?.billingInfo.postIndex,
            "first_name": customer?.billingInfo.firstName,
            "last_name": customer?.billingInfo.lastName,
            "date_of_birthday": customer?.billingInfo.dateOfBirthday,
            "gender": customer?.billingInfo.gender,
          }
        },
        "deposit": {
          "payment_category": paymentCategory?.name,
          "skip_choose_payment_category": skipChoosePaymentCategory,
        },
        "customer_country": customerCountry,
        "external_partner_link_id": externalPartnerLinkId,
        "locale": locale,
      };
      final result = await _post("/transaction", body);
      return GResponse(value: GTransaction.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// Fetch transaction details by [id].
  /// Transaction [id] is returned when transaction is created.
  static Future<GResponse<GTransaction>> getTransaction(String id) async {
    try {
      final result = await _get("/transaction/$id", requiresApiKey: true);
      return GResponse(value: GTransaction.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  // / UNIMPLEMENTED !!! see https://api-payments.guardarian.com/v1/api-docs
  // / List of all partner transactions.
  // / This methods is available only by request.
  // / Please contact business@guardarian.com
  // Future<GResponse<List<GTransaction>>> getTransactions() async {
  //   try {
  //     throw UnimplementedError();
  //     final result = await _get("/transactions", requiresApiKey: true);
  //     final list = (result as List).cast<Map<dynamic, dynamic>>();
  //     return GResponse(value: list.map(GTransaction.fromMap).toList());
  //   } on GException catch (e) {
  //     return GResponse(exception: e);
  //   }
  // }
  // ===========================================================================

  // ========== Estimate =======================================================

  /// This endpoint returns estimated exchange amount based on provided params.
  /// See  https://api-payments.guardarian.com/v1/api-docs for details
  static Future<GResponse<GEstimate>> getEstimate({
    required String fromCurrency,
    String? fromNetwork,
    String? fromAmount,
    String? toAmount,
    required String toCurrency,
    String? toNetwork,
    EGPaymentType? depositType,
    EGPaymentCategory? depositCategory,
    EGPaymentType? payoutType,
    EGDirection? type,
    bool feesIncluded = true,
    String? customerCountry,
  }) async {
    try {
      final queryParameters = {
        "from_currency": fromCurrency,
        "from_network": fromNetwork,
        "from_amount": fromAmount,
        "to_amount": toAmount,
        "to_currency": toCurrency,
        "to_network": toNetwork,
        "deposit_type": depositType?.name,
        "deposit_category": depositCategory?.name,
        "payout_type": payoutType?.name,
        "type": type?.name,
        "fees_included": feesIncluded,
        "customer_country": customerCountry,
      };

      final result = await _get(
        "/estimate",
        queryParameters: queryParameters,
        requiresApiKey: true,
      );
      return GResponse(value: GEstimate.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This endpoint returns estimated exchange amount based on provided payment
  /// category and other params.
  static Future<GResponse<List<GEstimate>>> getEstimates({
    required String fromCurrency,
    String? fromNetwork,
    String? fromAmount,
    required String toCurrency,
    String? toNetwork,
    EGPaymentCategory? paymentCategory,
    EGPaymentType? payoutType,
    bool feesIncluded = true,
  }) async {
    try {
      final queryParameters = {
        "from_currency": fromCurrency,
        "from_network": fromNetwork,
        "from_amount": fromAmount,
        "to_currency": toCurrency,
        "to_network": toNetwork,
        "payment_category": paymentCategory?.name,
        "payout_type": payoutType?.name,
        "fees_included": feesIncluded,
      };
      final result = await _get(
        "/estimate/by-category",
        queryParameters: queryParameters,
        requiresApiKey: true,
      );
      final list = (result as List).cast<Map<dynamic, dynamic>>();
      return GResponse(value: list.map(GEstimate.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }
  // ===========================================================================

  // ========== Market Info ====================================================

  /// This method can be used to fetch information about min-max exchange range
  /// for given pair.
  static Future<GResponse<GMarketInfo>> getMarketInfo(
    String fromCurrency,
    String? fromNetwork,
    String toCurrency,
    String? toNetwork,
  ) async {
    try {
      String pair = fromCurrency;
      if (fromNetwork != null) {
        pair += "-$fromNetwork";
      }
      pair += "_$toCurrency";
      if (toNetwork != null) {
        pair += "-$toNetwork";
      }

      final result = await _get("/market-info/min-max-range/$pair");
      return GResponse(value: GMarketInfo.fromMap(result as Map));
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  // ===========================================================================

  // ========== Country ========================================================

  /// This is a method for list of countries which are supported.
  static Future<GResponse<List<GCountry>>> getCountries() async {
    try {
      final result = await _get("/countries");
      final list = (result as List).cast<Map<dynamic, dynamic>>();
      return GResponse(value: list.map(GCountry.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This is a method for list of payment categories by supported country.
  static Future<GResponse<List<GPaymentCategoryByCountry>>>
      getPaymentCategoriesFor(
    String country,
  ) async {
    try {
      final result = await _get("/countries/$country/payment-categories");
      final list = (result as List).cast<Map<dynamic, dynamic>>();

      return GResponse(
        value: list
            .map((e) =>
                GPaymentCategoryByCountry.fromMap(e..["country"] = country))
            .toList(),
      );
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  // ===========================================================================

  // ========== Payment Category ===============================================

  /// Get list of payment categories.
  static Future<GResponse<List<GPaymentCategory>>>
      getPaymentCategories() async {
    try {
      final result = await _get("/payment-categories");
      final list = (result as List).cast<Map<dynamic, dynamic>>();
      return GResponse(value: list.map(GPaymentCategory.fromMap).toList());
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  /// This is a method for list of countries for a payment category.
  static Future<GResponse<List<GCountryByPaymentCategory>>> getCountriesFor(
    EGPaymentCategory category,
  ) async {
    try {
      final result =
          await _get("/payment-categories/${category.name}/countries");
      final list = (result as List).cast<Map<dynamic, dynamic>>();

      return GResponse(
        value: list
            .map((e) =>
                GCountryByPaymentCategory.fromMap(e..["category"] = category))
            .toList(),
      );
    } on GException catch (e) {
      return GResponse(exception: e);
    }
  }

  // ===========================================================================
}

class Customer {
  final CustomerContactInfo? contactInfo;
  final CustomerBillingInfo billingInfo;

  const Customer({
    this.contactInfo,
    required this.billingInfo,
  });

  static Customer fromMap(Map<dynamic, dynamic> map) {
    return Customer(
      contactInfo: map["contact_info"] != null
          ? CustomerContactInfo.fromMap(map["contact_info"] as Map)
          : null,
      billingInfo: CustomerBillingInfo.fromMap(map["billing_info"] as Map),
    );
  }

  @override
  String toString() {
    return "$runtimeType(contactInfo: $contactInfo, billingInfo: $billingInfo)";
  }
}

class CustomerContactInfo {
  final String? email;

  const CustomerContactInfo({
    this.email,
  });

  static CustomerContactInfo fromMap(Map<dynamic, dynamic> map) {
    return CustomerContactInfo(
      email: map["email"] as String?,
    );
  }

  @override
  String toString() {
    return "$runtimeType(email: $email)";
  }
}

class CustomerBillingInfo {
  final String countryAlpha2;
  final String? usRegionAlpha2;
  final String region;
  final String city;
  final String streetAddress;
  final String aptNumber;
  final String postIndex;
  final String firstName;
  final String lastName;
  final String? dateOfBirthday;
  final String? gender;

  const CustomerBillingInfo({
    required this.countryAlpha2,
    this.usRegionAlpha2,
    required this.region,
    required this.city,
    required this.streetAddress,
    required this.aptNumber,
    required this.postIndex,
    required this.firstName,
    required this.lastName,
    this.dateOfBirthday,
    this.gender,
  });

  static CustomerBillingInfo fromMap(Map<dynamic, dynamic> map) {
    return CustomerBillingInfo(
      countryAlpha2: map["country_alpha_2"] as String,
      usRegionAlpha2: map["us_region_alpha_2"] as String?,
      region: map["region"] as String,
      city: map["city"] as String,
      streetAddress: map["street_address"] as String,
      aptNumber: map["apt_number"] as String,
      postIndex: map["post_index"] as String,
      firstName: map["first_name"] as String,
      lastName: map["last_name"] as String,
      dateOfBirthday: map["date_of_birthday"] as String?,
      gender: map["gender"] as String?,
    );
  }

  @override
  String toString() {
    return "$runtimeType(countryAlpha2: $countryAlpha2, usRegionAlpha2: $usRegionAlpha2,"
        " region: $region, city: $city, streetAddress: $streetAddress, "
        "aptNumber: $aptNumber, postIndex: $postIndex, firstName: $firstName,"
        " lastName: $lastName, dateOfBirthday: $dateOfBirthday, gender: $gender)";
  }
}
