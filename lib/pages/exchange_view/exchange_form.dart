import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/incomplete_exchange.dart';
import 'package:epicpay/models/exchange/range.dart';
import 'package:epicpay/models/isar/models/exchange/currency.dart';
import 'package:epicpay/models/isar/models/exchange/pair.dart';
import 'package:epicpay/pages/exchange_view/exchange_currency_selection_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_1_view.dart';
import 'package:epicpay/pages/exchange_view/sub_widgets/exchange_provider_options.dart';
import 'package:epicpay/providers/exchange/exchange_form_state_provider.dart';
import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/services/swap/exchange_response.dart';
import 'package:epicpay/services/swap/swap_data_service.dart';
import 'package:epicpay/utilities/amount/amount_formatter.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/custom_loading_overlay.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/ep_dialog.dart';
import 'package:epicpay/widgets/exchange_textfields.dart';
import 'package:epicpay/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

final exchangeSendFromWalletIdStateProvider =
    StateProvider<Tuple2<String, Coin>?>((ref) => null);

class ExchangeForm extends ConsumerStatefulWidget {
  const ExchangeForm({
    Key? key,
    this.walletId,
    this.coin,
  }) : super(key: key);

  final String? walletId;
  final Coin? coin;
  // final dynamic? contract;

  @override
  ConsumerState<ExchangeForm> createState() => _ExchangeFormState();
}

class _ExchangeFormState extends ConsumerState<ExchangeForm> {
  late final String? walletId;
  late final Coin? coin;
  late final bool walletInitiated;

  final exchanges = [
    // MajesticBankExchange.instance,
    ChangeNowExchange.instance,
    // TrocadorExchange.instance,
  ];

  late final TextEditingController _sendController;
  late final TextEditingController _receiveController;
  final FocusNode _sendFocusNode = FocusNode();
  final FocusNode _receiveFocusNode = FocusNode();

  bool _swapLock = false;

  // todo: check and adjust this value?
  static const _valueCheckInterval = Duration(milliseconds: 1500);

  // dummy currency to use network and ticker to look up actual currency
  final dummyEpic = Currency(
    exchangeName: ChangeNowExchange.exchangeName,
    ticker: "epic",
    name: "EpicCash",
    image: "",
    hasExternalId: false,
    isFiat: false,
    network: "epic",
    buy: true,
    sell: true,
    rateType: SupportedRateType.estimated,
  );
  final dummyBTC = Currency(
    exchangeName: ChangeNowExchange.exchangeName,
    ticker: "btc",
    name: "Bitcoin",
    image: "",
    hasExternalId: false,
    isFiat: false,
    network: "btc",
    buy: true,
    sell: true,
    rateType: SupportedRateType.both,
  );

