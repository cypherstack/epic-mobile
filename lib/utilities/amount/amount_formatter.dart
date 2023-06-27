import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/amount/amount_unit.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pAmountUnit = Provider.family<AmountUnit, Coin>(
  (ref, coin) => ref.watch(
    prefsChangeNotifierProvider.select(
      (value) => value.amountUnit(coin),
    ),
  ),
);
final pMaxDecimals = Provider.family<int, Coin>(
  (ref, coin) => ref.watch(
    prefsChangeNotifierProvider.select(
      (value) => value.maxDecimals(coin),
    ),
  ),
);

final pAmountFormatter = Provider.family<AmountFormatter, Coin>((ref, coin) {
  return AmountFormatter(
    unit: ref.watch(pAmountUnit(coin)),
    locale: ref.watch(
      localeServiceChangeNotifierProvider.select((value) => value.locale),
    ),
    coin: coin,
    maxDecimals: ref.watch(pMaxDecimals(coin)),
  );
});

class AmountFormatter {
  final AmountUnit unit;
  final String locale;
  final Coin coin;
  final int maxDecimals;

  AmountFormatter({
    required this.unit,
    required this.locale,
    required this.coin,
    required this.maxDecimals,
  });

  String format(
    Amount amount, {
    String? overrideUnit,
    dynamic? ethContract,
    bool withUnitName = true,
    bool indicatePrecisionLoss = true,
  }) {
    return unit.displayAmount(
      amount: amount,
      locale: locale,
      coin: coin,
      maxDecimalPlaces: maxDecimals,
      withUnitName: withUnitName,
      indicatePrecisionLoss: indicatePrecisionLoss,
      overrideUnit: overrideUnit,
      tokenContract: ethContract,
    );
  }

  Amount? tryParse(
    String string, {
    dynamic? ethContract,
  }) {
    return unit.tryParse(string, locale: locale, coin: coin);
  }
}
