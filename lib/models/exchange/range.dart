import 'package:decimal/decimal.dart';

class Range {
  final String exchangeName;
  final String from;
  final String to;
  final String fromNetwork;
  final String toNetwork;
  final bool fixedRate;
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
    required this.fixedRate,
  });

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
      exchangeName: json['exchangeName'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      fromNetwork: json['fromNetwork'] as String,
      toNetwork: json['toNetwork'] as String,
      fixedRate: (json['flow'] as String) == "fixed-rate",
      min: json['min'] != null ? Decimal.parse(json['min'] as String) : null,
      max: json['max'] != null ? Decimal.parse(json['max'] as String) : null,
    );
  }

  Range copyWith({
    Decimal? min,
    Decimal? max,
    String? exchangeName,
    String? from,
    String? to,
    String? fromNetwork,
    String? toNetwork,
    bool? fixedRate,
  }) {
    return Range(
      min: min ?? this.min,
      max: max ?? this.max,
      exchangeName: exchangeName ?? this.exchangeName,
      from: from ?? this.from,
      to: to ?? this.to,
      fromNetwork: fromNetwork ?? this.fromNetwork,
      toNetwork: toNetwork ?? this.toNetwork,
      fixedRate: fixedRate ?? this.fixedRate,
    );
  }

  @override
  String toString() {
    return 'Range('
        'exchangeName: $exchangeName, '
        'from: $from, '
        'to: $to, '
        'fromNetwork: $fromNetwork, '
        'toNetwork: $toNetwork, '
        'fixedRate: $fixedRate, '
        'min: $min, '
        'max: $max)';
  }
}
