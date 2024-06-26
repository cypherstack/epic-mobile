import 'package:decimal/decimal.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/exchange_view/trade_details_view.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TradeCard extends ConsumerWidget {
  const TradeCard({
    Key? key,
    required this.trade,
    required this.onTap,
  }) : super(key: key);

  final Trade trade;
  final VoidCallback onTap;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
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
                          "${trade.fromCurrency.toUpperCase()} → ${trade.toCurrency.toUpperCase()}",
                          style: STextStyles.bodySmallBold(context),
                        ),
                        Text(
                          "${Decimal.tryParse(trade.fromAmount) ?? "..."} ${trade.fromCurrency.toUpperCase()}",
                          style: STextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trade.exchangeName,
                          style: STextStyles.bodySmall(context),
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
