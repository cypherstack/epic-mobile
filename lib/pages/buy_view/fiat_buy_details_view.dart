import 'dart:async';

import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/isar/models/guardarian_transaction.dart';
import 'package:epicpay/services/guardarian/guardarian_api.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/conditional_parent.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/custom_buttons/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isar/isar.dart';
import 'package:url_launcher/url_launcher.dart';

class FiatBuyDetailsView extends ConsumerStatefulWidget {
  const FiatBuyDetailsView({
    super.key,
    required this.transactionId,
    this.clipboard = const ClipboardWrapper(),
  });

  static const String routeName = "/fiatBuyDetails";

  final String transactionId;
  final ClipboardInterface clipboard;

  @override
  ConsumerState<FiatBuyDetailsView> createState() => _FiatBuyDetailsViewState();
}

class _FiatBuyDetailsViewState extends ConsumerState<FiatBuyDetailsView> {
  // ==== Layout ===============================================================
  static const double maxDivHeight = 51;
  static const double minDivHeight = 5;
  final _key = GlobalKey();
  static const sidePadding = EdgeInsets.symmetric(horizontal: 16);

  late int divCount;
  double divHeight = maxDivHeight;
  double? layoutBuilderHeight;
  Size? size;

  double _getInRange(double value) {
    if (value < minDivHeight) {
      return minDivHeight;
    } else if (value > maxDivHeight) {
      return maxDivHeight;
    } else {
      return value;
    }
  }

  void _setSize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      size = _key.currentContext?.size;

      if (layoutBuilderHeight != null && size != null) {
        if (layoutBuilderHeight! < size!.height) {
          final diff = size!.height - layoutBuilderHeight!;
          final dDiff = diff / divCount;
          divHeight = _getInRange(divHeight - dDiff);
        } else {
          final diff = layoutBuilderHeight! - size!.height;
          final dDiff = diff / divCount;
          divHeight = _getInRange(divHeight + dDiff);
        }
      }

