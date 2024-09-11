import 'package:epicpay/services/guardarian/enums.dart';

class GCurrency {
  final String id;
  final GCurrencyType currencyType;
  final String ticker;
  final String name;
  final bool enabled;
  final bool enabledSubscription;
  final bool hasExternalId;
  final bool? isFeatured;
  final bool? isStable;
  final bool? isAvailable;
  final String logoUrl;
  final List<PaymentMethod> paymentMethods;
  final String? blockExplorerUrlMask;
  final String? defaultExchangeValue;
  final List<Network> networks;

  const GCurrency._({
    required this.id,
    required this.currencyType,
    required this.ticker,
    required this.name,
    required this.enabled,
    required this.enabledSubscription,
    required this.hasExternalId,
    this.isFeatured,
    this.isStable,
    this.isAvailable,
    required this.logoUrl,
    required this.paymentMethods,
    this.blockExplorerUrlMask,
    this.defaultExchangeValue,
    required this.networks,
  });

  factory GCurrency.fromMap(Map<dynamic, dynamic> map) {
    return GCurrency._(
      id: map["id"] as String,
      currencyType: GCurrencyType.fromString(map["currency_type"] as String),
      ticker: map["ticker"] as String,
      name: map["name"] as String,
      enabled: map["enabled"] as bool,
      enabledSubscription: map["enabled_subscription"] as bool,
      hasExternalId: map["has_external_id"] as bool,
      isFeatured: map["is_featured"] as bool?,
      isStable: map["is_stable"] as bool?,
      isAvailable: map["is_available"] as bool?,
      logoUrl: map["logo_url"] as String,
      paymentMethods: map["payment_methods"] is List
          ? (map["payment_methods"] as List<dynamic>)
              .map((e) => PaymentMethod._fromMap(e as Map<dynamic, dynamic>))
              .toList()
          : [],
      blockExplorerUrlMask: map["block_explorer_url_mask"] as String?,
      defaultExchangeValue: map["default_exchange_value"] as String?,
      networks: map["networks"] is List
          ? (map["networks"] as List<dynamic>)
              .map((e) => Network._fromMap(e as Map<dynamic, dynamic>))
              .toList()
          : [],
    );
  }

  @override
  String toString() {
    return "$runtimeType(id: $id, currencyType: $currencyType, ticker: $ticker, name: $name, enabled: $enabled, enabledSubscription: $enabledSubscription, hasExternalId: $hasExternalId, isFeatured: $isFeatured, isStable: $isStable, isAvailable: $isAvailable, logoUrl: $logoUrl, paymentMethods: $paymentMethods, blockExplorerUrlMask: $blockExplorerUrlMask, defaultExchangeValue: $defaultExchangeValue, networks: $networks)";
  }
}

class PaymentMethod {
  final EGPaymentType type;
  final EGPaymentCategory paymentCategory;
  final bool depositEnabled;
  final bool withdrawalEnabled;

  const PaymentMethod._({
    required this.type,
    required this.paymentCategory,
    required this.depositEnabled,
    required this.withdrawalEnabled,
  });

  factory PaymentMethod._fromMap(Map<dynamic, dynamic> map) {
    return PaymentMethod._(
      type: EGPaymentType.fromString(map["type"] as String),
      paymentCategory:
          EGPaymentCategory.fromString(map["payment_category"] as String),
      depositEnabled: map["deposit_enabled"] as bool,
      withdrawalEnabled: map["withdrawal_enabled"] as bool,
    );
  }

  @override
  String toString() {
    return "$runtimeType(type: $type, paymentCategory: $paymentCategory, depositEnabled: $depositEnabled, withdrawalEnabled: $withdrawalEnabled)";
  }
}

class Network {
  final String name;
  final String network;
  final String? blockExplorerUrlMask;
  final String? tokenContract;
  final bool enabledSubscription;
  final List<PaymentMethod> paymentMethods;

  const Network._({
    required this.name,
    required this.network,
    this.blockExplorerUrlMask,
    this.tokenContract,
    required this.enabledSubscription,
    required this.paymentMethods,
  });

  factory Network._fromMap(Map<dynamic, dynamic> map) {
    return Network._(
      name: map["name"] as String,
      network: map["network"] as String,
      blockExplorerUrlMask: map["block_explorer_url_mask"] as String?,
      tokenContract: map["token_contract"] as String?,
      enabledSubscription: map["enabled_subscription"] as bool,
      paymentMethods: (map["payment_methods"] as List<dynamic>)
          .map((e) => PaymentMethod._fromMap(e as Map<dynamic, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return "$runtimeType(name: $name, network: $network, blockExplorerUrlMask: $blockExplorerUrlMask, tokenContract: $tokenContract, enabledSubscription: $enabledSubscription, paymentMethods: $paymentMethods)";
  }
}
