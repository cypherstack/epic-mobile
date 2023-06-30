import 'package:isar/isar.dart';

part 'pair.g.dart';

// embedded enum // no not modify
enum SupportedRateType { fixed, estimated, both }

@collection
class Pair {
  Pair({
    required this.exchangeName,
    required this.from,
    required this.to,
    required this.fromNetwork,
    required this.toNetwork,
    required this.rateType,
  });

  Id? id;

  @Index(
    unique: true,
    replace: true,
    composite: [
      CompositeIndex("computedIndex"),
    ],
  )
  final String exchangeName;

  final String from;

  final String to;

  final String fromNetwork;

  final String toNetwork;

  @enumerated
  final SupportedRateType rateType;

  String get computedIndex =>
      from + fromNetwork + to + toNetwork + rateType.name;

  factory Pair.fromJson(Map<String, dynamic> json, String exchangeName) {
    final standard = json["flow"]["standard"] == true;
    final fixedRate = json["flow"]["fixed-rate"] == true;
    return Pair(
      exchangeName: exchangeName,
      from: json["fromCurrency"] as String,
      to: json["toCurrency"] as String,
      fromNetwork: json["fromNetwork"] as String,
      toNetwork: json["toNetwork"] as String,
      rateType: standard && fixedRate
          ? SupportedRateType.both
          : standard
              ? SupportedRateType.estimated
              : SupportedRateType.fixed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "exchangeName": exchangeName,
      "from": from,
      "to": to,
      "fromNetwork": fromNetwork,
      "toNetwork": toNetwork,
      "rateType": rateType,
    };
  }

  @override
  bool operator ==(other) =>
      other is Pair &&
      exchangeName == other.exchangeName &&
      from == other.from &&
      to == other.to &&
      fromNetwork == other.fromNetwork &&
      toNetwork == other.toNetwork &&
      rateType == other.rateType;

  @override
  int get hashCode => Object.hash(
        exchangeName,
        from,
        to,
        fromNetwork,
        toNetwork,
        rateType,
      );

  @override
  String toString() => "Pair: ${toMap()}";
}
