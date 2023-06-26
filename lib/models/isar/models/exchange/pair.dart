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
    composite: [
      CompositeIndex("computedIndex"),
    ],
    unique: true,
    replace: true,
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
