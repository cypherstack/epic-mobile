import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:flutter/foundation.dart';

class IncompleteExchangeModel extends ChangeNotifier {
  final String sendTicker;
  final String receiveTicker;

  final String rateInfo;

  final Decimal sendAmount;
  final Decimal receiveAmount;

  final SupportedRateType rateType;

  final bool reversed;
  final bool walletInitiated;

  String? _recipientAddress;

  String? get recipientAddress => _recipientAddress;

  set recipientAddress(String? recipientAddress) {
    if (_recipientAddress != recipientAddress) {
      _recipientAddress = recipientAddress;
      notifyListeners();
    }
  }

  String? _refundAddress;

  String? get refundAddress => _refundAddress;

  set refundAddress(String? refundAddress) {
    if (_refundAddress != refundAddress) {
      _refundAddress = refundAddress;
      notifyListeners();
    }
  }

  Estimate? _estimate;

  Estimate? get estimate => _estimate;

  set estimate(Estimate? estimate) {
    if (_estimate != estimate) {
      _estimate = estimate;
      notifyListeners();
    }
  }

  Trade? _trade;

  Trade? get trade => _trade;

  set trade(Trade? trade) {
    if (_trade != trade) {
      _trade = trade;
      notifyListeners();
    }
  }

  IncompleteExchangeModel({
    required this.sendTicker,
    required this.receiveTicker,
    required this.rateInfo,
    required this.sendAmount,
    required this.receiveAmount,
    required this.rateType,
    required this.reversed,
    required this.walletInitiated,
    Estimate? estimate,
  }) : _estimate = estimate;
}
