class GEstimate {
  final String toCurrency;
  final String fromCurrency;
  final String? toNetwork;
  final String? fromNetwork;
  final String value;
  final String estimatedExchangeRate;

  const GEstimate({
    required this.toCurrency,
    required this.fromCurrency,
    this.toNetwork,
    this.fromNetwork,
    required this.value,
    required this.estimatedExchangeRate,
  });

  static GEstimate fromMap(Map<dynamic, dynamic> map) {
    try {
      return GEstimate(
        toCurrency: map["to_currency"] as String,
        fromCurrency: map["from_currency"] as String,
        toNetwork: map["to_network"] as String,
        fromNetwork: map["from_network"] as String?,
        value: map["value"] as String,
        estimatedExchangeRate: map["estimated_exchange_rate"] as String,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GEstimate.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType("
        "toCurrency: $toCurrency, "
        "fromCurrency: $fromCurrency, "
        "toNetwork: $toNetwork, "
        "fromNetwork: $fromNetwork, "
        "value: $value, "
        "estimatedExchangeRate: $estimatedExchangeRate)";
  }
}
