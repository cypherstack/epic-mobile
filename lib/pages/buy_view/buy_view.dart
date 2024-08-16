import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/utilities/assets.dart';
import 'package:epicpay/utilities/clipboard_interface.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/text_styles.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyView extends StatefulWidget {
  const BuyView({
    Key? key,
    required this.coin,
    required this.walletId,
    this.clipboard = const ClipboardWrapper(),
  }) : super(key: key);

  static const String routeName = "/buyView";

  final Coin coin;
  final String walletId;
  final ClipboardInterface clipboard;
  @override
  State<BuyView> createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  late final Coin coin;
  late final String walletId;
  late final ClipboardInterface clipboard;

  bool _onBuyWithCryptoLock = false;
  Future<void> _onBuyWithCryptoPressed() async {
    if (_onBuyWithCryptoLock) {
      return;
    }
    _onBuyWithCryptoLock = true;
    try {
      await Navigator.of(context).pushNamed(BuyWithCryptoStep1.routeName);
    } finally {
      _onBuyWithCryptoLock = false;
    }
  }

  bool _onBuyWithFiatLock = false;
  Future<void> _onBuyWithFiatPressed() async {
    if (_onBuyWithFiatLock) {
      return;
    }
    _onBuyWithFiatLock = true;
    try {
      // do stuff
    } finally {
      _onBuyWithFiatLock = false;
    }
  }

  @override
  void initState() {
    walletId = widget.walletId;
    coin = widget.coin;
    clipboard = widget.clipboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height < 600 ? 4 : 20,
        ),
        Text(
          "Buy EPIC",
          style: STextStyles.titleH2(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: height < 600 ? 8 : 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _CryptoButton(
            onPressed: () {
              if (mounted) {
                _onBuyWithCryptoPressed();
              }
            },
          ),
        ),
        SizedBox(
          height: height < 600 ? 4 : 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _FiatButton(
            onPressed: null, //_onBuyWithFiatPressed,
          ),
        ),
        SizedBox(
          height: height < 600 ? 10 : 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "PREVIOUS QUOTES",
            style: STextStyles.overLineBold(context),
          ),
        ),
        SizedBox(
          height: height < 600 ? 4 : 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RoundedWhiteContainer(
            child: Text("PLACEHOLDER"),
          ),
        ),
      ],
    );
  }
}

class _CryptoButton extends StatelessWidget {
  const _CryptoButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: RawMaterialButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              elevation: 0,
              fillColor: Theme.of(context).extension<StackColors>()!.popupBG,
            ),
          ),
          Positioned(
            top: -2,
            right: 100,
            child: IgnorePointer(
              child: SizedBox(
                width: 101.2,
                height: 88,
                child: SvgPicture.asset(
                  Assets.svg.layerUsdt,
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: 0,
            child: IgnorePointer(
              child: SizedBox(
                width: 90,
                height: 90,
                child: SvgPicture.asset(
                  Assets.svg.layerUsdc,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -8,
            right: 49,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerBtc,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        Assets.svg.bitcoin,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textGold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Buy with crypto",
                      style: STextStyles.bodyBold(context),
                    ),
                    Text(
                      "Buy EPIC with BTC, USDT, and more",
                      style: STextStyles.label(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiatButton extends StatelessWidget {
  const _FiatButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: RawMaterialButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.size.circularBorderRadius,
                ),
              ),
              elevation: 0,
              fillColor: Theme.of(context).extension<StackColors>()!.popupBG,
            ),
          ),
          Positioned(
            top: -8,
            right: 80,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerDollar,
                ),
              ),
            ),
          ),
          Positioned(
            top: 13,
            right: -14,
            child: IgnorePointer(
              child: SizedBox(
                width: 92,
                height: 106,
                child: SvgPicture.asset(
                  Assets.svg.layerEpic,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 65,
            child: IgnorePointer(
              child: SizedBox(
                width: 91,
                height: 91,
                child: SvgPicture.asset(
                  Assets.svg.layerEuro,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        Assets.svg.dollar,
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Buy with fiat",
                      style: STextStyles.bodyBold(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                    Text(
                      "Coming soon",
                      style: STextStyles.label(context).copyWith(
                        color: Theme.of(context)
                            .extension<StackColors>()!
                            .textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
