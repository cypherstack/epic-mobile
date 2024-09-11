import 'package:epicpay/services/guardarian/enums.dart';

class GTransaction {
  final String id;
  final EGTransactionStatus status;
  final String? email;
  final List<dynamic> errors;
  final String? statusDetails;
  final String fromCurrency;
  final String? initialFromCurrency;
  final String? fromNetwork;
  final String? fromCurrencyWithNetwork;
  final String fromAmount;
  final String depositType;
  final String payoutType;
  final String expectedFromAmount;
  final String? initialExpectedFromAmount;
  final String toCurrency;
  final String? toNetwork;
  final String? toCurrencyWithNetwork;
  final String? toAmount;
  final String? outputHash;
  final String expectedToAmount;
  final String location;
  final String createdAt;
  final String updatedAt;
  final String partnerId;
  final String? externalPartnerLinkId;
  final String? fromAmountInEur;
  final bool? customerPayoutAddressChangeable;
  final EstimateBreakdown estimateBreakdown;
  final Payout? payout;
  final EGPaymentCategory depositPaymentCategory;
  final EGPaymentCategory payoutPaymentCategory;
  final String? redirectUrl;
  final String? preauthToken;
  final bool? skipChoosePayoutAddress;
  final bool? skipChoosePaymentCategory;

  const GTransaction({
    required this.id,
    required this.status,
    required this.email,
    required this.errors,
    this.statusDetails,
    required this.fromCurrency,
    required this.initialFromCurrency,
    required this.fromNetwork,
    required this.fromCurrencyWithNetwork,
    required this.fromAmount,
    required this.depositType,
    required this.payoutType,
    required this.expectedFromAmount,
    required this.initialExpectedFromAmount,
    required this.toCurrency,
    required this.toNetwork,
    required this.toCurrencyWithNetwork,
    required this.toAmount,
    required this.outputHash,
    required this.expectedToAmount,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.partnerId,
    required this.externalPartnerLinkId,
    required this.fromAmountInEur,
    required this.customerPayoutAddressChangeable,
    required this.estimateBreakdown,
    required this.payout,
    required this.depositPaymentCategory,
    required this.payoutPaymentCategory,
    required this.redirectUrl,
    required this.preauthToken,
    required this.skipChoosePayoutAddress,
    required this.skipChoosePaymentCategory,
  });

