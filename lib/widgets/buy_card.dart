import 'package:decimal/decimal.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/exchange_view/trade_details_view.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyCard extends ConsumerWidget {
  const BuyCard({
    Key? key,
    required this.trade,
  }) : super(key: key);

  final Trade trade;

  static const double iconSize = 48;

  String _fetchIconAssetForStatus(String statusString) {
    ChangeNowTransactionStatus? status;
    try {
      if (statusString.toLowerCase().startsWith("waiting")) {
        statusString = "Waiting";
      }
      status = changeNowTransactionStatusFromStringIgnoreCase(statusString);
    } on ArgumentError catch (_) {
      switch (statusString.toLowerCase()) {
        case "funds confirming":
        case "processing payment":
          return Assets.svg.txSwapPending;

        case "completed":
          return Assets.svg.txSwap;

        default:
          status = ChangeNowTransactionStatus.Failed;
      }
    }

    switch (status) {
      case ChangeNowTransactionStatus.New:
      case ChangeNowTransactionStatus.Waiting:
      case ChangeNowTransactionStatus.Confirming:
      case ChangeNowTransactionStatus.Exchanging:
      case ChangeNowTransactionStatus.Sending:
      case ChangeNowTransactionStatus.Refunded:
      case ChangeNowTransactionStatus.Verifying:
        return Assets.svg.txSwapPending;
      case ChangeNowTransactionStatus.Finished:
        return Assets.svg.txSwap;
      case ChangeNowTransactionStatus.Failed:
        return Assets.svg.txSwapFailed;
    }
  }

  (String, Color) prettyStatus(String statusString, BuildContext context) {
    ChangeNowTransactionStatus? status;
    try {
      if (statusString.toLowerCase().startsWith("waiting")) {
        statusString = "Waiting";
      }
      status = changeNowTransactionStatusFromStringIgnoreCase(statusString);
    } on ArgumentError catch (_) {
      switch (statusString.toLowerCase()) {
        case "funds confirming":
        case "processing payment":
          return (
            "Processing",
            Theme.of(context).extension<StackColors>()!.textGold
          );

        case "completed":
          return (
            "Finished",
            Theme.of(context).extension<StackColors>()!.accentColorGreen
          );

        default:
          status = ChangeNowTransactionStatus.Failed;
      }
    }

    switch (status) {
      case ChangeNowTransactionStatus.New:
      case ChangeNowTransactionStatus.Waiting:
        if (DateTime.now()
                .difference(DateTime.parse(trade.createdAt!))
                .inMinutes >
            45) {
          return (
            "Expired",
            Theme.of(context).extension<StackColors>()!.textDark
          );
        }

        return ("Active", Theme.of(context).extension<StackColors>()!.textGold);
      case ChangeNowTransactionStatus.Confirming:
      case ChangeNowTransactionStatus.Exchanging:
      case ChangeNowTransactionStatus.Sending:
      case ChangeNowTransactionStatus.Verifying:
        return (
          "Processing",
          Theme.of(context).extension<StackColors>()!.textGold
        );
      case ChangeNowTransactionStatus.Finished:
        return (
          "Finished",
          Theme.of(context).extension<StackColors>()!.accentColorGreen
        );
      case ChangeNowTransactionStatus.Failed:
      case ChangeNowTransactionStatus.Refunded:
        return (
          "Failed",
          Theme.of(context).extension<StackColors>()!.accentColorRed
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = prettyStatus(trade.status, context);

    return GestureDetector(
      onTap: info.$1 == "Expired"
          ? null
          : () {
              Navigator.of(context).pushNamed(
                TradeDetailsView.routeName,
                arguments: (
                  tradeId: trade.tradeId,
                  transactionIfSentFromStack: null,
                  walletId: null,
                  walletName: null,
                  isBuy: true,
                ),
              );
            },
      child: RoundedWhiteContainer(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: iconSize,
          child: Row(
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(iconSize),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    _fetchIconAssetForStatus(
                      trade.status,
                    ),
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Decimal.tryParse(trade.fromAmount) ?? "..."} ${trade.fromFullTicker}",
                          style: STextStyles.bodySmall(context),
                        ),
                        Text(
                          "${Decimal.tryParse(trade.toAmount)?.toStringAsFixed(1) ?? "..."} ${trade.toCurrency.toUpperCase()}",
                          style: STextStyles.bodySmallBold(context),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          info.$1,
                          style: STextStyles.bodySmall(context).copyWith(
                            color: info.$2,
                          ),
                        ),
                        Text(
                          Format.extractDateFrom(
                            DateTime.parse(trade.createdAt!)
                                    .millisecondsSinceEpoch ~/
                                1000,
                          ),
                          style: STextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
