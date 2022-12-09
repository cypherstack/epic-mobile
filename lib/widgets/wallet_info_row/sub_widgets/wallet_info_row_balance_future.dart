import 'package:decimal/decimal.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:epicpay/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletInfoRowBalanceFuture extends ConsumerWidget {
  const WalletInfoRowBalanceFuture({Key? key, required this.walletId})
      : super(key: key);

  final String walletId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(walletProvider)!;

    final locale = ref.watch(
      localeServiceChangeNotifierProvider.select(
        (value) => value.locale,
      ),
    );

    return FutureBuilder(
      future: manager.totalBalance,
      builder: (builderContext, AsyncSnapshot<Decimal> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Text(
            "${Format.localizedStringAsFixed(
              value: snapshot.data!,
              locale: locale,
              decimalPlaces: 8,
            )} ${manager.coin.ticker}",
            style: Util.isDesktop
                ? STextStyles.desktopTextExtraSmall(context).copyWith(
                    color: Theme.of(context)
                        .extension<StackColors>()!
                        .textSubtitle1,
                  )
                : STextStyles.itemSubtitle(context),
          );
        } else {
          return AnimatedText(
            stringsToLoopThrough: const [
              "Loading balance",
              "Loading balance.",
              "Loading balance..",
              "Loading balance..."
            ],
            style: Util.isDesktop
                ? STextStyles.desktopTextExtraSmall(context).copyWith(
                    color: Theme.of(context)
                        .extension<StackColors>()!
                        .textSubtitle1,
                  )
                : STextStyles.itemSubtitle(context),
          );
        }
      },
    );
  }
}
