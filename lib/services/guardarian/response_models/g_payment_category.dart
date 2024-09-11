import 'package:epicpay/services/guardarian/enums.dart';

class GPaymentCategory {
  final int id;
  final String name;
  final EGPaymentCategory category;

  const GPaymentCategory({
    required this.id,
    required this.name,
    required this.category,
  });

  static GPaymentCategory fromMap(Map<dynamic, dynamic> map) {
    try {
      return GPaymentCategory(
        id: map["id"] as int,
        name: map["name"] as String,
        category: EGPaymentCategory.fromString(map["category"] as String),
      );
    } catch (_) {
      throw Exception(
          "Invalid json \"$map\" passed to GPaymentCategory.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType(id: $id, name: $name, category: $category)";
  }
}
