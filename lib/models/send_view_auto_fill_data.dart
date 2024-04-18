import 'package:decimal/decimal.dart';

class SendViewAutoFillData {
  final String address;
  final String contactLabel;
  final Decimal? amount;
  final String note;
  final String onChainNote;
  final bool pay;
  final String? overrideEpicBoxServer;

  SendViewAutoFillData({
    required this.address,
    required this.contactLabel,
    this.amount,
    this.note = "",
    this.onChainNote = "",
    this.pay = false,
    this.overrideEpicBoxServer,
  });

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "contactLabel": contactLabel,
      "amount": amount,
      "note": note,
      "onChainNote": onChainNote,
      "pay": pay,
      "overrideEpicBoxServer": overrideEpicBoxServer,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
