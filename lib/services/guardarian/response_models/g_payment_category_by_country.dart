import 'package:epicpay/services/guardarian/enums.dart';

class GPaymentCategoryByCountry {
  final String name;
  final EGPaymentCategory category;
  final bool depositEnabled;
  final bool withdrawalEnabled;
  final String country;

  const GPaymentCategoryByCountry({
    required this.name,
    required this.category,
    required this.depositEnabled,
    required this.withdrawalEnabled,
    required this.country,
  });

  static GPaymentCategoryByCountry fromMap(Map<dynamic, dynamic> map) {
    try {
      return GPaymentCategoryByCountry(
        name: map["name"] as String,
        category: EGPaymentCategory.fromString(map["category"] as String),
        depositEnabled: map["deposit_enabled"] as bool,
        withdrawalEnabled: map["withdrawal_enabled"] as bool,
        country: map["country"] as String,
      );
    } catch (_) {
      throw Exception(
          "Invalid json \"$map\" passed to GPaymentCategoryByCountry.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType("
        "name: $name, "
        "category: $category, "
        "depositEnabled: $depositEnabled, "
        "withdrawalEnabled: $withdrawalEnabled, "
        "country: $country)";
  }
}
