import 'package:epicpay/services/swap/change_now/change_now_exchange.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/theme/color_theme.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:flutter/material.dart';

abstract class Assets {
  static const svg = _SVG();
  static const png = _PNG();
  static const lottie = _ANIMATIONS();
  static const socials = _SOCIALS();
  static const exchange = _EXCHANGE();
  static const cn = _CN();
}

class _SOCIALS {
  const _SOCIALS();

  String get compass => "assets/svg/socials/compass.svg";
  String get reddit => "assets/svg/socials/reddit.svg";
  String get twitter => "assets/svg/socials/twitter.svg";
  String get telegram => "assets/svg/socials/telegram.svg";
}

class _EXCHANGE {
  const _EXCHANGE();

  String get changeNow => "assets/svg/change-now-logo.svg";
  // String get simpleSwap => "assets/svg/exchange_icons/simpleswap-icon.svg";

  String getIconFor({required String exchangeName}) {
    switch (exchangeName) {
      case ChangeNowExchange.exchangeName:
        return changeNow;
      default:
        throw ArgumentError("Invalid exchange name passed to "
            "Assets.exchange.getIconFor()");
    }
  }
}

class _SVG {
  const _SVG();
  String? background(BuildContext context) {
    switch (Theme.of(context).extension<StackColors>()!.themeType) {
      case ThemeType.light:
      case ThemeType.dark:
        return null;
    }
  }

