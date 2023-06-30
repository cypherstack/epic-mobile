import 'package:decimal/decimal.dart';

class TransactionStatusDTO {
  String tradeId;
  String status;
  bool actionsAvailable;
  String fromCurrency;
  String fromNetwork;
  String toCurrency;
  String toNetwork;
  Decimal? expectedAmountFrom;
  Decimal? expectedAmountTo;
  Decimal? amountFrom;
  Decimal? amountTo;
  String payinAddress;
  String payoutAddress;
  String? payinExtraId;
  String? payoutExtraId;
  String? refundAddress;
  String? refundExtraId;
  String createdAt;
  String updatedAt;
  String? depositReceivedAt;
  String? payinHash;
  String? payoutHash;
  String fromLegacyTicker;
  String toLegacyTicker;

  TransactionStatusDTO({
    required this.tradeId,
    required this.status,
    required this.actionsAvailable,
    required this.fromCurrency,
    required this.fromNetwork,
    required this.toCurrency,
    required this.toNetwork,
    this.expectedAmountFrom,
    this.expectedAmountTo,
    this.amountFrom,
    this.amountTo,
    required this.payinAddress,
    required this.payoutAddress,
    this.payinExtraId,
    this.payoutExtraId,
    this.refundAddress,
    this.refundExtraId,
    required this.createdAt,
    required this.updatedAt,
    this.depositReceivedAt,
    this.payinHash,
    this.payoutHash,
    required this.fromLegacyTicker,
    required this.toLegacyTicker,
  });

  factory TransactionStatusDTO.fromJson(Map<String, dynamic> json) {
    return TransactionStatusDTO(
      tradeId: json['id'] as String,
      status: json['status'] as String,
      actionsAvailable: json['actionsAvailable'] as bool,
      fromCurrency: json['fromCurrency'] as String,
      fromNetwork: json['fromNetwork'] as String,
      toCurrency: json['toCurrency'] as String,
      toNetwork: json['toNetwork'] as String,
      expectedAmountFrom:
          Decimal.tryParse(json['expectedAmountFrom'].toString()),
      expectedAmountTo: Decimal.tryParse(json['expectedAmountTo'].toString()),
      amountFrom: Decimal.tryParse(json['amountFrom'].toString()),
      amountTo: Decimal.tryParse(json['amountTo'].toString()),
      payinAddress: json['payinAddress'] as String,
      payoutAddress: json['payoutAddress'] as String,
      payinExtraId: json['payinExtraId'] as String?,
      payoutExtraId: json['payoutExtraId'] as String?,
      refundAddress: json['refundAddress'] as String?,
      refundExtraId: json['refundExtraId'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      depositReceivedAt: json['depositReceivedAt'] as String?,
      payinHash: json['payinHash'] as String?,
      payoutHash: json['payoutHash'] as String?,
      fromLegacyTicker: json['fromLegacyTicker'] as String,
      toLegacyTicker: json['toLegacyTicker'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tradeId,
      'status': status,
      'actionsAvailable': actionsAvailable,
      'fromCurrency': fromCurrency,
      'fromNetwork': fromNetwork,
      'toCurrency': toCurrency,
      'toNetwork': toNetwork,
      'expectedAmountFrom': expectedAmountFrom,
      'expectedAmountTo': expectedAmountTo,
      'amountFrom': amountFrom,
      'amountTo': amountTo,
      'payinAddress': payinAddress,
      'payoutAddress': payoutAddress,
      'payinExtraId': payinExtraId,
      'payoutExtraId': payoutExtraId,
      'refundAddress': refundAddress,
      'refundExtraId': refundExtraId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'depositReceivedAt': depositReceivedAt,
      'payinHash': payinHash,
      'payoutHash': payoutHash,
      'fromLegacyTicker': fromLegacyTicker,
      'toLegacyTicker': toLegacyTicker,
    };
  }

  TransactionStatusDTO copyWith({
    String? tradeId,
    String? status,
    bool? actionsAvailable,
    String? fromCurrency,
    String? fromNetwork,
    String? toCurrency,
    String? toNetwork,
    Decimal? expectedAmountFrom,
    Decimal? expectedAmountTo,
    Decimal? amountFrom,
    Decimal? amountTo,
    String? payinAddress,
    String? payoutAddress,
    String? payinExtraId,
    String? payoutExtraId,
    String? refundAddress,
    String? refundExtraId,
    String? createdAt,
    String? updatedAt,
    String? depositReceivedAt,
    String? payinHash,
    String? payoutHash,
    String? fromLegacyTicker,
    String? toLegacyTicker,
  }) {
    return TransactionStatusDTO(
      tradeId: tradeId ?? this.tradeId,
      status: status ?? this.status,
      actionsAvailable: actionsAvailable ?? this.actionsAvailable,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      fromNetwork: fromNetwork ?? this.fromNetwork,
      toCurrency: toCurrency ?? this.toCurrency,
      toNetwork: toNetwork ?? this.toNetwork,
      expectedAmountFrom: expectedAmountFrom ?? this.expectedAmountFrom,
      expectedAmountTo: expectedAmountTo ?? this.expectedAmountTo,
      amountFrom: amountFrom ?? this.amountFrom,
      amountTo: amountTo ?? this.amountTo,
      payinAddress: payinAddress ?? this.payinAddress,
      payoutAddress: payoutAddress ?? this.payoutAddress,
      payinExtraId: payinExtraId ?? this.payinExtraId,
      payoutExtraId: payoutExtraId ?? this.payoutExtraId,
      refundAddress: refundAddress ?? this.refundAddress,
      refundExtraId: refundExtraId ?? this.refundExtraId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      depositReceivedAt: depositReceivedAt ?? this.depositReceivedAt,
      payinHash: payinHash ?? this.payinHash,
      payoutHash: payoutHash ?? this.payoutHash,
      fromLegacyTicker: fromLegacyTicker ?? this.fromLegacyTicker,
      toLegacyTicker: toLegacyTicker ?? this.toLegacyTicker,
    );
  }

  @override
  String toString() {
    return 'TransactionDTO('
        'tradeId: $tradeId, '
        'status: $status, '
        'actionsAvailable: $actionsAvailable, '
        'fromCurrency: $fromCurrency, '
        'fromNetwork: $fromNetwork, '
        'toCurrency: $toCurrency, '
        'toNetwork: $toNetwork, '
        'expectedAmountFrom: $expectedAmountFrom, '
        'expectedAmountTo: $expectedAmountTo, '
        'amountFrom: $amountFrom, '
        'amountTo: $amountTo, '
        'payinAddress: $payinAddress, '
        'payoutAddress: $payoutAddress, '
        'payinExtraId: $payinExtraId, '
        'payoutExtraId: $payoutExtraId, '
        'refundAddress: $refundAddress, '
        'refundExtraId: $refundExtraId, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'depositReceivedAt: $depositReceivedAt, '
        'payinHash: $payinHash, '
        'payoutHash: $payoutHash, '
        'fromLegacyTicker: $fromLegacyTicker, '
        'toLegacyTicker: $toLegacyTicker)';
  }
}
