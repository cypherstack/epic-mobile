import 'package:decimal/decimal.dart';

class Range {
  final String exchangeName;
  final String fromCurrency;
  final String toCurrency;
  final String fromNetwork;
  final String toNetwork;
  final bool fixedRate;
  final Decimal? min;
  final Decimal? max;

  Range({
    this.min,
    this.max,
    required this.exchangeName,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromNetwork,
    required this.toNetwork,
    required this.fixedRate,
  });

  factory Range.fromJson(Map<String, dynamic> json, String exchangeName) {
    return Range(
      exchangeName: exchangeName,
      fromCurrency: json['fromCurrency'] as String,
      toCurrency: json['toCurrency'] as String,
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
    String? fromCurrency,
    String? toCurrency,
    String? fromNetwork,
    String? toNetwork,
    bool? fixedRate,
  }) {
    return Range(
      min: min ?? this.min,
      max: max ?? this.max,
      exchangeName: exchangeName ?? this.exchangeName,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromNetwork: fromNetwork ?? this.fromNetwork,
      toNetwork: toNetwork ?? this.toNetwork,
      fixedRate: fixedRate ?? this.fixedRate,
    );
  }

  @override
  String toString() {
    return 'Range('
        'exchangeName: $exchangeName, '
        'from: $fromCurrency, '
        'to: $toCurrency, '
        'fromNetwork: $fromNetwork, '
        'toNetwork: $toNetwork, '
        'fixedRate: $fixedRate, '
        'min: $min, '
        'max: $max)';
  }
}
