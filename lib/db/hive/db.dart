import 'dart:isolate';

import 'package:epicpay/models/epicbox_server_model.dart';
import 'package:epicpay/models/node_model.dart';
import 'package:epicpay/models/trade_wallet_lookup.dart';
import 'package:epicpay/services/wallets_service.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:hive/hive.dart';
import 'package:mutex/mutex.dart';

class DB {
  // static const String boxNameAddressBook = "addressBook";
  // static const String boxNameDebugInfo = "debugInfoBox";
  static const String boxNameNodeModels = "nodeModels";
  static const String boxNamePrimaryNodes = "primaryNodes";
  static const String boxNameEpicBoxModels = "epicBoxModels";
  static const String boxNamePrimaryEpicBox = "primaryEpicBox";
  static const String boxNameAllWalletsData = "wallets";
  static const String boxNameTradeLookup = "tradeToTxidLookUpBox";
  static const String boxNameTradeNotes = "tradeNotesBox";
  static const String boxNameNotifications = "notificationModels";
  static const String boxNameWatchedTransactions =
      "watchedTxNotificationModels";

  static const String boxNameFavoriteWallets = "favoriteWallets";
  static const String boxNamePrefs = "prefs";
  static const String boxNameWalletsToDeleteOnStart = "walletsToDeleteOnStart";
  static const String boxNamePriceCache = "priceAPIPrice24hCache";
  static const String boxNameDBInfo = "dbInfo";
  static const String boxNameTheme = "theme";

  String boxNameTxCache({required Coin coin}) => "${coin.name}_txCache";
  String boxNameSetCache({required Coin coin}) =>
      "${coin.name}_anonymitySetCache";
  String boxNameUsedSerialsCache({required Coin coin}) =>
      "${coin.name}_usedSerialsCache";

  static bool _initialized = false;

  // late final Box<dynamic> _boxAddressBook;
  // late final Box<String> _boxDebugInfo;
  late final Box<NodeModel> _boxNodeModels;
  late final Box<NodeModel> _boxPrimaryNodes;
  late final Box<EpicBoxServerModel> _boxEpicBoxModels;
  late final Box<EpicBoxServerModel> _boxPrimaryEpicBoxes;
  late final Box<dynamic> _boxAllWalletsData;

  late final Box<String> _boxFavoriteWallets;
  // late final Box<xmr.WalletInfo> _walletInfoSource;
  late final Box<dynamic> _boxPrefs;
  Box<TradeWalletLookup>? _boxTradeLookup;
  Box<String>? _boxTradeNotes;
  late final Box<dynamic> _boxDBInfo;

  final Map<String, Box<dynamic>> _walletBoxes = {};

  final Map<Coin, Box<dynamic>> _txCacheBoxes = {};
  final Map<Coin, Box<dynamic>> _setCacheBoxes = {};
  final Map<Coin, Box<dynamic>> _usedSerialsCacheBoxes = {};

  // exposed for monero
  // Box<xmr.WalletInfo> get moneroWalletInfoBox => _walletInfoSource;

  // mutex for stack backup
  final mutex = Mutex();

  DB._();
  static final DB _instance = DB._();
  static DB get instance {
    // "This name does not uniquely identify an isolate. Multiple isolates in the same process may have the same debugName."
    // if (Isolate.current.debugName != "main") {
    // TODO: make sure this works properly
    if (Isolate.current.debugName != "main") {
      throw Exception(
          "DB.instance should not be accessed outside the main isolate!");
    }

    return _instance;
  }

  // open hive boxes
  Future<void> init() async {
    if (!_initialized) {
      if (Hive.isBoxOpen(boxNameDBInfo)) {
        _boxDBInfo = Hive.box<dynamic>(boxNameDBInfo);
      } else {
        _boxDBInfo = await Hive.openBox<dynamic>(boxNameDBInfo);
      }
      await Hive.openBox<String>(boxNameWalletsToDeleteOnStart);

      if (Hive.isBoxOpen(boxNamePrefs)) {
        _boxPrefs = Hive.box<dynamic>(boxNamePrefs);
      } else {
        _boxPrefs = await Hive.openBox<dynamic>(boxNamePrefs);
      }

      // _boxAddressBook = await Hive.openBox<dynamic>(boxNameAddressBook);
      // _boxDebugInfo = await Hive.openBox<String>(boxNameDebugInfo);

      if (Hive.isBoxOpen(boxNameNodeModels)) {
        _boxNodeModels = Hive.box<NodeModel>(boxNameNodeModels);
      } else {
        _boxNodeModels = await Hive.openBox<NodeModel>(boxNameNodeModels);
      }

      if (Hive.isBoxOpen(boxNamePrimaryNodes)) {
        _boxPrimaryNodes = Hive.box<NodeModel>(boxNamePrimaryNodes);
      } else {
        _boxPrimaryNodes = await Hive.openBox<NodeModel>(boxNamePrimaryNodes);
      }

      if (Hive.isBoxOpen(boxNameEpicBoxModels)) {
        _boxEpicBoxModels = Hive.box<EpicBoxServerModel>(boxNameEpicBoxModels);
      } else {
        _boxEpicBoxModels =
            await Hive.openBox<EpicBoxServerModel>(boxNameEpicBoxModels);
      }

      if (Hive.isBoxOpen(boxNamePrimaryEpicBox)) {
        _boxPrimaryEpicBoxes =
            Hive.box<EpicBoxServerModel>(boxNamePrimaryEpicBox);
      } else {
        _boxPrimaryEpicBoxes =
            await Hive.openBox<EpicBoxServerModel>(boxNamePrimaryEpicBox);
      }

      if (Hive.isBoxOpen(boxNameAllWalletsData)) {
        _boxAllWalletsData = Hive.box<dynamic>(boxNameAllWalletsData);
      } else {
        _boxAllWalletsData = await Hive.openBox<dynamic>(boxNameAllWalletsData);
      }

      // _walletInfoSource =
      //     await Hive.openBox<xmr.WalletInfo>(xmr.WalletInfo.boxName);
      _boxFavoriteWallets = await Hive.openBox<String>(boxNameFavoriteWallets);
      _boxTradeLookup =
          await Hive.openBox<TradeWalletLookup>(boxNameTradeLookup);
      _boxTradeNotes = await Hive.openBox<String>(boxNameTradeNotes);

      await Future.wait([
        Hive.openBox<dynamic>(boxNamePriceCache),
        _loadWalletBoxes(),
        _loadSharedCoinCacheBoxes(),
      ]);
      _initialized = true;
    }
  }

