import 'package:decimal/decimal.dart';

class TransactionDTO {
  final Decimal fromAmount;
  final Decimal toAmount;
  final String flow;
  final String type;
  final String payinAddress;
  final String payoutAddress;
  final String payoutExtraId;
  final String fromCurrency;
  final String toCurrency;
  final String refundAddress;
  final String refundExtraId;
  final String id;
  final String fromNetwork;
  final String toNetwork;

  TransactionDTO({
    required this.fromAmount,
    required this.toAmount,
    required this.flow,
    required this.type,
    required this.payinAddress,
    required this.payoutAddress,
    required this.payoutExtraId,
    required this.fromCurrency,
    required this.toCurrency,
    required this.refundAddress,
    required this.refundExtraId,
    required this.id,
    required this.fromNetwork,
    required this.toNetwork,
  });

  factory TransactionDTO.fromJson(Map<String, dynamic> json) {
    return TransactionDTO(
      fromAmount: Decimal.parse(json['fromAmount'].toString()),
      toAmount: Decimal.parse(json['toAmount'].toString()),
      flow: json['flow'] as String,
      type: json['type'] as String,
      payinAddress: json['payinAddress'] as String,
      payoutAddress: json['payoutAddress'] as String,
      payoutExtraId: json['payoutExtraId'] as String,
      fromCurrency: json['fromCurrency'] as String,
      toCurrency: json['toCurrency'] as String,
      refundAddress: json['refundAddress'] as String,
      refundExtraId: json['refundExtraId'] as String,
      id: json['id'] as String,
      fromNetwork: json['fromNetwork'] as String,
      toNetwork: json['toNetwork'] as String,
    );
  }

  @override
  String toString() {
    return 'TransactionDTO('
        'fromAmount: $fromAmount, '
        'toAmount: $toAmount, '
        'flow: $flow, '
        'type: $type, '
        'payinAddress: $payinAddress, '
        'payoutAddress: $payoutAddress, '
        'payoutExtraId: $payoutExtraId, '
        'fromCurrency: $fromCurrency, '
        'toCurrency: $toCurrency, '
        'refundAddress: $refundAddress, '
        'refundExtraId: $refundExtraId, '
        'id: $id, '
        'fromNetwork: $fromNetwork, '
        'toNetwork: $toNetwork)';
  }
}
