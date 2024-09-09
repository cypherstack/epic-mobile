import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/range.dart';
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
import 'package:epicpay/widgets/step_progress_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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
      final option = CryptoBuyOption.values[_selectedIndex!];
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

      final List<Future<dynamic>> futures = [
        ChangeNowExchange.instance
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
            )
      ];

      if (option == CryptoBuyOption.btc) {
        futures.add(
          ChangeNowExchange.instance
              .getEstimate(
                CryptoBuyOption.usdtERC20.currency!,
                CryptoBuyOption.btc.currency!,
                Decimal.fromInt(1000),
                false,
                false,
              )
              .timeout(
                timeout,
                onTimeout: () => ExchangeResponse(
                  value: null,
                  exception: ExchangeException("Get Estimate timeout"),
                ),
              ),
        );
      }

      final results = await showLoading(
        whileFuture: Future.wait(futures),
        context: context,
        delay: const Duration(seconds: 1),
        timeout: timeout,
      );

      if (mounted) {
        if (results == null) {
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

        Decimal? usdtRate;
        if (results.length == 2) {
          final estimateResponse =
              results[1] as ExchangeResponse<List<Estimate>>;
          if (estimateResponse.exception != null) {
            unawaited(
              showDialog<void>(
                context: context,
                builder: (context) => EPErrorDialog(
                  title: "Fetch USDT rate error",
                  info: estimateResponse.exception!.message,
                ),
              ),
            );
            return;
          }

          if (estimateResponse.value == null ||
              estimateResponse.value!.isEmpty) {
            unawaited(
              showDialog<void>(
                context: context,
                builder: (context) => const EPErrorDialog(
                  title: "Fetch USDT rate error",
                  info: "ChangeNOW failed to provide rate",
                ),
              ),
            );
            return;
          }

          usdtRate = (estimateResponse.value!.first.toAmount /
                  estimateResponse.value!.first.fromAmount)
              .toDecimal(
            scaleOnInfinitePrecision: 100,
          );
        } else {
          usdtRate = Decimal.one;
        }

        final rangeResponse = results[0] as ExchangeResponse<Range>;

        if (rangeResponse.exception != null) {
          unawaited(
            showDialog<void>(
              context: context,
              builder: (context) => EPErrorDialog(
                title: "Fetch range error",
                info: rangeResponse.exception!.message,
              ),
            ),
          );
          return;
        }

        if (rangeResponse.value != null) {
          final max = rangeResponse.value!.max ??
              Decimal.parse("999999999999999999999999"); // insane max
          final min = rangeResponse.value!.min ?? Decimal.zero;

          await Navigator.of(context).pushNamed(
            BuyWithCryptoStep2.routeName,
            arguments: (
              option: option,
              usdtRate: usdtRate,
              min: min,
              max: max,
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
            title: const StepProgressDots(
              activeCount: 1,
              totalCount: 3,
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
                    final option = CryptoBuyOption.values[index];

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
                              SizedBox(
                                width: 36,
                                height: 36,
                                child: SvgPicture.asset(
                                  width: 36,
                                  height: 36,
                                  option.assetName,
                                ),
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
                  itemCount: CryptoBuyOption.values.length,
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

enum CryptoBuyOption {
  btc("Bitcoin / BTC"),
  usdtERC20("USDT (ETH)"),
  usdtTRC20("USDT (TRX)"),
  usdtBSC("USDT (BSC)"),
  usdtSOL("USDT (SOL)"),
  usdcERC20("USDC (ETH)"),
  usdcBSC("USDC (BSC)"),
  usdcSOL("USDC (SOL)");

  final String value;
  const CryptoBuyOption(this.value);

  String get assetName {
    switch (this) {
      case CryptoBuyOption.btc:
        return Assets.cn.btc;
      case CryptoBuyOption.usdtBSC:
        return Assets.cn.usdtBSC;
      case CryptoBuyOption.usdtERC20:
        return Assets.cn.usdtERC20;
      case CryptoBuyOption.usdtSOL:
        return Assets.cn.usdtSOL;
      case CryptoBuyOption.usdtTRC20:
        return Assets.cn.usdtTRC20;
      case CryptoBuyOption.usdcBSC:
        return Assets.cn.usdcBSC;
      case CryptoBuyOption.usdcERC20:
        return Assets.cn.usdcERC20;
      case CryptoBuyOption.usdcSOL:
        return Assets.cn.usdcSOL;
    }
  }

  /// fragile
  String get ticker {
    if (value.contains(" / ")) {
      return value.split(" / ").last;
    } else {
      return value;
    }
  }

  int get fractionDigits {
    switch (this) {
      case CryptoBuyOption.btc:
        return 8;
      default:
        return 6;
    }
  }

  Currency? get currency {
    final filter = IsarDB.instance.isar.currencies
        .filter()
        .exchangeNameEqualTo(ChangeNowExchange.exchangeName);

    switch (this) {
      case CryptoBuyOption.btc:
        return filter
            .tickerEqualTo("btc")
            .and()
            .networkEqualTo("btc")
            .and()
            .nameEqualTo("Bitcoin")
            .findFirstSync();
      case CryptoBuyOption.usdtERC20:
        return filter
            .tickerEqualTo("usdt")
            .and()
            .networkEqualTo("eth")
            .findFirstSync();
      case CryptoBuyOption.usdtSOL:
        return filter
            .tickerEqualTo("usdt")
            .and()
            .networkEqualTo("sol")
            .findFirstSync();
      case CryptoBuyOption.usdtBSC:
        return filter
            .tickerEqualTo("usdt")
            .and()
            .networkEqualTo("bsc")
            .findFirstSync();
      case CryptoBuyOption.usdtTRC20:
        return filter
            .tickerEqualTo("usdt")
            .and()
            .networkEqualTo("trx")
            .findFirstSync();
      case CryptoBuyOption.usdcBSC:
        return filter
            .tickerEqualTo("usdc")
            .and()
            .networkEqualTo("bsc")
            .findFirstSync();
      case CryptoBuyOption.usdcERC20:
        return filter
            .tickerEqualTo("usdc")
            .and()
            .networkEqualTo("eth")
            .findFirstSync();
      case CryptoBuyOption.usdcSOL:
        return filter
            .tickerEqualTo("usdc")
            .and()
            .networkEqualTo("sol")
            .findFirstSync();
    }
  }
}
