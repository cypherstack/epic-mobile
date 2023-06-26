import 'package:decimal/decimal.dart';
import 'package:epicpay/utilities/logger.dart';

class Estimate {
  final Decimal fromAmount;
  final Decimal toAmount;
  final bool fixedRate;
  final bool reversed;
  final String? warningMessage;
  final String? rateId;
  final String exchangeProvider;
  final String? kycRating;
  final DateTime? expiresAt;

  Estimate({
    required this.fromAmount,
    required this.toAmount,
    required this.fixedRate,
    required this.reversed,
    this.warningMessage,
    this.rateId,
    required this.exchangeProvider,
    this.kycRating,
    required this.expiresAt,
  });

  factory Estimate.fromMap(
    Map<String, dynamic> map, {
    required String exchangeProvider,
    String? kycRating,
  }) {
    try {
      return Estimate(
        fromAmount: Decimal.parse(map["fromAmount"] as String),
        toAmount: Decimal.parse(map["toAmount"] as String),
        fixedRate: map["fixedRate"] as bool,
        reversed: map["reversed"] as bool,
        warningMessage: map["warningMessage"] as String?,
        rateId: map["rateId"] as String?,
        exchangeProvider: exchangeProvider,
        kycRating: kycRating,
        expiresAt: DateTime.tryParse(map["validUntil"] as String? ?? ""),
      );
    } catch (e, s) {
      Logging.instance.log("Estimate.fromMap(): $e\n$s", level: LogLevel.Error);
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "fromAmount": fromAmount.toString(),
      "toAmount": toAmount.toString(),
      "fixedRate": fixedRate,
      "reversed": reversed,
      "warningMessage": warningMessage,
      "rateId": rateId,
      "exchangeProvider": exchangeProvider,
      "kycRating": kycRating,
      "expiresAt": expiresAt?.toIso8601String(),
    };
  }

  @override
  String toString() => "Estimate: ${toMap()}";
}
