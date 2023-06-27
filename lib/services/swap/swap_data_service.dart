import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final pSwapDataService = Provider((ref) => SwapDataService(ref.watch(pIsarDB)));

class SwapDataService {
  final IsarDB isarDB;

  SwapDataService(this.isarDB);

  Future<void> updatePairs({Currency? from, Currency? to}) async {
    final exchange = ChangeNowExchange.instance;

    final result = await exchange.getPairs(from, to);

    if (result.value != null) {
      await isarDB.isar.writeTxn(() async {
        await isarDB.isar.pairs
            .where()
            .exchangeNameEqualToAnyComputedIndex(exchange.name)
            .deleteAll();
        await isarDB.isar.pairs.putAll(result.value!);
      });
    } else {
      if (result.exception != null) {
        throw result.exception!;
      }

      throw Exception(
        "SwapDataService.updatePairs(from: $from, to: $to) failed for some unknown reason.",
      );
    }
  }

  Future<void> updateCurrencies() async {
    final exchange = ChangeNowExchange.instance;

    final result = await exchange
        .getAllCurrencies(false); // false should grab both flow types?

    if (result.value != null) {
      await isarDB.isar.writeTxn(() async {
        await isarDB.isar.currencies
            .where()
            .exchangeNameEqualTo(exchange.name)
            .deleteAll();
        await isarDB.isar.currencies.putAll(result.value!);
      });
    } else {
      if (result.exception != null) {
        throw result.exception!;
      }

      throw Exception(
        "SwapDataService.updateCurrencies() failed for some unknown reason.",
      );
    }
  }
}
