import 'package:epicpay/pages/exchange_view/aggregate_currency.dart';
import 'package:flutter/material.dart';

class ActivePair extends ChangeNotifier {
  AggregateCurrency? _send;
  AggregateCurrency? _receive;

  AggregateCurrency? get send => _send;
  AggregateCurrency? get receive => _receive;

  void setSend(
    AggregateCurrency? newSend, {
    bool notifyListeners = false,
  }) {
    _send = newSend;
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  void setReceive(
    AggregateCurrency? newReceive, {
    bool notifyListeners = false,
  }) {
    _receive = newReceive;
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  @override
  String toString() {
    return "ActivePair{ send: $send, receive: $receive }";
  }
}
