import 'package:decimal/decimal.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';

class Range {
  final String exchangeName;
  final String from;
  final String to;
  final String fromNetwork;
  final String toNetwork;
  final SupportedRateType rateType;
  final Decimal? min;
  final Decimal? max;

  Range({
    this.min,
    this.max,
    required this.exchangeName,
    required this.from,
    required this.to,
    required this.fromNetwork,
    required this.toNetwork,
    required this.rateType,
  });

  Map<String, dynamic> toMap() {
    final map = {
      "min": min?.toString(),
      "max": max?.toString(),
    };

    return map;
  }

  @override
  String toString() {
    return "Range: ${toMap()}";
  }
}
