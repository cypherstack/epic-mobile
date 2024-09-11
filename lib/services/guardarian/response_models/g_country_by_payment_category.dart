import 'package:epicpay/services/guardarian/enums.dart';

class GCountryByPaymentCategory {
  final String countryName;
  final String codeIsoAlpha2;
  final String codeIsoAlpha3;
  final bool depositEnabled;
  final bool withdrawalEnabled;
  final EGPaymentCategory category;

  const GCountryByPaymentCategory({
    required this.countryName,
    required this.codeIsoAlpha2,
    required this.codeIsoAlpha3,
    required this.depositEnabled,
    required this.withdrawalEnabled,
    required this.category,
  });

  static GCountryByPaymentCategory fromMap(Map<dynamic, dynamic> map) {
    return GCountryByPaymentCategory(
      countryName: map["country_name"] as String,
      codeIsoAlpha2: map["code_iso_alpha_2"] as String,
      codeIsoAlpha3: map["code_iso_alpha_3"] as String,
      depositEnabled: map["deposit_enabled"] as bool,
      withdrawalEnabled: map["withdrawal_enabled"] as bool,
      category: map["category"] as EGPaymentCategory,
    );
  }

  @override
  String toString() {
    return "$runtimeType("
        "countryName: $countryName, "
        "codeIsoAlpha2: $codeIsoAlpha2, "
        "codeIsoAlpha3: $codeIsoAlpha3, "
        "depositEnabled: $depositEnabled, "
        "withdrawalEnabled: $withdrawalEnabled, "
        "category: $category)";
  }
}
