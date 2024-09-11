enum EGDirection {
  direct,
  reverse,
  unknown;

  static EGDirection fromString(String value) {
    return EGDirection.values
        .firstWhere((e) => e.name == value, orElse: () => EGDirection.unknown);
  }
}

enum EGPaymentCategory {
  CRYPTO,
  SEPA,
  SWIFT,
  FASTERPAYMENTS,
  VISA_MC,
  PIX,
  MANDIRI_VA,
  GOOGLE_PAY,
  APPLE_PAY,
  REVOLUT_PAY,
  SPEI,
  PSE,
  unknown;

  static EGPaymentCategory fromString(String value) {
    return EGPaymentCategory.values.firstWhere((e) => e.name == value,
        orElse: () => EGPaymentCategory.unknown);
  }
}

enum EGPaymentType {
  SEPA_1,
  VISA_MC1,
  UNIONPAY,
  LUQAPAY,
  VISA_MC2,
  VISA_MC3,
  SEPA_2,
  VISA_MC4,
  VISA_MC5,
  APPLE_PAY_1,
  GOOGLE_PAY_1,
  VISA_MC6,
  CRYPTO_THROUGH_CN,
  CRYPTO_2,
  unknown;

  static EGPaymentType fromString(String value) {
    return EGPaymentType.values.firstWhere((e) => e.name == value,
        orElse: () => EGPaymentType.unknown);
  }
}

enum GCurrencyType {
  FIAT,
  CRYPTO,
  unknown;

  static GCurrencyType fromString(String value) {
    return GCurrencyType.values.firstWhere((e) => e.name == value,
        orElse: () => GCurrencyType.unknown);
  }
}

enum EGTransactionStatus {
  New("new"),
  WaitingForCustomer("waiting_for_customer"),
  WaitingForDeposit("waiting_for_deposit"),
  Exchanging("exchanging"),
  OnHold("on_hold"),
  Sending("sending"),
  Finished("finished"),
  Failed("failed"),
  Expired("expired"),
  Cancelled("cancelled"),
  Refunded("refunded"),
  Unknown("unknown");

  final String value;
  const EGTransactionStatus(this.value);

  static EGTransactionStatus fromString(String value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => EGTransactionStatus.Unknown);
  }

  String get prettyName {
    if (value.contains("_")) {
      return value.split("_").map((e) {
        return "${e.substring(0, 1).toUpperCase()}${e.substring(1)}";
      }).join(" ");
    } else {
      return name;
    }
  }
}
