/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/active_pair.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/services/swap/exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final efEstimatesListProvider = StateProvider.family<
    Tuple2<ExchangeResponse<List<Estimate>>, Range?>?,
    String>((ref, exchangeName) => null);

final efRateTypeProvider =
    StateProvider<SupportedRateType>((ref) => SupportedRateType.estimated);

final efExchangeProvider =
    StateProvider<Exchange>((ref) => Exchange.defaultExchange);
final efExchangeProviderNameProvider =
    StateProvider<String>((ref) => Exchange.defaultExchange.name);

final currentCombinedExchangeIdProvider = Provider<String>((ref) {
  return "${ref.watch(efExchangeProvider).name}"
      " (${ref.watch(efExchangeProviderNameProvider)})";
});

final efSendAmountProvider = StateProvider<Decimal?>((ref) => null);
final efReceiveAmountProvider = StateProvider<Decimal?>((ref) => null);

final efSendAmountStringProvider = StateProvider<String>((ref) {
  final refreshing = ref.watch(efRefreshingProvider);
  final reversed = ref.watch(efReversedProvider);
  if (refreshing && reversed) {
    return "-";
  } else {
    return ref.watch(efSendAmountProvider)?.toString() ?? "";
  }
});
final efReceiveAmountStringProvider = StateProvider<String>((ref) {
  final refreshing = ref.watch(efRefreshingProvider);
  final reversed = ref.watch(efReversedProvider);

  if (refreshing && reversed == false) {
    return "-";
  } else {
    return ref.watch(efReceiveAmountProvider)?.toString() ?? "";
  }
});

final efReversedProvider = StateProvider<bool>((ref) => false);

final efCurrencyPairProvider = ChangeNotifierProvider<ActivePair>(
  (ref) => ActivePair(),
);

final efEstimateProvider = StateProvider<Estimate?>((ref) {
  final exchange = ref.watch(efExchangeProvider);
  final provider = ref.watch(efExchangeProviderNameProvider);
  final reversed = ref.watch(efReversedProvider);
  final fixedRate = ref.watch(efRateTypeProvider) == SupportedRateType.fixed;

  final matches = ref
      .watch(efEstimatesListProvider(exchange.name))
      ?.item1
      .value
      ?.where((e) {
    return e.exchangeProvider == provider &&
        e.fixedRate == fixedRate &&
        e.reversed == reversed;
  });

  Estimate? result;

  if (matches != null && matches.isNotEmpty) {
    result = matches.first;
  } else {
    result = null;
  }

  return result;
});

final efCanExchangeProvider = StateProvider<bool>((ref) {
  final Estimate? estimate = ref.watch(efEstimateProvider);
  final refreshing = ref.watch(efRefreshingProvider);

  return !refreshing && estimate != null;
});

final efRefreshingProvider = StateProvider<bool>((ref) => false);