  String receive(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/tx-icon-receive.svg";
  String receivePending(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/arrow-down-circle-pending.svg";
  String receiveCancelled(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/tx-icon-receive-failed.svg";

  String send(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/tx-icon-send.svg";
  String sendPending(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/arrow-up-circle-pending.svg";
  String sendCancelled(BuildContext context) =>
      "assets/svg/${Theme.of(context).extension<StackColors>()!.themeType.name}/tx-icon-send-failed.svg";

  // String get themeOcean => "assets/svg/ocean-breeze-theme.svg";
  // String get themeLight => "assets/svg/light-mode.svg";
  // String get themeDark => "assets/svg/dark-theme.svg";

  String get pay => "assets/svg/pay.svg";
  String get swapArrows => "assets/svg/swap-arrows.svg";
  String get clipboard => "assets/svg/clipboard.svg";
  String get eyeOff => "assets/svg/eye-off.svg";
  String get edit => "assets/svg/edit.svg";
  String get walletHome => "assets/svg/wallet.svg";
  String get download => "assets/svg/download.svg";
  String get upload => "assets/svg/upload.svg";
  String get circleCheck => "assets/svg/check-circle.svg";
  String get circleRedX => "assets/svg/thin-x-circle.svg";
  // String get circleSliders => "assets/svg/configuration.svg";
  // String get circlePlus => "assets/svg/plus-circle.svg";
  // String get framedGear => "assets/svg/framed-gear.svg";
  // String get circleNode => "assets/svg/node-circle.svg";
  // String get circleSun => "assets/svg/sun-circle.svg";
  // String get circleArrowRotate => "assets/svg/rotate-circle.svg";
  // String get circleLanguage => "assets/svg/language-circle.svg";
  // String get circleDollarSign => "assets/svg/dollar-sign-circle.svg";
  String get drd => "assets/svg/drd-icon.svg";
  // String get boxAuto => "assets/svg/box-auto.svg";
  String get plus => "assets/svg/plus.svg";
  String get gear => "assets/svg/gear.svg";
  // String get bell => "assets/svg/bell.svg";
  String get arrowLeft => "assets/svg/arrow-left-fa.svg";
  String get star => "assets/svg/star.svg";
  String get copy => "assets/svg/copy.svg";
  // String get circleX => "assets/svg/x-circle.svg";
  String get check => "assets/svg/check.svg";
  // String get circleAlert => "assets/svg/alert-circle2.svg";
  String get arrowDownLeft => "assets/svg/arrow-down-left.svg";
  String get arrowUpRight => "assets/svg/arrow-up-right.svg";
  String get menu => "assets/svg/bars.svg";
  String get filter => "assets/svg/filter.svg";
  // String get pending => "assets/svg/pending.svg";
  String get radio => "assets/svg/signal-stream.svg";
  String get arrowRotate => "assets/svg/arrow-rotate.svg";
  // String get arrowRotate2 => "assets/svg/arrow-rotate2.svg";
  String get alertCircle => "assets/svg/alert-circle.svg";
  String get checkCircle => "assets/svg/circle-check.svg";
  String get qrcode => "assets/svg/qrcode1.svg";
  String get ellipsis => "assets/svg/gear-3.svg";
  String get chevronDown => "assets/svg/chevron-down.svg";
  String get chevronUp => "assets/svg/chevron-up.svg";
  String get swap => "assets/svg/swap.svg";
  // String get downloadFolder => "assets/svg/folder-down.svg";
  String get lockFilled => "assets/svg/lock-filled.svg";
  String get lockOpen => "assets/svg/unlocked.svg";
  String get lock => "assets/svg/lock.svg";
  String get wifi => "assets/svg/wifi.svg";
  String get network => "assets/svg/network-wired.svg";
  String get networkWired => "assets/svg/network-wired-2.svg";
  String get refresh => "assets/svg/refresh.svg";
  String get addressBook => "assets/svg/book-open.svg";
  String get arrowRotate3 => "assets/svg/rotate-exclamation.svg";
  String get delete => "assets/svg/delete.svg";
  String get globe => "assets/svg/globe.svg";
  String get arrowRight => "assets/svg/arrow-right.svg";
  String get dollarSign => "assets/svg/dollar-sign.svg";
  String get language => "assets/svg/language2.svg";
  // String get sun => "assets/svg/sun-bright2.svg";
  // String get pencil => "assets/svg/pen-solid-fa.svg";
  String get search => "assets/svg/magnifying-glass.svg";
  String get thickX => "assets/svg/x-fat.svg";
  String get x => "assets/svg/x.svg";
  String get user => "assets/svg/user.svg";
  String get trash => "assets/svg/trash.svg";
  // String get eye => "assets/svg/eye.svg";
  String get eyeSlash => "assets/svg/eye-slash.svg";
  String get folder => "assets/svg/folder.svg";
  String get calendar => "assets/svg/calendar-days.svg";
  String get circleQuestion => "assets/svg/circle-question.svg";
  String get circleInfo => "assets/svg/info-circle.svg";
  String get key => "assets/svg/key.svg";
  String get node => "assets/svg/node-alt.svg";
  String get radioProblem => "assets/svg/signal-problem-alt.svg";
  String get radioSyncing => "assets/svg/signal-sync-alt.svg";
  // String get walletSettings => "assets/svg/wallet-settings.svg";
  String get verticalEllipsis => "assets/svg/ellipsis-vertical1.svg";
  String get dice => "assets/svg/dice-alt.svg";
  String get circleArrowUpRight => "assets/svg/circle-arrow-up-right2.svg";
  String get loader => "assets/svg/loader.svg";
  // String get backupAdd => "assets/svg/add-backup.svg";
  // String get backupAuto => "assets/svg/auto-backup.svg";
  // String get backupRestore => "assets/svg/restore-backup.svg";
  // String get solidSliders => "assets/svg/sliders-solid.svg";
  // String get questionMessage => "assets/svg/message-question.svg";
  // String get envelope => "assets/svg/envelope.svg";
  String get share => "assets/svg/share-2.svg";
  // String get anonymize => "assets/svg/tx-icon-anonymize.svg";
  // String get anonymizePending => "assets/svg/tx-icon-anonymize-pending.svg";
  // String get anonymizeFailed => "assets/svg/tx-icon-anonymize-failed.svg";
  // String get addressBookDesktop => "assets/svg/address-book-desktop.svg";
  // String get exchangeDesktop => "assets/svg/exchange-desktop.svg";
  // String get aboutDesktop => "assets/svg/about-desktop.svg";
  // String get walletDesktop => "assets/svg/wallet-desktop.svg";
  // String get exitDesktop => "assets/svg/exit-desktop.svg";
  // String get keys => "assets/svg/keys.svg";
  String get arrowDown => "assets/svg/arrow-down.svg";
  String get txSwap => "assets/svg/tx-swap.svg";
  String get txSwapPending => "assets/svg/tx-swap-pending.svg";
  String get txSwapFailed => "assets/svg/thin-x-circle.svg";

  String get epicCash => "assets/svg/coin_icons/EpicCash.svg";

  String get chevronRight => "assets/svg/chevron-right.svg";
  // String get minimize => "assets/svg/minimize.svg";
  // String get walletFa => "assets/svg/wallet-fa.svg";
  // String get exchange3 => "assets/svg/exchange-3.svg";
  // String get messageQuestion => "assets/svg/message-question-1.svg";

  String get epicBG => "assets/svg/epic-bg.svg";
  String get buy => "assets/svg/buy-credit-card.svg";

  String get bitcoin => "assets/svg/bitcoin.svg";
  String get dollar => "assets/svg/dollar.svg";
  String get paste => "assets/svg/paste.svg";

  // layers for buy button backgrounds

  String get layerEpic => "assets/svg/layers/epic-layer.svg";
  String get layerBtc => "assets/svg/layers/btc-layer.svg";
  String get layerUsdt => "assets/svg/layers/usdt-layer.svg";
  String get layerUsdc => "assets/svg/layers/usdc-layer.svg";
  String get layerEuro => "assets/svg/layers/euro-layer.svg";
  String get layerDollar => "assets/svg/layers/dollar-layer.svg";

  String iconFor({required Coin coin}) {
    switch (coin) {
      case Coin.epicCash:
        return epicCash;
    }
  }
}

class _CN {
  const _CN();

  String get btc => "assets/svg/cn_icons/btc.svg";

  String get usdcBSC => "assets/svg/cn_icons/usdcbsc.svg";
  String get usdcERC20 => "assets/svg/cn_icons/usdcerc20.svg";
  String get usdcSOL => "assets/svg/cn_icons/usdcsol.svg";

  String get usdtBSC => "assets/svg/cn_icons/usdtbsc.svg";
  String get usdtERC20 => "assets/svg/cn_icons/usdterc20.svg";
  String get usdtSOL => "assets/svg/cn_icons/usdtsol.svg";
  String get usdtTRC20 => "assets/svg/cn_icons/usdttrc20.svg";
}

class _PNG {
  const _PNG();

  String get splash => "assets/images/splash.png";
  String get epicCash => "assets/images/epic-cash.png";
  String get epicFast => "assets/images/epic-fast.png";
  String get epicClouds => "assets/images/epic-clouds.png";
  String get epicWelcome => "assets/images/epic-welcome.png";
}

class _ANIMATIONS {
  const _ANIMATIONS();

  String get test2 => "assets/lottie/test2.json";
}