      setState(() {});
    });
  }

  // ===========================================================================
  // ==== State ================================================================

  late GuardarianTransaction transaction;
  StreamSubscription<GuardarianTransaction?>? _subscription;

  // ===========================================================================

  @override
  initState() {
    transaction = ref
        .read(pIsarDB)
        .isar
        .guardarianTransactions
        .where()
        .transactionIdEqualTo(widget.transactionId)
        .findFirstSync()!;

    _subscription = ref
        .read(pIsarDB)
        .isar
        .guardarianTransactions
        .watchObject(transaction.id)
        .listen((tx) {
      if (tx != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (mounted) {
            setState(() {
              transaction = tx;
            });
          }
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final response = await GuardarianAPI.getTransaction(
          transaction.transactionId.toString(),
        );

        if (mounted && response.value != null) {
          final tx = GuardarianTransaction.fromGTransaction(
            response.value!,
            previousToCopy: transaction,
          );

          await ref.read(pIsarDB).isar.writeTxn(() async {
            await ref.read(pIsarDB).isar.guardarianTransactions.put(tx);
          });

          if (mounted) {
            transaction = tx;
            divCount = 4;
            if (transaction.address != null) {
              divCount += 1;
            }
            if (transaction.outputHash != null) {
              divCount += 1;
            }
            if (transaction.redirectUrl != null) {
              divCount += 1;
            }
            _setSize();
          }
        }
      }
    });

    divCount = 4;
    if (transaction.address != null) {
      divCount += 1;
    }
    if (transaction.outputHash != null) {
      divCount += 1;
    }
    if (transaction.redirectUrl != null) {
      divCount += 1;
    }

    _setSize();

    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor * 0.85;

    if (transaction.address != null ||
        transaction.outputHash != null ||
        transaction.redirectUrl != null) {
      if (transaction.address != null) {
        divCount += 1;
      }
      if (transaction.outputHash != null) {
        divCount += 1;
      }
      if (transaction.redirectUrl != null) {
        divCount += 1;
      }
    }

    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).extension<StackColors>()!.background,
          leading: AppBarBackButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            "Buy details",
            style: STextStyles.titleH4(context),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 16),
          //     child: SvgPicture.asset(
          //       Assets.exchange.changeNow,
          //       width: 32,
          //       height: 32,
          //     ),
          //   ),
          // ],
        ),
        body: SafeArea(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: scaleFactor,
            ),
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      layoutBuilderHeight = constraints.maxHeight;
                      return SingleChildScrollView(
                        child: IntrinsicHeight(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    transaction.fromCurrency.toUpperCase(),
                                    style:
                                        STextStyles.titleH3(context).copyWith(
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .textMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SvgPicture.asset(
                                      Assets.svg.swapArrows,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Text(
                                    transaction.toCurrency.toUpperCase(),
                                    style:
                                        STextStyles.titleH3(context).copyWith(
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .textMedium,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: SelectableText(
                                  transaction.status.prettyName,
                                  style: STextStyles.body(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .colorForGStatus(transaction.status),
                                  ),
                                ),
                              ),
                              _Divider(height: divHeight),
                              _DetailsItem(
                                title: "FROM",
                                data: "${transaction.expectedFromAmountString} "
                                    "${transaction.fromCurrency}"
                                    "${transaction.fromNetwork == null || transaction.fromNetwork == transaction.fromCurrency ? "" : " (${transaction.fromNetwork})"}",
                                isTapCopy: true,
                              ),
                              _Divider(height: divHeight),
                              _DetailsItem(
                                title: "TO",
                                data: "${transaction.toAmountString} "
                                    "${transaction.toCurrency}"
                                    "${transaction.toNetwork == null || transaction.toNetwork == transaction.toCurrency ? "" : " (${transaction.toNetwork})"}",
                                isTapCopy: true,
                                trailing: Text(
                                  "(estimated)",
                                  style: STextStyles.body(context).copyWith(
                                    color: Theme.of(context)
                                        .extension<StackColors>()!
                                        .textDark,
                                  ),
                                ),
                              ),
                              if (transaction.address != null)
                                _Divider(height: divHeight),
                              if (transaction.address != null)
                                _DetailsItem(
                                  title: "RECEIVING ADDRESS",
                                  data: transaction.address!,
                                  isTapCopy: true,
                                ),
                              _Divider(height: divHeight),
                              _DetailsItem(
                                title: "DATE",
                                data: Format.extractDateFrom(DateTime.parse(
                                      transaction.createdAt,
                                    ).millisecondsSinceEpoch ~/
                                    1000),
                                isTapCopy: true,
                              ),
                              if (transaction.outputHash != null)
                                _Divider(height: divHeight),
                              if (transaction.outputHash != null)
                                _DetailsItem(
                                  title: "OUTPUT HASH",
                                  data: transaction.outputHash!,
                                  isTapCopy: true,
                                ),
                              _Divider(height: divHeight),
                              _DetailsItem(
                                title: "TRANSACTION ID",
                                data: transaction.transactionId.toString(),
                                isTapCopy: true,
                              ),
                              if (transaction.redirectUrl != null)
                                _Divider(height: divHeight),
                              if (transaction.redirectUrl != null)
                                Padding(
                                  padding: sidePadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PURCHASE LINK",
                                        style:
                                            STextStyles.overLineBold(context),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          return CustomTextButton(
                                            text:
                                                "  ${transaction.redirectUrl!}  ",
                                            onPressed: () {
                                              launchUrl(
                                                Uri.parse(
                                                    transaction.redirectUrl!),
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsItem extends StatelessWidget {
  const _DetailsItem({
    super.key,
    required this.title,
    required this.data,
    this.trailing,
    this.trailingBelow = false,
    this.isTapCopy = false,
    this.verticalSpacing = 8,
    this.padding = _FiatBuyDetailsViewState.sidePadding,
    this.clipboard = const ClipboardWrapper(),
  });

  final String title;
  final String data;
  final Widget? trailing;
  final bool trailingBelow;
  final bool isTapCopy;
  final double verticalSpacing;
  final EdgeInsets padding;
  final ClipboardInterface clipboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: isTapCopy
            ? () {
                clipboard.setData(
                  ClipboardData(
                    text: data,
                  ),
                );
              }
            : null,
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: STextStyles.overLineBold(context),
              ),
              SizedBox(
                height: verticalSpacing,
              ),
              ConditionalParent(
                condition: trailing != null && !trailingBelow,
                builder: (child) => Row(
                  children: [
                    child,
                    const SizedBox(
                      width: 10,
                    ),
                    trailing!,
                  ],
                ),
                child: SelectableText(
                  data,
                  style: STextStyles.body(context),
                ),
              ),
              if (trailing != null && trailingBelow) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: (height - 1) / 2,
        horizontal: _FiatBuyDetailsViewState.sidePadding.left,
      ),
      child: Container(
        height: 1,
        color: Theme.of(context).extension<StackColors>()!.popupBG,
      ),
    );
  }
}