  static GTransaction fromMap(Map<dynamic, dynamic> map) {
    try {
      return GTransaction(
        id: map["id"] as String,
        status: EGTransactionStatus.fromString(map["status"] as String),
        email: map["email"] as String?,
        errors: map["errors"] as List<dynamic>,
        statusDetails: map["status_details"] as String?,
        fromCurrency: map["from_currency"] as String,
        initialFromCurrency: map["initial_from_currency"] as String?,
        fromNetwork: map["from_network"] as String?,
        fromCurrencyWithNetwork: map["from_currency_with_network"] as String?,
        fromAmount: map["from_amount"] as String,
        depositType: map["deposit_type"] as String,
        payoutType: map["payout_type"] as String,
        expectedFromAmount: map["expected_from_amount"] as String,
        initialExpectedFromAmount:
            map["initial_expected_from_amount"] as String?,
        toCurrency: map["to_currency"] as String,
        toNetwork: map["to_network"] as String?,
        toCurrencyWithNetwork: map["to_currency_with_network"] as String?,
        toAmount: map["to_amount"] as String?,
        outputHash: map["output_hash"] as String?,
        expectedToAmount: map["expected_to_amount"] as String,
        location: map["location"] as String,
        createdAt: map["created_at"] as String,
        updatedAt: map["updated_at"] as String,
        partnerId: map["partner_id"] as String,
        externalPartnerLinkId: map["external_partner_link_id"] as String?,
        fromAmountInEur: map["from_amount_in_eur"] as String?,
        customerPayoutAddressChangeable:
            map["customer_payout_address_changeable"] as bool?,
        estimateBreakdown: EstimateBreakdown.fromMap(
            map["estimate_breakdown"] as Map<dynamic, dynamic>),
        payout: map["payout"] is Map
            ? Payout.fromMap(map["payout"] as Map<dynamic, dynamic>)
            : null,
        depositPaymentCategory: EGPaymentCategory.fromString(
            map["deposit_payment_category"] as String),
        payoutPaymentCategory: EGPaymentCategory.fromString(
            map["payout_payment_category"] as String),
        redirectUrl: map["redirect_url"] as String?,
        preauthToken: map["preauth_token"] as String?,
        skipChoosePayoutAddress: map["skip_choose_payout_address"] as bool?,
        skipChoosePaymentCategory: map["skip_choose_payment_category"] as bool?,
      );
    } catch (e) {
      rethrow;
      // throw Exception("Invalid json \"$map\" passed to GTransaction.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType(id: $id, status: $status, email: $email, errors: $errors,"
        " statusDetails: $statusDetails, fromCurrency: $fromCurrency,"
        " initialFromCurrency: $initialFromCurrency, fromNetwork: $fromNetwork,"
        " fromCurrencyWithNetwork: $fromCurrencyWithNetwork, fromAmount: $fromAmount,"
        " depositType: $depositType, payoutType: $payoutType, "
        "expectedFromAmount: $expectedFromAmount, "
        "initialExpectedFromAmount: $initialExpectedFromAmount, toCurrency: $toCurrency, "
        "toNetwork: $toNetwork, toCurrencyWithNetwork: $toCurrencyWithNetwork, "
        "toAmount: $toAmount, outputHash: $outputHash, expectedToAmount: $expectedToAmount,"
        " location: $location, createdAt: $createdAt, updatedAt: $updatedAt,"
        " partnerId: $partnerId, externalPartnerLinkId: $externalPartnerLinkId, "
        "fromAmountInEur: $fromAmountInEur, customerPayoutAddressChangeable: "
        "$customerPayoutAddressChangeable, estimateBreakdown: $estimateBreakdown,"
        " payout: $payout, depositPaymentCategory: $depositPaymentCategory, "
        "payoutPaymentCategory: $payoutPaymentCategory, redirectUrl: $redirectUrl,"
        " preauthToken: $preauthToken, skipChoosePayoutAddress: "
        "$skipChoosePayoutAddress, skipChoosePaymentCategory: $skipChoosePaymentCategory)";
  }
}

class EstimateBreakdown {
  final String toAmount;
  final String fromAmount;
  final List<dynamic> serviceFees;
  final Map<String, dynamic> convertedAmount;
  final String estimatedExchangeRate;
  final Map<String, dynamic> networkFee;
  final Map<String, dynamic> partnerFee;

  const EstimateBreakdown({
    required this.toAmount,
    required this.fromAmount,
    required this.serviceFees,
    required this.convertedAmount,
    required this.estimatedExchangeRate,
    required this.networkFee,
    required this.partnerFee,
  });

  static EstimateBreakdown fromMap(Map<dynamic, dynamic> map) {
    return EstimateBreakdown(
      toAmount: map["toAmount"] as String,
      fromAmount: map["fromAmount"].toString(),
      serviceFees: map["serviceFees"] as List<dynamic>,
      convertedAmount: map["convertedAmount"] as Map<String, dynamic>,
      estimatedExchangeRate: map["estimatedExchangeRate"] as String,
      networkFee: map["networkFee"] as Map<String, dynamic>,
      partnerFee: map["partnerFee"] as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return "$runtimeType(toAmount: $toAmount, fromAmount: $fromAmount, "
        "serviceFees: $serviceFees, convertedAmount: $convertedAmount, "
        "estimatedExchangeRate: $estimatedExchangeRate, networkFee: $networkFee, "
        "partnerFee: $partnerFee)";
  }
}

class Payout {
  final String address;
  final String extraId;

  const Payout({
    required this.address,
    required this.extraId,
  });

  static Payout fromMap(Map<dynamic, dynamic> map) {
    return Payout(
      address: map["address"] as String,
      extraId: map["extra_id"] as String,
    );
  }

  @override
  String toString() {
    return "$runtimeType(address: $address, extraId: $extraId)";
  }
}
