class GMarketInfo {
  final String from;
  final String to;
  final num min;
  final num max;

  const GMarketInfo({
    required this.from,
    required this.to,
    required this.min,
    required this.max,
  });

  static GMarketInfo fromMap(Map<dynamic, dynamic> map) {
    try {
      return GMarketInfo(
        from: map["from"] as String,
        to: map["to"] as String,
        min: map["min"] as num,
        max: map["max"] as num,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GMarketInfo.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType(from: $from, to: $to, min: $min, max: $max)";
  }
}
