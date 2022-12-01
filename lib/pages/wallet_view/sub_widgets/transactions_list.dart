import 'dart:async';

import 'package:epicmobile/models/paymint/transactions_model.dart';
import 'package:epicmobile/pages/wallet_view/sub_widgets/no_transactions_found.dart';
import 'package:epicmobile/providers/global/wallets_provider.dart';
import 'package:epicmobile/services/coins/manager.dart';
import 'package:epicmobile/utilities/constants.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/utilities/util.dart';
import 'package:epicmobile/widgets/loading_indicator.dart';
import 'package:epicmobile/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList({
    Key? key,
    required this.walletId,
    required this.managerProvider,
  }) : super(key: key);

  final String walletId;
  final ChangeNotifierProvider<Manager> managerProvider;

  @override
  ConsumerState<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends ConsumerState<TransactionsList> {
  //
  bool _hasLoaded = false;
  Map<String, Transaction> _transactions = {};

  late final ChangeNotifierProvider<Manager> managerProvider;

  void updateTransactions(TransactionData newData) {
    _transactions = {};
    final newTransactions =
        newData.txChunks.expand((element) => element.transactions);
    for (final tx in newTransactions) {
      _transactions[tx.txid] = tx;
    }
  }

  BorderRadius get _borderRadiusFirst {
    return BorderRadius.only(
      topLeft: Radius.circular(
        Constants.size.circularBorderRadius,
      ),
      topRight: Radius.circular(
        Constants.size.circularBorderRadius,
      ),
    );
  }

  BorderRadius get _borderRadiusLast {
    return BorderRadius.only(
      bottomLeft: Radius.circular(
        Constants.size.circularBorderRadius,
      ),
      bottomRight: Radius.circular(
        Constants.size.circularBorderRadius,
      ),
    );
  }

  Widget itemBuilder(
      BuildContext context, Transaction tx, BorderRadius? radius) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<StackColors>()!.popupBG,
        borderRadius: radius,
      ),
      child: TransactionCard(
        // this may mess with combined firo transactions
        key: Key(tx.toString()), //
        transaction: tx,
        walletId: widget.walletId,
      ),
    );
  }

  @override
  void initState() {
    managerProvider = widget.managerProvider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final managerProvider = ref
    //     .watch(walletsChangeNotifierProvider)
    //     .getManagerProvider(widget.walletId);

    return FutureBuilder(
      future:
          ref.watch(managerProvider.select((value) => value.transactionData)),
      builder: (fbContext, AsyncSnapshot<TransactionData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          updateTransactions(snapshot.data!);
          _hasLoaded = true;
        }
        if (!_hasLoaded) {
          return Column(
            children: const [
              Spacer(),
              Center(
                child: LoadingIndicator(
                  height: 50,
                  width: 50,
                ),
              ),
              Spacer(
                flex: 4,
              ),
            ],
          );
        }
        if (_transactions.isEmpty) {
          return const NoTransActionsFound();
        } else {
          final list = _transactions.values.toList(growable: false);
          list.sort((a, b) => b.timestamp - a.timestamp);
          return RefreshIndicator(
            onRefresh: () async {
              debugPrint("pulled down to refresh on transaction list");
              final managerProvider = ref
                  .read(walletsChangeNotifierProvider)
                  .getManagerProvider(widget.walletId);
              if (!ref.read(managerProvider).isRefreshing) {
                unawaited(ref.read(managerProvider).refresh());
              }
            },
            child: Util.isDesktop
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      BorderRadius? radius;
                      if (index == list.length - 1) {
                        radius = _borderRadiusLast;
                      } else if (index == 0) {
                        radius = _borderRadiusFirst;
                      }
                      final tx = list[index];
                      return itemBuilder(context, tx, radius);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 2,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .background,
                      );
                    },
                    itemCount: list.length,
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      BorderRadius? radius;
                      if (index == list.length - 1) {
                        radius = _borderRadiusLast;
                      } else if (index == 0) {
                        radius = _borderRadiusFirst;
                      }
                      final tx = list[index];
                      return itemBuilder(context, tx, radius);
                    },
                  ),
          );
        }
      },
    );
  }
}
