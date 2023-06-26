import 'package:isar/isar.dart';

part 'trade.g.dart';

@Collection(accessor: "trades")
class Trade {
  Id id = Isar.autoIncrement;

  @Index(
    unique: true,
    replace: false,
    composite: [
      CompositeIndex("exchangeName"),
    ],
  )
  final String tradeId;
  final String exchangeName;

  final String fromAmount;
  final String toAmount;
  final String flow;
  final String type;
  final String payinAddress;
  final String payoutAddress;
  final String payoutExtraId;
  final String fromCurrency;
  final String toCurrency;
  final String refundAddress;
  final String refundExtraId;
  final String fromNetwork;
  final String toNetwork;
  final String status;

  Trade({
    required this.exchangeName,
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
    required this.tradeId,
    required this.fromNetwork,
    required this.toNetwork,
    required this.status,
  });

  factory Trade.fromJson(Map<String, dynamic> json, String exchangeName) {
    return Trade(
      exchangeName: exchangeName,
      fromAmount: json['fromAmount'].toString(),
      toAmount: json['toAmount'].toString(),
      flow: json['flow'] as String,
      type: json['type'] as String,
      payinAddress: json['payinAddress'] as String,
      payoutAddress: json['payoutAddress'] as String,
      payoutExtraId: json['payoutExtraId'] as String,
      fromCurrency: json['fromCurrency'] as String,
      toCurrency: json['toCurrency'] as String,
      refundAddress: json['refundAddress'] as String,
      refundExtraId: json['refundExtraId'] as String,
      tradeId: json['id'] as String,
      fromNetwork: json['fromNetwork'] as String,
      toNetwork: json['toNetwork'] as String,
      status: json['status'] as String? ?? "new",
    );
  }

  @override
  String toString() {
    return 'TransactionDTO('
        'exchangeName: $exchangeName, '
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
