import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/utilities/amount/amount_unit.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/enums/languages_enum.dart';
import 'package:epicpay/utilities/enums/sync_type_enum.dart';
import 'package:flutter/cupertino.dart';

class Prefs extends ChangeNotifier {
  Prefs._();
  static final Prefs _instance = Prefs._();
  static Prefs get instance => _instance;

  bool _initialized = false;
  bool get isInitialized => _initialized;

  Future<void> init() async {
    if (!_initialized) {
      _currency = await _getPreferredCurrency();
      _useBiometrics = await _getUseBiometrics();
      _hasPin = await _getHasPin();
      _language = await _getPreferredLanguage();
      _showFavoriteWallets = await _getShowFavoriteWallets();
      _wifiOnly = await _getUseWifiOnly();
      _syncType = await _getSyncType();
      _walletIdsSyncOnStartup = await _getWalletIdsSyncOnStartup();
      _currentNotificationId = await _getCurrentNotificationIndex();
      _lastUnlocked = await _getLastUnlocked();
      _lastUnlockedTimeout = await _getLastUnlockedTimeout();
      _showTestNetCoins = await _getShowTestNetCoins();
      _hideBlockExplorerWarning = await _getHideBlockExplorerWarning();
      _refreshPeriod = await _getRefreshPeriod();
      _familiarity = await _getHasFamiliarity();
      await _setAmountUnits();
      await _setMaxDecimals();

      _initialized = true;
    }
  }

  Future<void> reinit() async {
    _currency = await _getPreferredCurrency();
    _useBiometrics = await _getUseBiometrics();
    _hasPin = await _getHasPin();
    _language = await _getPreferredLanguage();
    _showFavoriteWallets = await _getShowFavoriteWallets();
    _wifiOnly = await _getUseWifiOnly();
    _syncType = await _getSyncType();
    _walletIdsSyncOnStartup = await _getWalletIdsSyncOnStartup();
    _currentNotificationId = await _getCurrentNotificationIndex();
    _lastUnlocked = await _getLastUnlocked();
    _lastUnlockedTimeout = await _getLastUnlockedTimeout();
    _showTestNetCoins = await _getShowTestNetCoins();
    _hideBlockExplorerWarning = await _getHideBlockExplorerWarning();
    _refreshPeriod = await _getRefreshPeriod();
    _familiarity = await _getHasFamiliarity();
  }

  // last timestamp user unlocked wallet

  int _lastUnlockedTimeout = 60;

  int get lastUnlockedTimeout => _lastUnlockedTimeout;