  Future<T> showUpdatingExchangeRate<T>({
    required Future<T> whileFuture,
  }) async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: Theme.of(context)
                .extension<StackColors>()!
                .overlay
                .withOpacity(0.6),
            child: const CustomLoadingOverlay(
              message: "Updating exchange rate",
              eventBus: null,
            ),
          ),
        ),
      ),
    );

    final result = await whileFuture;

    if (mounted) {
      Navigator.of(context).pop();
    }

    return result;
  }

  Timer? _sendFieldOnChangedTimer;
  void sendFieldOnChanged(String value) {
    if (_sendFocusNode.hasFocus) {
      _sendFieldOnChangedTimer?.cancel();

      _sendFieldOnChangedTimer = Timer(_valueCheckInterval, () async {
        final newFromAmount =
            ref.read(pAmountFormatter(Coin.epicCash)).tryParse(value);

        ref.read(efSendAmountProvider.notifier).state = newFromAmount?.decimal;
        if (!_swapLock && !ref.read(efReversedProvider)) {
          unawaited(update());
        }
      });
    }
  }

  Timer? _receiveFieldOnChangedTimer;
  void receiveFieldOnChanged(String value) async {
    _receiveFieldOnChangedTimer?.cancel();

    _receiveFieldOnChangedTimer = Timer(_valueCheckInterval, () async {
      final newToAmount =
          ref.read(pAmountFormatter(Coin.epicCash)).tryParse(value);

      ref.read(efReceiveAmountProvider.notifier).state = newToAmount?.decimal;
      if (!_swapLock && ref.read(efReversedProvider)) {
        unawaited(update());
      }
    });
  }

  void selectSendCurrency() async {
    final type = ref.read(efRateTypeProvider);
    final fromTicker = ref.read(efCurrencyPairProvider).send?.ticker ?? "";

    if (walletInitiated) {
      // if (widget.contract != null &&
      //     fromTicker.toLowerCase() == widget.contract!.symbol.toLowerCase()) {
      //   return;
      // }

      if (fromTicker.toLowerCase() == coin!.ticker.toLowerCase()) {
        // do not allow changing away from wallet coin
        return;
      }
    }

    final selectedCurrency = await _showCurrencySelectionSheet(
      willChange: ref.read(efCurrencyPairProvider).send?.ticker,
      willChangeIsSend: true,
      paired: ref.read(efCurrencyPairProvider).receive?.ticker,
      isFixedRate: type == SupportedRateType.fixed,
    );

    if (selectedCurrency != null) {
      await showUpdatingExchangeRate(
        whileFuture: ref
            .read(pSwapDataService)
            .getAggregateCurrency(
              selectedCurrency,
              type,
              null,
            )
            .then(
              (aggregateSelected) => ref.read(efCurrencyPairProvider).setSend(
                    aggregateSelected,
                    notifyListeners: true,
                  ),
            ),
      );
    }
  }

  void selectReceiveCurrency() async {
    final type = ref.read(efRateTypeProvider);
    final toTicker = ref.read(efCurrencyPairProvider).receive?.ticker ?? "";
    if (walletInitiated &&
        toTicker.toLowerCase() == coin!.ticker.toLowerCase()) {
      // do not allow changing away from wallet coin
      return;
    }

    final selectedCurrency = await _showCurrencySelectionSheet(
      willChange: ref.read(efCurrencyPairProvider).receive?.ticker,
      willChangeIsSend: false,
      paired: ref.read(efCurrencyPairProvider).send?.ticker,
      isFixedRate: ref.read(efRateTypeProvider) == SupportedRateType.fixed,
    );

    if (selectedCurrency != null) {
      await showUpdatingExchangeRate(
        whileFuture: ref
            .read(pSwapDataService)
            .getAggregateCurrency(
              selectedCurrency,
              type,
              null,
            )
            .then(
          (aggregateSelected) {
            ref.read(efCurrencyPairProvider).setReceive(
                  aggregateSelected,
                  notifyListeners: true,
                );
          },
        ),
      );
    }
  }

  Future<void> _swap() async {
    _swapLock = true;
    _sendFocusNode.unfocus();
    _receiveFocusNode.unfocus();

    final temp = ref.read(efCurrencyPairProvider).send;
    ref.read(efCurrencyPairProvider).setSend(
          ref.read(efCurrencyPairProvider).receive,
          notifyListeners: true,
        );
    ref.read(efCurrencyPairProvider).setReceive(
          temp,
          notifyListeners: true,
        );

    // final reversed = ref.read(efReversedProvider);

    final amount = ref.read(efSendAmountProvider);
    ref.read(efSendAmountProvider.notifier).state =
        ref.read(efReceiveAmountProvider);

    ref.read(efReceiveAmountProvider.notifier).state = amount;

    unawaited(update());

    _swapLock = false;
  }

  Future<Currency?> _showCurrencySelectionSheet({
    required String? willChange,
    required String? paired,
    required bool isFixedRate,
    required bool willChangeIsSend,
  }) async {
    _sendFocusNode.unfocus();
    _receiveFocusNode.unfocus();

    final result = await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (_) => ExchangeCurrencySelectionView(
          willChangeTicker: willChange,
          pairedTicker: paired,
          isFixedRate: isFixedRate,
          willChangeIsSend: willChangeIsSend,
        ),
      ),
    );

    if (mounted && result is Currency) {
      return result;
    } else {
      return null;
    }
  }

  // NOT USED IN EPIC PAY YET
  // void onRateTypeChanged(SupportedRateType newType) {
  //   _receiveFocusNode.unfocus();
  //   _sendFocusNode.unfocus();
  //
  //   ref.read(efRateTypeProvider.notifier).state = newType;
  //   update();
  // }

  void onExchangePressed() async {
    final rateType = ref.read(efRateTypeProvider);
    final from = ref.read(efCurrencyPairProvider).send;
    final to = ref.read(efCurrencyPairProvider).receive;
    final fromTicker = from?.ticker ?? "";
    final toTicker = to?.ticker ?? "";
    final estimate = ref.read(efEstimateProvider)!;
    final sendAmount = ref.read(efSendAmountProvider)!;

    String rate;

    final amountToSend = estimate.reversed ? estimate.fromAmount : sendAmount;
    final amountToReceive = estimate.reversed
        ? ref.read(efReceiveAmountProvider)!
        : estimate.toAmount;

    switch (rateType) {
      case SupportedRateType.estimated:
        rate =
            "1 ${fromTicker.toUpperCase()} ~${(amountToReceive / sendAmount).toDecimal(scaleOnInfinitePrecision: 8).toStringAsFixed(8)} ${toTicker.toUpperCase()}";
        break;
      case SupportedRateType.fixed:
        bool? shouldCancel;

        if (estimate.warningMessage != null &&
            estimate.warningMessage!.isNotEmpty) {
          shouldCancel = await showDialog<bool?>(
            context: context,
            barrierDismissible: true,
            builder: (_) {
              return EPDialog(
                title: "Failed to update trade estimate",
                info:
                    "${estimate.warningMessage!}\n\nDo you want to attempt trade anyways?",
                cancelButtonTitle: "Cancel",
                onCancelPressed: () {
                  // notify return to cancel
                  Navigator.of(context).pop(true);
                },
                confirmButtonTitle: "Attempt",
                onConfirmPressed: () {
                  // continue and try to attempt trade
                  Navigator.of(context).pop(false);
                },
              );
            },
          );
        }

        if (shouldCancel is bool && shouldCancel) {
          return;
        }
        rate =
            "1 ${fromTicker.toUpperCase()} ~${(amountToReceive / amountToSend).toDecimal(
                  scaleOnInfinitePrecision: 12,
                ).toStringAsFixed(8)} ${toTicker.toUpperCase()}";
        break;

      case SupportedRateType.both:
        throw Exception(
          "SupportedRateType.both not supported when making an exchange!",
        );
    }

    final model = IncompleteExchangeModel(
      from: from!.getForExchangeName(ChangeNowExchange.exchangeName)!,
      to: to!.getForExchangeName(ChangeNowExchange.exchangeName)!,
      rateInfo: rate,
      sendAmount: amountToSend,
      receiveAmount: amountToReceive,
      rateType: rateType,
      estimate: estimate,
      reversed: estimate.reversed,
      walletInitiated: walletInitiated,
    );

    if (mounted) {
      // if (walletInitiated) {
      ref.read(exchangeSendFromWalletIdStateProvider.state).state =
          Tuple2(walletId!, coin!);
      //
      //   unawaited(
      //     Navigator.of(context).pushNamed(
      //       Step2View.routeName,
      //       arguments: model,
      //     ),
      //   );
      // } else {
      //   ref.read(exchangeSendFromWalletIdStateProvider.state).state = null;

      unawaited(
        Navigator.of(context).pushNamed(
          Step1View.routeName,
          arguments: model,
        ),
      );
    }
    // }
  }

  bool isWalletCoin(Coin? coin, bool isSend) {
    if (coin == null) {
      return false;
    }

    String? ticker = isSend
        ? ref.read(efCurrencyPairProvider).send?.ticker
        : ref.read(efCurrencyPairProvider).receive?.ticker;

    if (ticker == null) {
      return false;
    }

    return coin.ticker.toUpperCase() == ticker.toUpperCase();
  }

  Future<void> update() async {
    final uuid = const Uuid().v1();
    _latestUuid = uuid;
    _addUpdate(uuid);
    for (final exchange in exchanges) {
      ref.read(efEstimatesListProvider(exchange.name).notifier).state = null;
    }

    final reversed = ref.read(efReversedProvider);
    final amount = reversed
        ? ref.read(efReceiveAmountProvider)
        : ref.read(efSendAmountProvider);

    final pair = ref.read(efCurrencyPairProvider);
    if (amount == null ||
        amount <= Decimal.zero ||
        pair.send == null ||
        pair.receive == null) {
      _removeUpdate(uuid);
      return;
    }
    final rateType = ref.read(efRateTypeProvider);
    final Map<String, Tuple2<ExchangeResponse<List<Estimate>>, Range?>>
        results = {};

    for (final exchange in exchanges) {
      final sendCurrency = pair.send?.forExchange(exchange.name);
      final receiveCurrency = pair.receive?.forExchange(exchange.name);

      if (sendCurrency != null && receiveCurrency != null) {
        final rangeResponse = await exchange.getRange(
          reversed ? receiveCurrency : sendCurrency,
          reversed ? sendCurrency : receiveCurrency,
          rateType == SupportedRateType.fixed,
        );

        final estimateResponse = await exchange.getEstimate(
            sendCurrency,
            receiveCurrency,
            amount,
            rateType == SupportedRateType.fixed,
            reversed);

        if (estimateResponse.exception != null) {
          Logging.instance.log(
            "${estimateResponse.exception}::::::$rangeResponse",
            level: LogLevel.Warning,
          );
        }

        results.addAll(
          {
            exchange.name: Tuple2(
              estimateResponse,
              rangeResponse.value,
            ),
          },
        );
      }
    }

    for (final exchange in exchanges) {
      if (uuid == _latestUuid) {
        ref.read(efEstimatesListProvider(exchange.name).notifier).state =
            results[exchange.name];
      }
    }

    _removeUpdate(uuid);
  }

  String? _latestUuid;
  final Set<String> _uuids = {};

  void _addUpdate(String uuid) {
    _uuids.add(uuid);
    ref.read(efRefreshingProvider.notifier).state = true;
  }

  void _removeUpdate(String uuid) {
    _uuids.remove(uuid);
    if (_uuids.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(efRefreshingProvider.notifier).state = false;
      });
    }
  }

  void updateSend(Estimate? estimate) {
    ref.read(efSendAmountProvider.notifier).state = estimate?.fromAmount;
  }

  void updateReceive(Estimate? estimate) {
    ref.read(efReceiveAmountProvider.notifier).state = estimate?.toAmount;
  }

  Text fromWarningMessage(Range? range) {
    String string = "";
    Color color = Theme.of(context).extension<StackColors>()!.textGold;

    final min = range?.min;
    final max = range?.max;
    final amount = ref.read(efSendAmountProvider.state).state;
    final ticker = range?.fromCurrency.toUpperCase();

    if (amount == null) {
      if (min != null) {
        string = "Minimum amount is $min $ticker";
      }
    } else {
      if (min != null && amount < min) {
        string = "Minimum amount is $min $ticker";
        color = Theme.of(context).extension<StackColors>()!.snackBarTextError;
      }
      if (max != null && amount > max) {
        string = "Maximum amount is $max $ticker";
        color = Theme.of(context).extension<StackColors>()!.snackBarTextError;
      }
    }

    return Text(
      string,
      style: STextStyles.overLine(context).copyWith(
        color: color,
      ),
    );
  }

  @override
  void initState() {
    _sendController = TextEditingController();
    _receiveController = TextEditingController();

    walletId = widget.walletId;
    coin = widget.coin;
    walletInitiated = walletId != null && coin != null;

    _sendFocusNode.addListener(() {
      if (_sendFocusNode.hasFocus) {
        final reversed = ref.read(efReversedProvider);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(efReversedProvider.notifier).state = false;
          if (reversed == true) {
            update();
          }
        });
      }
    });
    _receiveFocusNode.addListener(() {
      if (_receiveFocusNode.hasFocus &&
          ref.read(efExchangeProvider).name != ChangeNowExchange.exchangeName) {
        final reversed = ref.read(efReversedProvider);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(efReversedProvider.notifier).state = true;
          if (reversed != true) {
            update();
          }
        });
      }
    });

    // if (walletInitiated) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(efSendAmountProvider.notifier).state = null;
      ref.read(efReceiveAmountProvider.notifier).state = null;
      ref.read(efReversedProvider.notifier).state = false;
      ref.read(efRefreshingProvider.notifier).state = false;
      ref.read(efCurrencyPairProvider).setSend(null, notifyListeners: true);
      ref.read(efCurrencyPairProvider).setReceive(null, notifyListeners: true);
      ref
          .read(pSwapDataService)
          .getAggregateCurrency(
            dummyBTC,
            SupportedRateType.estimated,
            null,
          )
          .then((value) {
        if (value != null) {
          ref.read(efCurrencyPairProvider).setSend(
                value,
                notifyListeners: true,
              );
        }
      });

      ref
          .read(pSwapDataService)
          .getAggregateCurrency(
            dummyEpic,
            SupportedRateType.estimated,
            null,
          )
          .then((value) {
        if (value != null) {
          ref.read(efCurrencyPairProvider).setReceive(
                value,
                notifyListeners: true,
              );
        }
      });
    });
    // } else {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _sendController.text = ref.read(efSendAmountStringProvider);
    //   _receiveController.text = ref.read(efReceiveAmountStringProvider);
    // });
    // }
    super.initState();
  }

  @override
  void dispose() {
    _receiveController.dispose();
    _sendController.dispose();
    _receiveFocusNode.dispose();
    _sendFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    final rateType = ref.watch(efRateTypeProvider);

    final isEstimated = rateType == SupportedRateType.estimated;

    ref.listen(efReceiveAmountStringProvider, (previous, String next) {
      if (!_receiveFocusNode.hasFocus) {
        _receiveController.text = isEstimated && next.isEmpty ? "-" : next;
        if (_swapLock) {
          _sendController.text = ref.read(efSendAmountStringProvider);
        }
      }
    });
    ref.listen(efSendAmountStringProvider, (previous, String next) {
      if (!_sendFocusNode.hasFocus) {
        _sendController.text = next;
        if (_swapLock) {
          _receiveController.text =
              isEstimated && ref.read(efReceiveAmountStringProvider).isEmpty
                  ? "-"
                  : ref.read(efReceiveAmountStringProvider);
        }
      }
    });

    ref.listen(efEstimateProvider.notifier, (previous, next) {
      final estimate = next.state;
      if (ref.read(efReversedProvider)) {
        updateSend(estimate);
      } else {
        updateReceive(estimate);
      }
    });

    ref.listen(efCurrencyPairProvider, (previous, next) {
      if (!_swapLock) {
        update();
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "YOU WILL SEND",
          style: STextStyles.overLineBold(context).copyWith(
            color: Theme.of(context).extension<StackColors>()!.textMedium,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ExchangeTextField(
          key: Key("exchangeTextFieldKeyFor_"
              "${Theme.of(context).extension<StackColors>()!.themeType.name}"
              "${ref.watch(efCurrencyPairProvider.select((value) => value.send?.ticker))}"),
          controller: _sendController,
          focusNode: _sendFocusNode,
          textStyle: STextStyles.w400_16(context).copyWith(
            color: Theme.of(context).extension<StackColors>()!.textMedium,
          ),
          buttonColor:
              Theme.of(context).extension<StackColors>()!.buttonBackSecondary,
          borderRadius: Constants.size.circularBorderRadius,
          background:
              Theme.of(context).extension<StackColors>()!.textFieldDefaultBG,
          onTap: () {
            if (_sendController.text == "-") {
              _sendController.text = "";
            }
          },
          onChanged: sendFieldOnChanged,
          onButtonTap: selectSendCurrency,
          isWalletCoin: isWalletCoin(coin, true),
          currency:
              ref.watch(efCurrencyPairProvider.select((value) => value.send)),
        ),
        const SizedBox(
          height: 1,
        ),
        fromWarningMessage(
          ref
              .watch(efEstimatesListProvider(ChangeNowExchange.exchangeName)
                  .notifier)
              .state
              ?.item2,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "YOU WILL RECEIVE",
              style: STextStyles.overLineBold(context).copyWith(
                color: Theme.of(context).extension<StackColors>()!.textMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Semantics(
                label: "Swap Button. Reverse The Exchange Currencies.",
                excludeSemantics: true,
                child: RoundedContainer(
                  padding: const EdgeInsets.all(2),
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .buttonBackSecondary,
                  radiusMultiplier: 0.75,
                  child: GestureDetector(
                    onTap: () async {
                      await _swap();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        Assets.svg.swap,
                        width: 20,
                        height: 20,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ExchangeTextField(
          key: Key(
              "exchangeTextFieldKeyFor1_${Theme.of(context).extension<StackColors>()!.themeType.name}"),
          focusNode: _receiveFocusNode,
          controller: _receiveController,
          textStyle: STextStyles.w400_16(context).copyWith(
            color: Theme.of(context).extension<StackColors>()!.textMedium,
          ),
          buttonColor:
              Theme.of(context).extension<StackColors>()!.buttonBackSecondary,
          borderRadius: Constants.size.circularBorderRadius,
          background:
              Theme.of(context).extension<StackColors>()!.textFieldDefaultBG,
          onTap: rateType == SupportedRateType.estimated &&
                  ref.watch(efExchangeProvider).name ==
                      ChangeNowExchange.exchangeName
              ? null
              : () {
                  if (_sendController.text == "-") {
                    _sendController.text = "";
                  }
                },
          onChanged: receiveFieldOnChanged,
          onButtonTap: selectReceiveCurrency,
          isWalletCoin: isWalletCoin(coin, true),
          currency: ref
              .watch(efCurrencyPairProvider.select((value) => value.receive)),
          readOnly: rateType == SupportedRateType.estimated &&
              ref.watch(efExchangeProvider).name ==
                  ChangeNowExchange.exchangeName,
        ),
        const SizedBox(
          height: 12,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ref.watch(efSendAmountProvider) == null &&
                  ref.watch(efReceiveAmountProvider) == null
              ? const SizedBox(
                  height: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ExchangeProviderOptions(
                    fixedRate: rateType == SupportedRateType.fixed,
                    reversed: ref.watch(efReversedProvider),
                  ),
                ),
        ),
        const SizedBox(
          height: 12,
        ),
        PrimaryButton(
          enabled: ref.watch(efCanExchangeProvider),
          onPressed: onExchangePressed,
          label: "Swap",
        )
      ],
    );
  }
}
