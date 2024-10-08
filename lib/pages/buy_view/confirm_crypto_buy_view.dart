import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/pages/buy_view/confirm_crypto_buy_info_dialog.dart';
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/custom_buttons/app_bar_icon_button.dart';
import 'package:epicpay/widgets/desktop/primary_button.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConfirmCryptoBuyView extends StatefulWidget {
  const ConfirmCryptoBuyView({super.key, required this.trade});

  final Trade trade;

  static const routeName = "/confirmCryptoBuyView";

  @override
  State<ConfirmCryptoBuyView> createState() => _ConfirmCryptoBuyViewState();
}

class _ConfirmCryptoBuyViewState extends State<ConfirmCryptoBuyView> {
  static const double maxDivHeight = 23;
  static const double minDivHeight = 5;
  final _key = GlobalKey();

  late final int divCount;
  double divHeight = maxDivHeight;
  double? layoutBuilderHeight;
  Size? size;

  bool _lolAndroid = false;

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

  @override
  void initState() {
    super.initState();
    divCount = 5;
    _setSize();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor * 0.85;

    return PopScope(
      canPop: _lolAndroid,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        _lolAndroid = true;
        Navigator.of(context).popUntil(
          ModalRoute.withName(HomeView.routeName),
        );
      },
      child: Background(
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
              onPressed: () {
                _lolAndroid = true;
                Navigator.of(context).popUntil(
                  ModalRoute.withName(HomeView.routeName),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppBarIconButton(
                    key: const Key("buyConfirmInfoButtonKey"),
                    size: 36,
                    shadows: const [],
                    color: const Color(0xFF222227),
                    icon: SvgPicture.asset(
                      Assets.svg.circleInfo,
                      color: Theme.of(context)
                          .extension<StackColors>()!
                          .topNavIconPrimary,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => ConfirmCryptoBuyInfoDialog(
                          baseCurrencyTicker:
                              widget.trade.fromCurrency.toUpperCase(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: scaleFactor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (builderContext, constraints) {
                    layoutBuilderHeight = constraints.maxHeight;
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: IntrinsicHeight(
                              key: _key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Send ${widget.trade.fromFullTicker}",
                                    style:
                                        STextStyles.titleH3(context).copyWith(
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .textLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: divHeight / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.5,
                                            color: Theme.of(context)
                                                .extension<StackColors>()!
                                                .textLight,
                                          ),
                                        ),
                                        child: QrImage(
                                          data: widget.trade.payinAddress,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Theme.of(context)
                                              .extension<StackColors>()!
                                              .textLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: divHeight / 2,
                                  ),
                                  Text(
                                    "SEND ${widget.trade.fromFullTicker} TO "
                                    "THIS ADDRESS",
                                    style: STextStyles.overLineBold(context)
                                        .copyWith(
                                      color: Theme.of(context)
                                          .extension<StackColors>()!
                                          .textDark,
                                    ),
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  Stack(
                                    children: [
                                      RoundedWhiteContainer(
                                        padding: EdgeInsets.zero,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(
                                                  widget.trade.payinAddress,
                                                  style:
                                                      STextStyles.body(context),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 7,
                                        right: 6,
                                        child: AppBarIconButton(
                                          size: 50,
                                          icon:
                                              SvgPicture.asset(Assets.svg.copy),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text: widget
                                                      .trade.payinAddress),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  _DetailsItem(
                                    title: "STATUS",
                                    data: widget.trade.status.length > 1
                                        ? "${widget.trade.status[0].toUpperCase()}${widget.trade.status.substring(1)}"
                                        : widget.trade.status,
                                    detailColor: Theme.of(context)
                                        .extension<StackColors>()!
                                        .colorForStatus(widget.trade.status),
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  _DetailsItem(
                                    title: "TRADE ID",
                                    data: widget.trade.tradeId,
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  _DetailsItem(
                                    title: "AMOUNT TO SEND",
                                    data:
                                        "${widget.trade.fromAmount} ${widget.trade.fromFullTicker}",
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "REFUND ${widget.trade.fromFullTicker} ADDRESS",
                                        style: STextStyles.overLineBold(context)
                                            .copyWith(
                                          color: Theme.of(context)
                                              .extension<StackColors>()!
                                              .textDark,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        widget.trade.refundAddress,
                                        style: STextStyles.body(context),
                                      ),
                                    ],
                                  ),
                                  _Divider(
                                    height: divHeight,
                                  ),
                                  PrimaryButton(
                                    label: "I HAVE SENT",
                                    onPressed: () {
                                      Navigator.of(context).popUntil(
                                        ModalRoute.withName(
                                          HomeView.routeName,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
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
    this.detailColor,
  });

  final String title;
  final String data;
  final Color? detailColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: STextStyles.overLineBold(context).copyWith(
              color: Theme.of(context).extension<StackColors>()!.textDark,
            ),
          ),
          Text(
            data,
            style: STextStyles.body(context).copyWith(
              color: detailColor ??
                  Theme.of(context).extension<StackColors>()!.textLight,
            ),
          ),
        ],
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
      ),
      child: Container(
        height: 1,
        color: Theme.of(context).extension<StackColors>()!.popupBG,
      ),
    );
  }
}
