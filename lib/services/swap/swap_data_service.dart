import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final pSwapDataService = Provider((ref) => SwapDataService(ref.watch(pIsarDB)));

class SwapDataService {
  final IsarDB isarDB;

  SwapDataService(this.isarDB);

  Future<void> updateAll() async {
    try {
      await updateCurrencies();

      final epicCurrencies = await isarDB.isar.currencies
          .where()
          .filter()
          .tickerEqualTo("epic")
          .and()
          .networkEqualTo("epic")
          .and()
          .nameEqualTo("EpicCash")
          .findAll();

      if (epicCurrencies.isEmpty) {
        Logging.instance.log(
          "SwapDataService.updateAll() found no EpicCash currency!",
          level: LogLevel.Error,
        );
        return;
      } else if (epicCurrencies.length > 1) {
        Logging.instance.log(
          "SwapDataService.updateAll() found more than one EpicCash currency: $epicCurrencies",
          level: LogLevel.Error,
        );
      }

      await updatePairs(from: epicCurrencies.first);
      await updatePairs(to: epicCurrencies.first);
    } catch (e, s) {
      Logging.instance.log(
        "SwapDataService.updateAll() failed: $e\n$s",
        level: LogLevel.Error,
      );
    }
  }

  Future<void> updatePairs({Currency? from, Currency? to}) async {
    final exchange = ChangeNowExchange.instance;

    final result = await exchange.getPairs(from, to);

    if (result.value != null) {
      await isarDB.isar.writeTxn(() async {
        if (from == null && to == null) {
          await isarDB.isar.pairs
              .where()
              .exchangeNameEqualToAnyComputedIndex(exchange.name)
              .deleteAll();
        } else {
          await isarDB.isar.pairs
              .where()
              .exchangeNameEqualToAnyComputedIndex(exchange.name)
              .filter()
              .group((q) {
            if (from != null && to != null) {
              return q
                  .fromEqualTo(from.ticker)
                  .and()
                  .fromNetworkEqualTo(from.network)
                  .and()
                  .toEqualTo(to.ticker)
                  .and()
                  .toNetworkEqualTo(to.network);
            } else if (from != null) {
              return q
                  .fromEqualTo(from.ticker)
                  .and()
                  .fromNetworkEqualTo(from.network);
            } else {
              return q.toEqualTo(to!.ticker).and().toNetworkEqualTo(to.network);
            }
          }).deleteAll();
        }

        if (result.value!.isNotEmpty) {
          await isarDB.isar.pairs.putAll(result.value!);
        }
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
        if (result.value!.isNotEmpty) {
          await isarDB.isar.currencies.putAll(result.value!);
        }
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
