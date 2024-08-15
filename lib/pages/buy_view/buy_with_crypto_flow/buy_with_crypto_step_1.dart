import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_2.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';

class BuyWithCryptoStep1 extends ConsumerStatefulWidget {
  const BuyWithCryptoStep1({super.key});

  static const routeName = "/buyWithCryptoStep1";

  @override
  ConsumerState<BuyWithCryptoStep1> createState() => _BuyWithCryptoStep1State();
}

class _BuyWithCryptoStep1State extends ConsumerState<BuyWithCryptoStep1> {
  int? _selectedIndex;

  bool _onNextPressedLock = false;
  void _onNextPressed() async {
    if (_onNextPressedLock) {
      return;
    }
    _onNextPressedLock = true;

    try {
      final option = BuyOption.values[_selectedIndex!];
      const timeout = Duration(seconds: 5);

      final epic = ref
          .read(pIsarDB)
          .isar
          .currencies
          .filter()
          .exchangeNameEqualTo(ChangeNowExchange.exchangeName)
          .tickerEqualTo("epic")
          .and()
          .networkEqualTo("epic")
          .and()
          .nameEqualTo("EpicCash")
          .findFirstSync();

      final resultFuture = ChangeNowExchange.instance
          .getRange(
            option.currency!,
            epic!,
            false,
          )
          .timeout(
            timeout,
            onTimeout: () => ExchangeResponse(
              value: null,
              exception: ExchangeException("Get Range timeout"),
            ),
          );

      final result = await showLoading(
        whileFuture: resultFuture,
        context: context,
        delay: const Duration(seconds: 1),
        timeout: timeout,
      );

      if (mounted) {
        if (result == null) {
          unawaited(
            showDialog<void>(
              context: context,
              builder: (context) => const EPErrorDialog(
                title: "Unknown error",
                info: "showLoading result should never be null",
              ),
            ),
          );
          return;
        }

        if (result.exception != null) {
          unawaited(
            showDialog<void>(
              context: context,
              builder: (context) => EPErrorDialog(
                title: "Buy error",
                info: result.exception!.message,
              ),
            ),
          );
          return;
        }

        if (result.value != null) {
          final max = result.value!.max;
          final min = result.value!.min;

          await Navigator.of(context).pushNamed(
            BuyWithCryptoStep2.routeName,
            arguments: (
              option: option,
              min: min ?? Decimal.zero,
              max: max ??
                  Decimal.parse("999999999999999999999999"), // insane max
            ),
          );
        }
      }
    } finally {
      _onNextPressedLock = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Background(
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          appBar: AppBar(
            leading: AppBarIconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF222227),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.svg.arrowLeft,
                    width: 24,
                    height: 24,
                    color:
                        Theme.of(context).extension<StackColors>()!.textMedium,
                  ),
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            centerTitle: true,
            title: const StepIndicatorRow(
              activeCount: 1,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "I have",
                textAlign: TextAlign.center,
                style: STextStyles.titleH3(context),
              ),
              SizedBox(
                height: height < 600 ? 8 : 24,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final option = BuyOption.values[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (_selectedIndex == index) {
                            return;
                          }

                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: RoundedContainer(
                          padding: const EdgeInsets.all(12),
                          borderColor: _selectedIndex == index
                              ? Theme.of(context)
                                  .extension<StackColors>()!
                                  .stepIndicatorBGCheck
                              : null,
                          color: Theme.of(context)
                              .extension<StackColors>()!
                              .popupBG,
                          child: Row(
                            children: [
                              Image.asset(
                                width: 40,
                                height: 40,
                                option.assetName,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                option.value,
                                style: STextStyles.w400_16(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: BuyOption.values.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: PrimaryButton(
                  label: "NEXT",
                  enabled: _selectedIndex != null,
                  onPressed: _selectedIndex == null ? null : _onNextPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepIndicatorRow extends StatelessWidget {
  const StepIndicatorRow({
    super.key,
    required this.activeCount,
  }) : assert(activeCount >= 0 && activeCount <= 3);

  final int activeCount;

  @override
  Widget build(BuildContext context) {
    final on = Theme.of(context).extension<StackColors>()!.stepIndicatorBGCheck;

    final off =
        Theme.of(context).extension<StackColors>()!.stepIndicatorBGInactive;

    return SizedBox(
      width: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedContainer(
            width: 6,
            height: 6,
            color: activeCount > 0 ? on : off,
          ),
          const SizedBox(
            width: 5,
          ),
          RoundedContainer(
            width: 6,
            height: 6,
            color: activeCount > 1 ? on : off,
          ),
          const SizedBox(
            width: 5,
          ),
          RoundedContainer(
            width: 6,
            height: 6,
            color: activeCount > 2 ? on : off,
          ),
        ],
      ),
    );
  }
}

enum BuyOption {
  btc("Bitcoin / BTC"),
  usdt("USDT"),
  usdc("USDC");

  final String value;
  const BuyOption(this.value);

  String get assetName {
    switch (this) {
      case BuyOption.btc:
        return Assets.png.btc;
      case BuyOption.usdt:
        return Assets.png.usdt;
      case BuyOption.usdc:
        return Assets.png.usdc;
    }
  }

  /// fragile
  String get ticker => value.split(" / ").last;

  int get fractionDigits {
    switch (this) {
      case BuyOption.btc:
        return 8;
      case BuyOption.usdt:
      case BuyOption.usdc:
        return 6;
    }
  }

  Currency? get currency {
    final filter = IsarDB.instance.isar.currencies
        .filter()
        .exchangeNameEqualTo(ChangeNowExchange.exchangeName);

    switch (this) {
      case BuyOption.btc:
        return filter
            .tickerEqualTo("btc")
            .and()
            .networkEqualTo("btc")
            .and()
            .nameEqualTo("Bitcoin")
            .findFirstSync();
      case BuyOption.usdt:
        return filter
            .tickerEqualTo("usdt")
            .and()
            .networkEqualTo("eth")
            .findFirstSync();
      case BuyOption.usdc:
        return filter
            .tickerEqualTo("usdc")
            .and()
            .networkEqualTo("eth")
            .findFirstSync();
    }
  }
}
