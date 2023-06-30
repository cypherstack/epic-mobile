/*
 * This file is part of Stack Wallet.
 *
 * Copyright (c) 2023 Cypher Stack
 * All Rights Reserved.
 * The code is distributed under GPLv3 license, see LICENSE file for details.
 * Generated by Cypher Stack on 2023-05-26
 *
 */

import 'dart:async';

import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/exchange_view/exchange_form.dart';
import 'package:epicpay/pages/exchange_view/trade_details_view.dart';
import 'package:epicpay/providers/global/wallet_provider.dart';
import 'package:epicpay/services/swap/trade_sent_from_stack_service.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/text_styles.dart';
// import 'package:stackwallet/models/isar/models/blockchain_data/transaction.dart';
// import 'package:stackwallet/pages/exchange_view/exchange_form.dart';
// import 'package:stackwallet/pages/exchange_view/trade_details_view.dart';
// import 'package:stackwallet/providers/global/trades_service_provider.dart';
// import 'package:stackwallet/providers/providers.dart';
// import 'package:stackwallet/services/exchange/exchange_data_loading_service.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:epicpay/widgets/custom_loading_overlay.dart';
import 'package:epicpay/widgets/trade_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class ExchangeView extends ConsumerStatefulWidget {
  const ExchangeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ExchangeView> createState() => _ExchangeViewState();
}

class _ExchangeViewState extends ConsumerState<ExchangeView> {
  bool _initialCachePopulationUnderway = false;

  @override
  void initState() {
    // if (!ref.read(prefsChangeNotifierProvider).externalCalls) {
    //   if (ExchangeDataLoadingService.currentCacheVersion <
    //       ExchangeDataLoadingService.cacheVersion) {
    //     _initialCachePopulationUnderway = true;
    //     ExchangeDataLoadingService.instance.onLoadingComplete = () {
    //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //         await ExchangeDataLoadingService.instance.setCurrenciesIfEmpty(
    //           ref.read(efCurrencyPairProvider),
    //           ref.read(efRateTypeProvider),
    //         );
    //         setState(() {
    //           _initialCachePopulationUnderway = false;
    //         });
    //       });
    //     };
    //   }
    //   ExchangeDataLoadingService.instance.loadAll();
    // } else if (ExchangeDataLoadingService.instance.isLoading &&
    //     ExchangeDataLoadingService.currentCacheVersion <
    //         ExchangeDataLoadingService.cacheVersion) {
    //   _initialCachePopulationUnderway = true;
    //   ExchangeDataLoadingService.instance.onLoadingComplete = () {
    //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //       await ExchangeDataLoadingService.instance.setCurrenciesIfEmpty(
    //         ref.read(efCurrencyPairProvider),
    //         ref.read(efRateTypeProvider),
    //       );
    //       setState(() {
    //         _initialCachePopulationUnderway = false;
    //       });
    //     });
    //   };
    // }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");

    return ConditionalParent(
      condition: _initialCachePopulationUnderway,
      builder: (child) {
        return Stack(
          children: [
            child,
            Material(
              color: Theme.of(context)
                  .extension<StackColors>()!
                  .overlay
                  .withOpacity(0.6),
              child: const CustomLoadingOverlay(
                message: "Updating exchange data",
                subMessage: "This could take a few minutes",
                eventBus: null,
              ),
            )
          ],
        );
      },
      child: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: ExchangeForm(
                      walletId: ref.watch(walletProvider)?.walletId,
                      coin: ref.watch(walletProvider)?.coin,
                    ),
                  ),
                ),
              )
            ];
          },
          body: StreamBuilder(
            stream: ref.watch(pIsarDB).isar.trades.watchLazy(),
            builder: (buildContext, snapshot) {
              final internalTradeIds = ref
                  .watch(pIsarDB)
                  .isar
                  .trades
                  .where()
                  .sortByTimestampUTCDesc()
                  .idProperty()
                  .findAllSync();
              final hasHistory = internalTradeIds.isNotEmpty;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        buildContext,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "TRADES",
                              style: STextStyles.overLineBold(context),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (hasHistory)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return StreamBuilder<Trade?>(
                              stream: ref
                                  .watch(pIsarDB)
                                  .isar
                                  .trades
                                  .watchObject(internalTradeIds[index]),
                              builder: (
                                context,
                                AsyncSnapshot<Trade?> snapshot,
                              ) {
                                final trade = snapshot.data ??
                                    ref
                                        .read(pIsarDB)
                                        .isar
                                        .trades
                                        .where()
                                        .idEqualTo(internalTradeIds[index])
                                        .findFirstSync()!;

                                return ConditionalParent(
                                  condition: index > 0,
                                  builder: (child) => Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: child,
                                  ),
                                  child: TradeCard(
                                    key: Key(
                                      "tradeCard_${trade.tradeId + trade.updatedAt.toString()}",
                                    ),
                                    trade: trade,
                                    onTap: () async {
                                      final String? slateId = ref
                                          .read(
                                              tradeSentFromStackLookupProvider)
                                          .getTxidForTradeId(trade.tradeId);

                                      final List<String>? walletIds = ref
                                          .read(
                                              tradeSentFromStackLookupProvider)
                                          .getWalletIdsForTradeId(
                                              trade.tradeId);

                                      if (slateId != null &&
                                          walletIds != null &&
                                          walletIds.isNotEmpty) {
                                        final manager =
                                            ref.read(walletProvider)!;

                                        final tx =
                                            (await manager.transactionData)
                                                .findTransactionWithSlateId(
                                                    slateId);

                                        if (mounted) {
                                          unawaited(
                                            Navigator.of(context).pushNamed(
                                              TradeDetailsView.routeName,
                                              arguments: (
                                                tradeId: trade.tradeId,
                                                transactionIfSentFromStack: tx,
                                                walletId: walletIds.first,
                                                walletName: manager.walletName,
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        unawaited(
                                          Navigator.of(context).pushNamed(
                                            TradeDetailsView.routeName,
                                            arguments: (
                                              tradeId: trade.tradeId,
                                              transactionIfSentFromStack: null,
                                              walletId: walletIds?.first,
                                              walletName: null,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          childCount: internalTradeIds.length,
                        ),
                      ),
                    if (!hasHistory)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .extension<StackColors>()!
                                  .popupBG,
                              borderRadius: BorderRadius.circular(
                                Constants.size.circularBorderRadius,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                "Trades will appear here",
                                textAlign: TextAlign.center,
                                style: STextStyles.itemSubtitle(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