  Future<void> _loadWalletBoxes() async {
    final names = _boxAllWalletsData.get("names") as Map? ?? {};
    names.removeWhere((name, dyn) {
      final jsonObject = Map<String, dynamic>.from(dyn as Map);
      try {
        Coin.values.byName(jsonObject["coin"] as String);
        return false;
      } catch (e, s) {
        Logging.instance.log(
            "Error, ${jsonObject["coin"]} does not exist, $name wallet cannot be loaded",
            level: LogLevel.Error);
        return true;
      }
    });
    final mapped = Map<String, dynamic>.from(names).map((name, dyn) => MapEntry(
        name, WalletInfo.fromJson(Map<String, dynamic>.from(dyn as Map))));

    for (final entry in mapped.entries) {
      if (Hive.isBoxOpen(entry.value.walletId)) {
        _walletBoxes[entry.value.walletId] =
            Hive.box<dynamic>(entry.value.walletId);
      } else {
        _walletBoxes[entry.value.walletId] =
            await Hive.openBox<dynamic>(entry.value.walletId);
      }
    }
  }

  Future<void> _loadSharedCoinCacheBoxes() async {
    for (final coin in Coin.values) {
      _txCacheBoxes[coin] =
          await Hive.openBox<dynamic>(boxNameTxCache(coin: coin));
      _setCacheBoxes[coin] =
          await Hive.openBox<dynamic>(boxNameSetCache(coin: coin));
      _usedSerialsCacheBoxes[coin] =
          await Hive.openBox<dynamic>(boxNameUsedSerialsCache(coin: coin));
    }
  }

  /////////////////////////////////////////

  Future<void> addWalletBox({required String walletId}) async {
    if (_walletBoxes[walletId] != null) {
      throw Exception("Attempted overwrite of existing wallet box!");
    }
    _walletBoxes[walletId] = await Hive.openBox<dynamic>(walletId);
  }

  Future<void> removeWalletBox({required String walletId}) async {
    _walletBoxes.remove(walletId);
  }

  ///////////////////////////////////////////

  // reads

  List<dynamic> keys<T>({required String boxName}) =>
      Hive.box<T>(boxName).keys.toList(growable: false);

  List<T> values<T>({required String boxName}) =>
      Hive.box<T>(boxName).values.toList(growable: false);

  T? get<T>({
    required String boxName,
    required dynamic key,
  }) =>
      Hive.box<T>(boxName).get(key);

  bool containsKey<T>({required String boxName, required dynamic key}) =>
      Hive.box<T>(boxName).containsKey(key);

  // writes

  Future<void> put<T>(
          {required String boxName,
          required dynamic key,
          required T value}) async =>
      await mutex
          .protect(() async => await Hive.box<T>(boxName).put(key, value));

  Future<void> add<T>({required String boxName, required T value}) async =>
      await mutex.protect(() async => await Hive.box<T>(boxName).add(value));

  Future<void> addAll<T>(
          {required String boxName, required Iterable<T> values}) async =>
      await mutex
          .protect(() async => await Hive.box<T>(boxName).addAll(values));

  Future<void> delete<T>(
          {required dynamic key, required String boxName}) async =>
      await mutex.protect(() async => await Hive.box<T>(boxName).delete(key));

  Future<void> deleteAll<T>({required String boxName}) async =>
      await mutex.protect(() async => await Hive.box<T>(boxName).clear());

  Future<void> deleteBoxFromDisk({required String boxName}) async =>
      await mutex.protect(() async => await Hive.deleteBoxFromDisk(boxName));
}