  set lastUnlockedTimeout(int lastUnlockedTimeout) {
    if (_lastUnlockedTimeout != lastUnlockedTimeout) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs,
          key: "lastUnlockedTimeout",
          value: lastUnlockedTimeout);
      _lastUnlockedTimeout = lastUnlockedTimeout;
      notifyListeners();
    }
  }

  Future<int> _getLastUnlockedTimeout() async {
    return (DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "lastUnlockedTimeout")) as int? ??
        60;
  }

  // last timestamp user unlocked wallet

  int _lastUnlocked = 0;

  int get lastUnlocked => _lastUnlocked;

  set lastUnlocked(int lastUnlocked) {
    if (_lastUnlocked != lastUnlocked) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "lastUnlocked", value: lastUnlocked);
      _lastUnlocked = lastUnlocked;
      notifyListeners();
    }
  }

  Future<int> _getLastUnlocked() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "lastUnlocked") as int? ??
        0;
  }

  // notification index

  late int _currentNotificationId;

  int get currentNotificationId => _currentNotificationId;

  Future<void> incrementCurrentNotificationIndex() async {
    if (_currentNotificationId <= Constants.notificationsMax) {
      _currentNotificationId++;
    } else {
      _currentNotificationId = 0;
    }
    await DB.instance.put<dynamic>(
        boxName: DB.boxNamePrefs,
        key: "currentNotificationId",
        value: _currentNotificationId);
    notifyListeners();
  }

  Future<int> _getCurrentNotificationIndex() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "currentNotificationId") as int? ??
        0;
  }

  // list of wallet ids to auto sync when auto sync only selected wallets is chosen

  List<String> _walletIdsSyncOnStartup = [];

  List<String> get walletIdsSyncOnStartup => _walletIdsSyncOnStartup;

  set walletIdsSyncOnStartup(List<String> walletIdsSyncOnStartup) {
    if (_walletIdsSyncOnStartup != walletIdsSyncOnStartup) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs,
          key: "walletIdsSyncOnStartup",
          value: walletIdsSyncOnStartup);
      _walletIdsSyncOnStartup = walletIdsSyncOnStartup;
      notifyListeners();
    }
  }

  Future<List<String>> _getWalletIdsSyncOnStartup() async {
    final list = await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "walletIdsSyncOnStartup") as List? ??
        [];
    return List<String>.from(list);
  }

  // sync type

  SyncingType _syncType = SyncingType.allWalletsOnStartup;

  SyncingType get syncType => _syncType;

  set syncType(SyncingType syncType) {
    if (_syncType != syncType) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs,
          key: "syncTypeIndex",
          value: syncType.index);
      _syncType = syncType;
      notifyListeners();
    }
  }

  Future<SyncingType> _getSyncType() async {
    final int index = await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "syncTypeIndex") as int? ??
        SyncingType.allWalletsOnStartup.index;
    return SyncingType.values[index];
  }

  // wifi only

  bool _wifiOnly = false;

  bool get wifiOnly => _wifiOnly;

  set wifiOnly(bool wifiOnly) {
    if (_wifiOnly != wifiOnly) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "wifiOnly", value: wifiOnly);
      _wifiOnly = wifiOnly;
      notifyListeners();
    }
  }

  Future<bool> _getUseWifiOnly() async {
    return await DB.instance
            .get<dynamic>(boxName: DB.boxNamePrefs, key: "wifiOnly") as bool? ??
        false;
  }

  // show favorites

  bool _showFavoriteWallets = true;

  bool get showFavoriteWallets => _showFavoriteWallets;

  set showFavoriteWallets(bool showFavoriteWallets) {
    if (_showFavoriteWallets != showFavoriteWallets) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs,
          key: "showFavoriteWallets",
          value: showFavoriteWallets);
      _showFavoriteWallets = showFavoriteWallets;
      notifyListeners();
    }
  }

  Future<bool> _getShowFavoriteWallets() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "showFavoriteWallets") as bool? ??
        true;
  }

  // language

  String _language = Language.englishUS.description;

  String get language => _language;

  set language(String newLanguage) {
    if (_language != newLanguage) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "language", value: newLanguage);
      _language = newLanguage;
      notifyListeners();
    }
  }

  Future<String> _getPreferredLanguage() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "language") as String? ??
        Language.englishUS.description;
  }

  // base currency

  String _currency = "USD";

  String get currency => _currency;

  set currency(String newCurrency) {
    if (currency != newCurrency) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "currency", value: newCurrency);
      _currency = newCurrency;
      notifyListeners();
    }
  }

  Future<String> _getPreferredCurrency() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "currency") as String? ??
        "USD";
  }

  // use biometrics

  bool _useBiometrics = false;

  bool get useBiometrics => _useBiometrics;

  set useBiometrics(bool useBiometrics) {
    if (_useBiometrics != useBiometrics) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "useBiometrics", value: useBiometrics);
      _useBiometrics = useBiometrics;
      notifyListeners();
    }
  }

  Future<bool> _getUseBiometrics() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "useBiometrics") as bool? ??
        false;
  }

  // has set up pin

  bool _hasPin = false;

  bool get hasPin => _hasPin;

  set hasPin(bool hasPin) {
    if (_hasPin != hasPin) {
      DB.instance
          .put<dynamic>(boxName: DB.boxNamePrefs, key: "hasPin", value: hasPin);
      _hasPin = hasPin;
      notifyListeners();
    }
  }

  Future<bool> _getHasPin() async {
    return await DB.instance
            .get<dynamic>(boxName: DB.boxNamePrefs, key: "hasPin") as bool? ??
        false;
  }

  // show testnet coins

  bool _showTestNetCoins = false;

  bool get showTestNetCoins => _showTestNetCoins;

  set showTestNetCoins(bool showTestNetCoins) {
    if (_showTestNetCoins != showTestNetCoins) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs,
          key: "showTestNetCoins",
          value: showTestNetCoins);
      _showTestNetCoins = showTestNetCoins;
      notifyListeners();
    }
  }

  Future<bool> _getShowTestNetCoins() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "showTestNetCoins") as bool? ??
        false;
  }

  // auto backup

  bool _hideBlockExplorerWarning = false;

  bool get hideBlockExplorerWarning => _hideBlockExplorerWarning;

  set hideBlockExplorerWarning(bool hideBlockExplorerWarning) {
    if (_hideBlockExplorerWarning != hideBlockExplorerWarning) {
      DB.instance
          .put<dynamic>(
              boxName: DB.boxNamePrefs,
              key: "hideBlockExplorerWarning",
              value: hideBlockExplorerWarning)
          .then((_) {
        _hideBlockExplorerWarning = hideBlockExplorerWarning;
        notifyListeners();
      });
    }
  }

  Future<bool> _getHideBlockExplorerWarning() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs,
            key: "hideBlockExplorerWarning") as bool? ??
        false;
  }

  // refresh period, in seconds

  int? _refreshPeriod = 60;

  int? get refreshPeriod => _refreshPeriod;

  set refreshPeriod(int? refreshPeriod) {
    if (_refreshPeriod != (refreshPeriod ?? 60)) {
      DB.instance
          .put<dynamic>(
              boxName: DB.boxNamePrefs,
              key: "refreshPeriod",
              value: refreshPeriod ?? 60)
          .then((_) {
        _refreshPeriod = refreshPeriod;
        notifyListeners();
      });
    }
  }

  Future<int> _getRefreshPeriod() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "refreshPeriod") as int? ??
        60;
  }

  // coin amount unit settings

  final Map<Coin, AmountUnit> _amountUnits = {};

  AmountUnit amountUnit(Coin coin) => _amountUnits[coin] ?? AmountUnit.normal;

  void updateAmountUnit({required Coin coin, required AmountUnit amountUnit}) {
    if (this.amountUnit(coin) != amountUnit) {
      DB.instance.put<dynamic>(
        boxName: DB.boxNamePrefs,
        key: "amountUnitFor${coin.name}",
        value: amountUnit.index,
      );
      _amountUnits[coin] = amountUnit;
      notifyListeners();
    }
  }

  Future<void> _setAmountUnits() async {
    for (final coin in Coin.values) {
      final unitIndex = await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs,
            key: "amountUnitFor${coin.name}",
          ) as int? ??
          0; // 0 is "normal"
      _amountUnits[coin] = AmountUnit.values[unitIndex];
    }
  }

  // coin precision setting (max decimal places to show)

  final Map<Coin, int> _amountDecimals = {};

  int maxDecimals(Coin coin) => _amountDecimals[coin] ?? coin.decimals;

  void updateMaxDecimals({required Coin coin, required int maxDecimals}) {
    if (this.maxDecimals(coin) != maxDecimals) {
      DB.instance.put<dynamic>(
        boxName: DB.boxNamePrefs,
        key: "maxDecimalsFor${coin.name}",
        value: maxDecimals,
      );
      _amountDecimals[coin] = maxDecimals;
      notifyListeners();
    }
  }

  Future<void> _setMaxDecimals() async {
    for (final coin in Coin.values) {
      final decimals = await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs,
            key: "maxDecimalsFor${coin.name}",
          ) as int? ??
          (coin.decimals > 18 ? 18 : coin.decimals);
      // use some sane max rather than up to 30 that nano uses
      _amountDecimals[coin] = decimals;
    }
  }

  // familiarity

  int _familiarity = 0;

  int get familiarity => _familiarity;

  set familiarity(int familiarity) {
    if (_familiarity != familiarity) {
      DB.instance.put<dynamic>(
          boxName: DB.boxNamePrefs, key: "familiarity", value: familiarity);
      _familiarity = familiarity;
      notifyListeners();
    }
  }

  Future<int> _getHasFamiliarity() async {
    return await DB.instance.get<dynamic>(
            boxName: DB.boxNamePrefs, key: "familiarity") as int? ??
        0;
  }
}
