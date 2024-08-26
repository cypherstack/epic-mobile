import 'package:isar/isar.dart';

part 'trade.g.dart';

@Collection(accessor: "trades")
class Trade {
  Id id = Isar.autoIncrement;

  @Index(
    unique: true,
    replace: true,
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

  final String? createdAt;
  final String? updatedAt;
  final String? payinHash;
  final String? payoutHash;

  int get timestampUTC =>
      (DateTime.tryParse(createdAt.toString())?.toUtc() ?? DateTime.now())
          .millisecondsSinceEpoch ~/
      1000;

  final bool? zBuy;

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
    required this.createdAt,
    required this.updatedAt,
    required this.payinHash,
    required this.payoutHash,
    required this.zBuy,
  });

  factory Trade.fromJson(
      Map<String, dynamic> json, String exchangeName, bool zBuy) {
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
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      payinHash: json['payinHash'] as String?,
      payoutHash: json['payoutHash'] as String?,
      zBuy: zBuy,
    );
  }

  Trade copyWith({
    String? fromAmount,
    String? toAmount,
    String? flow,
    String? type,
    String? payinAddress,
    String? payoutAddress,
    String? payoutExtraId,
    String? fromCurrency,
    String? toCurrency,
    String? refundAddress,
    String? refundExtraId,
    String? fromNetwork,
    String? toNetwork,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? payinHash,
    String? payoutHash,
    bool? zBuy,
  }) {
    return Trade(
      tradeId: tradeId,
      exchangeName: exchangeName,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      flow: flow ?? this.flow,
      type: type ?? this.type,
      payinAddress: payinAddress ?? this.payinAddress,
      payoutAddress: payoutAddress ?? this.payoutAddress,
      payoutExtraId: payoutExtraId ?? this.payoutExtraId,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      refundAddress: refundAddress ?? this.refundAddress,
      refundExtraId: refundExtraId ?? this.refundExtraId,
      fromNetwork: fromNetwork ?? this.fromNetwork,
      toNetwork: toNetwork ?? this.toNetwork,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      payinHash: payinHash ?? this.payinHash,
      payoutHash: payoutHash ?? this.payoutHash,
      zBuy: zBuy ?? this.zBuy,
    );
  }

  @override
  String toString() {
    return 'Trade('
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
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'payinHash: $payinHash, '
        'payoutHash: $payoutHash, '
        'fromNetwork: $fromNetwork, '
        'zBuy: $zBuy, '
        'toNetwork: $toNetwork)';
  }
}
