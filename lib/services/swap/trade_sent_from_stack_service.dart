import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/models/trade_wallet_lookup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tradeSentFromStackLookupProvider =
    ChangeNotifierProvider<TradeSentFromStackService>(
        (ref) => TradeSentFromStackService());

class TradeSentFromStackService extends ChangeNotifier {
  List<TradeWalletLookup> get all =>
      DB.instance.values<TradeWalletLookup>(boxName: DB.boxNameTradeLookup);

  String? getTradeIdForTxid(String slateId) {
    final matches = all.where((e) => e.slateId == slateId);

    if (matches.length == 1) {
      return matches.first.tradeId;
    }
    return null;
  }

  String? getTxidForTradeId(String tradeId) {
    final matches = all.where((e) => e.tradeId == tradeId);

    if (matches.length == 1) {
      return matches.first.slateId;
    }
    return null;
  }

  List<String>? getWalletIdsForTradeId(String tradeId) {
    final matches = all.where((e) => e.tradeId == tradeId);

    if (matches.length == 1) {
      return matches.first.walletIds;
    }
    return null;
  }

  List<String>? getWalletIdForTxid(String slateId) {
    final matches = all.where((e) => e.slateId == slateId);

    if (matches.length == 1) {
      return matches.first.walletIds;
    }
    return null;
  }

  Future<void> save({
    required TradeWalletLookup tradeWalletLookup,
  }) async {
    await DB.instance.put(
        boxName: DB.boxNameTradeLookup,
        key: tradeWalletLookup.uuid,
        value: tradeWalletLookup);
    notifyListeners();
  }

  Future<void> delete({
    required TradeWalletLookup tradeWalletLookup,
  }) async {
    await DB.instance.delete<TradeWalletLookup>(
        key: tradeWalletLookup.uuid, boxName: DB.boxNameTradeLookup);
  }
}
