class GCountry {
  final String id;
  final String countryName;
  final String codeIsoAlpha2;
  final String codeIsoAlpha3;
  final String codeIsoNumeric;
  final bool supported;

  const GCountry({
    required this.id,
    required this.countryName,
    required this.codeIsoAlpha2,
    required this.codeIsoAlpha3,
    required this.codeIsoNumeric,
    required this.supported,
  });

  static GCountry fromMap(Map<dynamic, dynamic> map) {
    try {
      return GCountry(
        id: map["id"] as String,
        countryName: map["country_name"] as String,
        codeIsoAlpha2: map["code_iso_alpha_2"] as String,
        codeIsoAlpha3: map["code_iso_alpha_3"] as String,
        codeIsoNumeric: map["code_iso_numeric"] as String,
        supported: map["supported"] as bool,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GCountry.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType(id: $id, "
        "countryName: $countryName, "
        "codeIsoAlpha2: $codeIsoAlpha2, "
        "codeIsoAlpha3: $codeIsoAlpha3, "
        "codeIsoNumeric: $codeIsoNumeric, "
        "supported: $supported)";
  }
}
