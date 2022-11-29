import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicmobile/providers/providers.dart';
import 'package:epicmobile/providers/wallet/public_private_balance_state_provider.dart';
import 'package:epicmobile/services/coins/firo/firo_wallet.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';
import 'package:epicmobile/utilities/text_styles.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/animated_text.dart';

class FiroBalanceSelectionSheet extends ConsumerStatefulWidget {
  const FiroBalanceSelectionSheet({
    Key? key,
    required this.walletId,
  }) : super(key: key);

  final String walletId;

  @override
  ConsumerState<FiroBalanceSelectionSheet> createState() =>
      _FiroBalanceSelectionSheetState();
}

class _FiroBalanceSelectionSheetState
    extends ConsumerState<FiroBalanceSelectionSheet> {
  late final String walletId;

  final stringsToLoopThrough = [
    "Loading balance",
    "Loading balance.",
    "Loading balance..",
    "Loading balance...",
  ];

  @override
  void initState() {
    walletId = widget.walletId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    final manager = ref.watch(walletsChangeNotifierProvider
        .select((value) => value.getManager(walletId)));
    final firoWallet = manager.wallet as FiroWallet;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<StackColors>()!.popupBG,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 10,
          bottom: 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .extension<StackColors>()!
                      .textFieldDefaultBG,
                  borderRadius: BorderRadius.circular(
                    Constants.size.circularBorderRadius,
                  ),
                ),
                width: 60,
                height: 4,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select balance",
                  style: STextStyles.pageTitleH2(context),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    final state =
                        ref.read(publicPrivateBalanceStateProvider.state).state;
                    if (state != "Private") {
                      ref.read(publicPrivateBalanceStateProvider.state).state =
                          "Private";
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Radio(
                                activeColor: Theme.of(context)
                                    .extension<StackColors>()!
                                    .radioButtonIconEnabled,
                                value: "Private",
                                groupValue: ref
                                    .watch(
                                        publicPrivateBalanceStateProvider.state)
                                    .state,
                                onChanged: (x) {
                                  ref
                                      .read(publicPrivateBalanceStateProvider
                                          .state)
                                      .state = "Private";

                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              Text(
                                "Private balance",
                                style: STextStyles.titleBold12(context),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              FutureBuilder(
                                future: firoWallet.availablePrivateBalance(),
                                builder:
                                    (context, AsyncSnapshot<Decimal> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data!} ${manager.coin.ticker}",
                                      style: STextStyles.itemSubtitle(context),
                                      textAlign: TextAlign.left,
                                    );
                                  } else {
                                    return AnimatedText(
                                      stringsToLoopThrough:
                                          stringsToLoopThrough,
                                      style: STextStyles.itemSubtitle(context),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                          //   ],
                          // ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    final state =
                        ref.read(publicPrivateBalanceStateProvider.state).state;
                    if (state != "Public") {
                      ref.read(publicPrivateBalanceStateProvider.state).state =
                          "Public";
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Radio(
                                activeColor: Theme.of(context)
                                    .extension<StackColors>()!
                                    .radioButtonIconEnabled,
                                value: "Public",
                                groupValue: ref
                                    .watch(
                                        publicPrivateBalanceStateProvider.state)
                                    .state,
                                onChanged: (x) {
                                  ref
                                      .read(publicPrivateBalanceStateProvider
                                          .state)
                                      .state = "Public";
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              Text(
                                "Public balance",
                                style: STextStyles.titleBold12(context),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              FutureBuilder(
                                future: firoWallet.availablePublicBalance(),
                                builder:
                                    (context, AsyncSnapshot<Decimal> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data!} ${manager.coin.ticker}",
                                      style: STextStyles.itemSubtitle(context),
                                      textAlign: TextAlign.left,
                                    );
                                  } else {
                                    return AnimatedText(
                                      stringsToLoopThrough:
                                          stringsToLoopThrough,
                                      style: STextStyles.itemSubtitle(context),
                                    );
                                  }
                                },
                              )
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
