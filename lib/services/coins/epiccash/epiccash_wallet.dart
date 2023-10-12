import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:decimal/decimal.dart';
import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/models/epicbox_config_model.dart';
import 'package:epicpay/models/epicbox_server_model.dart';
import 'package:epicpay/models/node_model.dart';
import 'package:epicpay/models/paymint/fee_object_model.dart';
import 'package:epicpay/models/paymint/transactions_model.dart';
import 'package:epicpay/models/paymint/utxo_model.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/manage_nodes_views/add_edit_node_view.dart';
import 'package:epicpay/services/coins/coin_service.dart';
import 'package:epicpay/services/event_bus/events/global/blocks_remaining_event.dart';
import 'package:epicpay/services/event_bus/events/global/epicbox_status_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/node_connection_status_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/refresh_percent_changed_event.dart';
import 'package:epicpay/services/event_bus/events/global/updated_in_background_event.dart';
import 'package:epicpay/services/event_bus/events/global/wallet_sync_status_changed_event.dart';
import 'package:epicpay/services/event_bus/global_event_bus.dart';
import 'package:epicpay/services/node_service.dart';
import 'package:epicpay/services/price.dart';
import 'package:epicpay/utilities/amount/amount.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/default_epicboxes.dart';
import 'package:epicpay/utilities/default_nodes.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/flutter_secure_storage_interface.dart';
import 'package:epicpay/utilities/format.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/prefs.dart';
import 'package:epicpay/utilities/test_epic_node_connection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_libepiccash/epic_cash.dart';
import 'package:flutter_libepiccash/lib.dart' as epiccash;
import 'package:flutter_libepiccash/models/transaction.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mutex/mutex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stack_wallet_backup/generate_password.dart';
import 'package:tuple/tuple.dart';
import 'package:websocket_universal/websocket_universal.dart';

const int MINIMUM_CONFIRMATIONS = 3;

const String GENESIS_HASH_MAINNET = "";
const String GENESIS_HASH_TESTNET = "";
// isolate

Map<ReceivePort, Isolate> isolates = {};

Future<ReceivePort> getIsolate(Map<String, dynamic> arguments,
    {String name = ""}) async {
  ReceivePort receivePort =
      ReceivePort(); //port for isolate to receive messages.
  arguments['sendPort'] = receivePort.sendPort;
  Logging.instance.log("starting isolate ${arguments['function']} name: $name",
      level: LogLevel.Info);
  Isolate isolate = await Isolate.spawn(executeNative, arguments);
  isolates[receivePort] = isolate;
  return receivePort;
}

Future<void> executeNative(Map<String, dynamic> arguments) async {
  await Logging.instance.initInIsolate();
  final SendPort sendPort = arguments['sendPort'] as SendPort;
  final function = arguments['function'] as String;
  try {

    Logging.instance.log(
        "Error Arguments for $function not formatted correctly",
        level: LogLevel.Fatal);
    sendPort.send("Error Arguments for $function not formatted correctly");
  } catch (e, s) {
    Logging.instance.log(
        "An error was thrown in this isolate $function: $e\n$s",
        level: LogLevel.Error);
    sendPort
        .send("Error An error was thrown in this isolate $function: $e\n$s");
  } finally {
    await Logging.instance.isar?.close();
  }
}

void stop(ReceivePort port) {
  Isolate? isolate = isolates.remove(port);
  if (isolate != null) {
    isolate.kill(priority: Isolate.immediate);
    isolate = null;
  }
}

// Keep Wrapper functions outside of the class to avoid memory leaks and errors about receive ports and illegal arguments.
// TODO: Can get rid of this wrapper and call it in a full isolate instead of compute() if we want more control over this
Future<String> _cancelTransactionWrapper(Tuple2<String, String> data) async {
  // assuming this returns an empty string on success
  // or an error message string on failure
  return cancelTransaction(data.item1, data.item2);
}

Future<String> _deleteWalletWrapper(Tuple2<String, String> data) async {
  return deleteWallet(data.item1, data.item2);
}

Future<String> deleteEpicWallet({
  required String walletId,
  required FlutterSecureStorageInterface secureStore,
}) async {
  String? config = await secureStore.read(key: '${walletId}_config');
  if (Platform.isIOS) {
    Directory appDir = (await getApplicationDocumentsDirectory());
    if (Platform.isIOS) {
      appDir = (await getLibraryDirectory());
    }
    if (Platform.isLinux) {
      appDir = Directory("${appDir.path}/.epicmobile");
    }
    final path = "${appDir.path}/epicpay/epiccash";
    final String name = walletId;

    final walletDir = '$path/$name';
    var editConfig = jsonDecode(config as String);

    editConfig["wallet_dir"] = walletDir;
    config = jsonEncode(editConfig);
  }

  final wallet = await secureStore.read(key: '${walletId}_wallet');

  if (wallet == null) {
    return "Tried to delete non existent epic wallet file with walletId=$walletId";
  } else {
    try {
      return _deleteWalletWrapper(Tuple2(wallet, config!));
    } catch (e, s) {
      Logging.instance.log("$e\n$s", level: LogLevel.Error);
      return "deleteEpicWallet($walletId) failed...";
    }
  }
}

Future<String> _initWalletWrapper(
    Tuple4<String, String, String, String> data) async {
  final String initWalletStr =
      initWallet(data.item1, data.item2, data.item3, data.item4);
  return initWalletStr;
}

Future<String> _initGetAddressInfoWrapper(
    Tuple3<String, int, String> data) async {
  String walletAddress = getAddressInfo(data.item1, data.item2, data.item3);
  return walletAddress;
}

Future<String> _walletMnemonicWrapper(int throwaway) async {
  final String mnemonic = walletMnemonic();
  return mnemonic;
}

class EpicCashWallet extends CoinServiceAPI {
  static const integrationTestFlag =
      bool.fromEnvironment("IS_INTEGRATION_TEST");
  final m = Mutex();
  final syncMutex = Mutex();

  final _prefs = Prefs.instance;

  NodeModel? _epicNode;

  EpicCashWallet(
      {required String walletId,
      required String walletName,
      required Coin coin,
      PriceAPI? priceAPI,
      FlutterSecureStorageInterface? secureStore}) {
    _walletId = walletId;
    _walletName = walletName;
    _coin = coin;

    _priceAPI = priceAPI ?? PriceAPI(Client());
    _secureStore =
        secureStore ?? const SecureStorageWrapper(FlutterSecureStorage());

    Logging.instance.log("$walletName isolate length: ${isolates.length}",
        level: LogLevel.Info);
    for (final isolate in isolates.values) {
      isolate.kill(priority: Isolate.immediate);
    }
    isolates.clear();
  }

  @override
  Future<void> updateNode(bool shouldRefresh) async {
    _epicNode = NodeService().getPrimaryNodeFor(coin: coin) ??
        DefaultNodes.getNodeFor(coin);
    // TODO notify ui/ fire event for node changed?

    String stringConfig = await getConfig();
    await _secureStore.write(key: '${_walletId}_config', value: stringConfig);

    if (shouldRefresh) {
      unawaited(refresh());
    }
  }

  @override
  set isFavorite(bool markFavorite) {
    DB.instance.put<dynamic>(
        boxName: walletId, key: "isFavorite", value: markFavorite);
  }

  @override
  bool get isFavorite {
    try {
      return DB.instance.get<dynamic>(boxName: walletId, key: "isFavorite")
          as bool;
    } catch (e, s) {
      Logging.instance.log(
          "isFavorite fetch failed (returning false by default): $e\n$s",
          level: LogLevel.Error);
      return false;
    }
  }

  @override
  Future<List<String>> get allOwnAddresses =>
      _allOwnAddresses ??= _fetchAllOwnAddresses();
  Future<List<String>>? _allOwnAddresses;

  Future<List<String>> _fetchAllOwnAddresses() async {
    List<String> addresses = [];
    final ownAddress = await currentReceivingAddress;
    addresses.add(ownAddress);
    return addresses;
  }

  late ReceivePort receivePort;

  Future<String> startSync() async {
    Logging.instance.log("request start sync", level: LogLevel.Info);
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');
    const int refreshFromNode = 1;
    if (!syncMutex.isLocked) {
      await epiccash.LibEpiccash.getWalletBalances(
        wallet: wallet!,
        refreshFromNode: refreshFromNode,
        minimumConfirmations: 10,
      );
    } else {
      Logging.instance.log("request start sync denied", level: LogLevel.Info);
    }
    return "";
  }

  Future<
      ({
        double awaitingFinalization,
        double pending,
        double spendable,
        double total
      })> allWalletBalances() async {
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');
    const refreshFromNode = 0;

    return await epiccash.LibEpiccash.getWalletBalances(
      wallet: wallet!,
      refreshFromNode: refreshFromNode,
      minimumConfirmations: MINIMUM_CONFIRMATIONS,
    );
  }

  @override
  Future<Decimal> get availableBalance async {
    var walletBalances = await allWalletBalances();
    final double spendable =
        walletBalances.spendable;
    return Decimal.parse(spendable.toString());
  }

  @override
  // TODO: implement balanceMinusMaxFee
  Future<Decimal> get balanceMinusMaxFee => throw UnimplementedError();

  Timer? timer;
  int? timerPeriod;
  late Coin _coin;

  @override
  Coin get coin => _coin;

  late FlutterSecureStorageInterface _secureStore;

  late PriceAPI _priceAPI;

  /// returns an empty String on success, error message on failure
  Future<String> cancelPendingTransaction(String tx_slate_id) async {
    final String wallet =
        (await _secureStore.read(key: '${_walletId}_wallet'))!;

    String? result;
    await m.protect(() async {
      result = await compute(
        _cancelTransactionWrapper,
        Tuple2(
          wallet,
          tx_slate_id,
        ),
      );
    });
    return result!;
  }

  Future<bool> testEpicboxServer(String host, int port) async {
    final websocketConnectionUri = 'wss://$host:$port';
    const connectionOptions = SocketConnectionOptions(
      pingIntervalMs: 3000,
      timeoutConnectionMs: 4000,

      /// see ping/pong messages in [logEventStream] stream
      skipPingMessages: true,

      /// Set this attribute to `true` if do not need any ping/pong
      /// messages and ping measurement. Default is `false`
      pingRestrictionForce: true,
    );

    final IMessageProcessor<String, String> textSocketProcessor =
        SocketSimpleTextProcessor();
    final textSocketHandler = IWebSocketHandler<String, String>.createClient(
      websocketConnectionUri,
      textSocketProcessor,
      connectionOptions: connectionOptions,
    );

    // Listening to server responses:
    bool isConnected = true;
    textSocketHandler.incomingMessagesStream.listen((inMsg) {
      Logging.instance.log(
          'Epic Box server test webSocket message from server $host:$port: "$inMsg"',
          level: LogLevel.Info);

      if (inMsg.contains("Challenge")) {
        // Successful response, close socket
        Logging.instance.log('Epic Box server $host:$port test succeeded',
            level: LogLevel.Info);

        _isEpicBoxConnected = isConnected;
        GlobalEventBus.instance.fire(
          EpicBoxStatusChangedEvent(
            isConnected
                ? EpicBoxStatus.connected
                : EpicBoxStatus.unableToConnect,
            walletId,
          ),
        );

        // Disconnect from server:
        textSocketHandler.disconnect('manual disconnect');
        // Disposing webSocket:
        textSocketHandler.close();
      } /* else if(inMsg.contains("InvalidRequest")) {
        // Handle when many InvalidRequest responses occur
      }*/
    });

    // Connecting to server:
    final isTextSocketConnected = await textSocketHandler.connect();
    if (!isTextSocketConnected) {
      Logging.instance.log(
          'Epic Box server test failed: server $host:$port unable to connect',
          level: LogLevel.Warning);
      isConnected = false;
      _isEpicBoxConnected = false;
      GlobalEventBus.instance.fire(
        EpicBoxStatusChangedEvent(
          EpicBoxStatus.unableToConnect,
          walletId,
        ),
      );
    }

    return isConnected;
  }

  @override
  Future<String> confirmSend({required Map<String, dynamic> txData}) async {
    try {
      EpicBoxConfigModel epicboxConfig = await getEpicBoxConfig();
      final wallet = await _secureStore.read(key: '${_walletId}_wallet');

      // TODO determine whether it is worth sending change to a change address.
      String slateId;
      String receiverAddress = txData['addresss'] as String;

      if (!receiverAddress.startsWith("http://") ||
          !receiverAddress.startsWith("https://")) {
        bool isEpicboxConnected = await testEpicboxServer(
            epicboxConfig.host, epicboxConfig.port ?? 443);
        if (!isEpicboxConnected) {
          throw Exception("Failed to send TX : Unable to reach epicbox server");
        }
      }

      ({String commitId, String slateId}) transaction;

      if (receiverAddress.startsWith("http://") ||
          receiverAddress.startsWith("https://")) {
        transaction = await epiccash.LibEpiccash.txHttpSend(
          wallet: wallet!,
          selectionStrategyIsAll: 0,
          minimumConfirmations: MINIMUM_CONFIRMATIONS,
          message: txData['onChainNote'] as String,
          amount: (txData['recipientAmt'] as Amount).raw.toInt(),
          address: txData['addresss'] as String,
        );
      } else {
        transaction = await epiccash.LibEpiccash.createTransaction(
          wallet: wallet!,
          amount: (txData['recipientAmt'] as Amount).raw.toInt(),
          address: txData['addresss'] as String,
          secretKeyIndex: 0,
          epicboxConfig: epicboxConfig.toString(),
          minimumConfirmations: MINIMUM_CONFIRMATIONS,
          note: txData['onChainNote'] as String,
        );
      }

      Map<String, String> txAddressInfo = {};
      txAddressInfo['from'] = await currentReceivingAddress;
      txAddressInfo['to'] = txData['addresss'] as String;
      await putSendToAddresses(transaction, txAddressInfo);

      slateId = transaction.slateId;
      return slateId;
    } catch (e, s) {
      Logging.instance.log("Error sending $e - $s", level: LogLevel.Error);
      rethrow;
    }
  }

  @override
  Future<String> get currentReceivingAddress async {
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');

    EpicBoxConfigModel epicboxConfig = await getEpicBoxConfig();

    String? walletAddress = DB.instance.get<dynamic>(
      boxName: walletId,
      key: "currentReceivingAddress",
    ) as String?;
    // if address doesn't exist in Hive, fetch from rust and store it
    if (walletAddress == null) {
      await m.protect(() async {
        walletAddress = await compute(
          _initGetAddressInfoWrapper,
          Tuple3(wallet!, 0, epicboxConfig.toString()),
        );
      });

      await DB.instance.put<dynamic>(
        boxName: walletId,
        key: "currentReceivingAddress",
        value: walletAddress,
      );

      // Logging.instance.log(
      //   "WALLET ADDRESS FROM RUST IS $walletAddress",
      //   level: LogLevel.Info,
      // );
    } else if (!walletAddress.endsWith(epicboxConfig.host)) {
      if (walletAddress.contains("@")) {
        walletAddress = walletAddress.split("@").first;
      }

      // append current epic box domain
      walletAddress += "@${epicboxConfig.host}";

      await DB.instance.put<dynamic>(
        boxName: walletId,
        key: "currentReceivingAddress",
        value: walletAddress,
      );
    }
    // Logging.instance.log(
    //   "WALLET_ADDRESS_IS $walletAddress",
    //   level: LogLevel.Info,
    // );

    return walletAddress!;
  }
  //     _currentReceivingAddress ??= _getCurrentAddressForChain(0);
  // Future<String>? _currentReceivingAddress;

  @override
  Future<void> exit() async {
    _hasCalledExit = true;
    timer?.cancel();
    timer = null;
    stopNetworkAlivePinging();
    for (final isolate in isolates.values) {
      isolate.kill(priority: Isolate.immediate);
    }
    isolates.clear();
    Logging.instance.log("EpicCash_wallet exit finished", level: LogLevel.Info);
  }

  bool _hasCalledExit = false;

  @override
  bool get hasCalledExit => _hasCalledExit;

  Future<FeeObject> _getFees() async {
    // TODO: implement _getFees
    return FeeObject(
        numberOfBlocksFast: 10,
        numberOfBlocksAverage: 10,
        numberOfBlocksSlow: 10,
        fast: 1,
        medium: 1,
        slow: 1);
  }

  @override
  Future<FeeObject> get fees => _feeObject ??= _getFees();
  Future<FeeObject>? _feeObject;

  @override
  Future<void> fullRescan(
    int maxUnusedAddressGap,
    int maxNumberOfIndexesToCheck,
  ) async {
    refreshMutex = true;
    try {
      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.syncing,
          walletId,
          coin,
        ),
      );

      await DB.instance.put<dynamic>(
          boxName: walletId,
          key: "lastScannedBlock",
          value: await getRestoreHeight());

      await _startScans();

      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.synced,
          walletId,
          coin,
        ),
      );
    } catch (e, s) {
      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.unableToSync,
          walletId,
          coin,
        ),
      );

      Logging.instance.log(
        "Exception rethrown from fullRescan(): $e\n$s",
        level: LogLevel.Error,
        printFullLength: true,
      );
      rethrow;
    } finally {
      refreshMutex = false;
    }
  }

  @override
  Future<void> initializeExisting() async {
    Logging.instance.log("Opening existing ${coin.prettyName} wallet",
        level: LogLevel.Info);

    final config = await getRealConfig();
    final password = await _secureStore.read(key: '${_walletId}_password');

    final walletOpen = openWallet(config, password!);
    await _secureStore.write(key: '${_walletId}_wallet', value: walletOpen);

    if ((DB.instance.get<dynamic>(boxName: walletId, key: "id")) == null) {
      throw Exception(
          "Attempted to initialize an existing wallet using an unknown wallet ID!");
    }
    await _prefs.init();
    await updateNode(false);
    final data =
        DB.instance.get<dynamic>(boxName: walletId, key: "latest_tx_model")
            as TransactionData?;
    if (data != null) {
      _transactionData = Future(() => data);
      txCount = data.getAllTransactions().length;
    }
    // TODO: is there anything else that should be set up here whenever this wallet is first loaded again?
  }

  Timer? t;
  int _txCount = 0;

  set txCount(int value) {
    if (_txCount != value) {
      _txCount = value;
      GlobalEventBus.instance.fire(
        UpdatedInBackgroundEvent(
          "tx count changed",
          walletId,
        ),
      );
    }
  }

  @override
  int get txCount => _txCount;

  // TODO: make more robust estimate of date maybe using https://explorer.epic.tech/api-index
  int calculateRestoreHeightFrom({required DateTime date}) {
    int secondsSinceEpoch = date.millisecondsSinceEpoch ~/ 1000;
    const int epicCashFirstBlock = 1565370278;
    const double overestimateSecondsPerBlock = 61;
    int chosenSeconds = secondsSinceEpoch - epicCashFirstBlock;
    int approximateHeight = chosenSeconds ~/ overestimateSecondsPerBlock;
    debugPrint(
        "approximate height: $approximateHeight chosen_seconds: $chosenSeconds");
    int height = approximateHeight;
    if (height < 0) {
      height = 0;
    }
    return height;
  }

  @override
  Future<void> initializeNew() async {
    await DB.instance.init();
    await _prefs.init();
    await updateNode(false);
    final mnemonic = await _getMnemonicList();
    final String mnemonicString = mnemonic.join(" ");

    final String password = generatePassword();
    String stringConfig = await getConfig();
    EpicBoxConfigModel epicboxConfig = await getEpicBoxConfig();

    await _secureStore.write(
        key: '${_walletId}_mnemonic', value: mnemonicString);
    await _secureStore.write(key: '${_walletId}_config', value: stringConfig);
    await _secureStore.write(key: '${_walletId}_password', value: password);
    Logging.instance.log("Saving ${_walletId}_epicboxConfig: $epicboxConfig",
        level: LogLevel.Info);
    await _secureStore.write(
        key: '${_walletId}_epicboxConfig', value: epicboxConfig.toString());

    String name = _walletId;

    await m.protect(() async {
      await compute(
        _initWalletWrapper,
        Tuple4(
          stringConfig,
          mnemonicString,
          password,
          name,
        ),
      );
    });

    //Open wallet
    final walletOpen = openWallet(stringConfig, password);
    await _secureStore.write(key: '${_walletId}_wallet', value: walletOpen);

    //Store Epic box address info
    await currentReceivingAddress;

    // subtract a couple days to ensure we have a buffer for SWB
    final bufferedCreateHeight = calculateRestoreHeightFrom(
        date: DateTime.now().subtract(const Duration(days: 2)));

    await DB.instance.put<dynamic>(
        boxName: walletId, key: "restoreHeight", value: bufferedCreateHeight);

    await DB.instance
        .put<dynamic>(boxName: walletId, key: "id", value: _walletId);
    await DB.instance.put<dynamic>(
        boxName: walletId, key: 'receivingAddresses', value: ["0"]);
    await DB.instance
        .put<dynamic>(boxName: walletId, key: "receivingIndex", value: 0);
    await DB.instance
        .put<dynamic>(boxName: walletId, key: "changeIndex", value: 0);
    await DB.instance.put<dynamic>(
      boxName: walletId,
      key: 'blocked_tx_hashes',
      value: ["0xdefault"],
    ); // A list of transaction hashes to represent frozen utxos in wallet
    // initialize address book entries
    await DB.instance.put<dynamic>(
        boxName: walletId,
        key: 'addressBookEntries',
        value: <String, String>{});
    await DB.instance
        .put<dynamic>(boxName: walletId, key: "isFavorite", value: false);
    //Store wallet address in hive
    await currentReceivingAddress;
  }

  bool refreshMutex = false;

  @override
  bool get isRefreshing => refreshMutex;

  @override
  // TODO: implement maxFee
  Future<int> get maxFee => throw UnimplementedError();

  Future<List<String>> _getMnemonicList() async {
    if ((await _secureStore.read(key: '${_walletId}_mnemonic')) != null) {
      final mnemonicString =
          await _secureStore.read(key: '${_walletId}_mnemonic');
      final List<String> data = mnemonicString!.split(' ');
      return data;
    } else {
      String? mnemonicString;
      await m.protect(() async {
        mnemonicString = await compute(
          _walletMnemonicWrapper,
          0,
        );
      });
      await _secureStore.write(
          key: '${_walletId}_mnemonic', value: mnemonicString);
      final List<String> data = mnemonicString!.split(' ');
      return data;
    }
  }

  @override
  Future<List<String>> get mnemonic => _getMnemonicList();

  @override
  Future<Decimal> get pendingBalance async {
    var walletBalances = await allWalletBalances();
    final double pending =
        walletBalances.awaitingFinalization;
    return Decimal.parse(pending.toString());
  }

  @override
  Future<Map<String, dynamic>> prepareSend(
      {required String address,
      required int satoshiAmount,
      Map<String, dynamic>? args}) async {
    try {
      int realfee = await nativeFee(satoshiAmount);

      final available = await availableBalance;
      final availableSat = Format.decimalAmountToSatoshis(available);
      if (availableSat == satoshiAmount) {
        satoshiAmount = availableSat - realfee;
      }

      Map<String, dynamic> txData = {
        "fee": realfee,
        "addresss": address,
        "recipientAmt": satoshiAmount,
      };

      Logging.instance.log("prepare send: $txData", level: LogLevel.Info);
      return txData;
    } catch (e, s) {
      Logging.instance.log("Error getting fees $e - $s", level: LogLevel.Error);
      rethrow;
    }
  }

  Future<int> nativeFee(int satoshiAmount,
      {bool ifErrorEstimateFee = false}) async {
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');

    try {
      final available = await availableBalance;
      final availableSat = Format.decimalAmountToSatoshis(available);

      var transactionFees = await epiccash.LibEpiccash.getTransactionFees(
        wallet: wallet!,
        amount: satoshiAmount,
        minimumConfirmations: MINIMUM_CONFIRMATIONS,
        available: availableSat,
      );

      //TODO: first problem
      int realfee = 0;
      try {
        realfee =
            (Decimal.parse(transactionFees.fee.toString())).toBigInt().toInt();
      } catch (e, s) {
        debugPrint("$e $s");
      }

      return realfee;
    } catch (e, s) {
      Logging.instance.log("Error getting fees $e - $s", level: LogLevel.Error);
      rethrow;
    }
  }

  Future<String> currentWalletDirPath() async {
    Directory appDir = (await getApplicationDocumentsDirectory());
    if (Platform.isIOS) {
      appDir = (await getLibraryDirectory());
    }
    if (Platform.isLinux) {
      appDir = Directory("${appDir.path}/.epicmobile");
    }
    final path = "${appDir.path}/epicpay/epiccash";
    final String name = _walletId.trim();
    return '$path/$name';
  }

  Future<String> getConfig() async {
    if (_epicNode == null) {
      await updateNode(false);
    }
    final NodeModel node = _epicNode!;

    final String nodeAddress = node.host;
    int port = node.port;

    Uri uri = Uri.parse(nodeAddress);
    uri = uri.replace(port: port);

    final String nodeApiAddress = uri.toString();
    final walletDir = await currentWalletDirPath();

    final Map<String, dynamic> config = {};
    config["wallet_dir"] = walletDir;
    config["check_node_api_http_addr"] = nodeApiAddress;
    config["chain"] = "mainnet";
    config["account"] = "default";
    config["api_listen_port"] = port;
    config["api_listen_interface"] =
        nodeApiAddress.replaceFirst(uri.scheme, "");
    String stringConfig = json.encode(config);
    return stringConfig;
  }

  Future<EpicBoxConfigModel> getEpicBoxConfig() async {
    EpicBoxConfigModel? _epicBoxConfig;
    // read epicbox config from secure store
    String? storedConfig =
        await _secureStore.read(key: '${_walletId}_epicboxConfig');

    if (storedConfig == null) {
      // if no config stored, use the default epicbox server as config, this is on first creation/ restore
      _epicBoxConfig =
          EpicBoxConfigModel.fromServer(DefaultEpicBoxes.defaultEpicBoxServer);
      //Update secureStore
      await _secureStore.write(
          key: '${_walletId}_epicboxConfig', value: _epicBoxConfig.toString());
    } else {
      // if a config is stored, test it
      _epicBoxConfig = EpicBoxConfigModel.fromString(
          storedConfig); // fromString handles checking old config formats
    }
    //Now check if secureStoreConfig is the same as the Hive one
    EpicBoxServerModel? _epicBox = DB.instance.get<EpicBoxServerModel>(
        boxName: DB.boxNamePrimaryEpicBox, key: 'primary');

    if (_epicBox != null) {
      if (_epicBoxConfig.host != _epicBox?.host) {
        _epicBoxConfig = EpicBoxConfigModel.fromServer(_epicBox!);
        await _secureStore.write(
            key: '${_walletId}_epicboxConfig',
            value: _epicBoxConfig.toString());
      }
    }

    try {
      bool isEpicboxConnected = await testEpicboxServer(
        _epicBoxConfig.host,
        _epicBoxConfig.port ?? 443,
      );

      if (!isEpicboxConnected) {
        Logging.instance.log(
          "Error in getEpicBoxConfig (not connected to epicbox server)",
          level: LogLevel.Error,
        );
      }
    } catch (e, s) {
      rethrow;
    }

    return _epicBoxConfig;
  }

  // Used to update receiving address when updating epic box config
  // Because we don't generate a new address for epic but we do change the
  // address based on the epicbox host/domain/URL we must force an update here
  Future<bool> updateEpicBox() async {
    try {
      await currentReceivingAddress;
      return true;
    } catch (e, s) {
      Logging.instance.log("$e, $s", level: LogLevel.Error);
      throw Exception("Error in updateEpicBox (_getCurrentAddressForChain)");
    }
  }

  Future<String> getRealConfig() async {
    String? config = await _secureStore.read(key: '${_walletId}_config');
    if (Platform.isIOS) {
      final walletDir = await currentWalletDirPath();
      var editConfig = jsonDecode(config as String);

      editConfig["wallet_dir"] = walletDir;
      config = jsonEncode(editConfig);
    }
    return config!;
  }

  Future<void> _startScans() async {
    try {
      //First stop the current listener
      epiccash.LibEpiccash.stopEpicboxListener();
      final wallet = await _secureStore.read(key: '${_walletId}_wallet');

      // max number of blocks to scan per loop iteration
      const scanChunkSize = 10000;

      // force firing of scan progress event
      await getSyncPercent;

      // fetch current chain height and last scanned block (should be the
      // restore height if full rescan or a wallet restore)
      int chainHeight = await this.chainHeight;
      int lastScannedBlock = DB.instance.get<dynamic>(
            boxName: walletId,
            key: 'lastScannedBlock',
          ) as int? ??
          await getRestoreHeight();

      // loop while scanning in chain in chunks (of blocks?)
      while (lastScannedBlock < chainHeight) {
        Logging.instance.log(
          "chainHeight: $chainHeight, lastScannedBlock: $lastScannedBlock",
          level: LogLevel.Info,
        );

        int nextScannedBlock = await epiccash.LibEpiccash.scanOutputs(
          wallet: wallet!,
          startHeight: lastScannedBlock,
          numberOfBlocks: scanChunkSize,
        );

        // update local cache
        await DB.instance.put<dynamic>(
          boxName: walletId,
          key: "lastScannedBlock",
          value: nextScannedBlock,
        );

        // force firing of scan progress event
        await getSyncPercent;

        // update while loop condition variables
        chainHeight = await this.chainHeight;
        lastScannedBlock = nextScannedBlock;
      }

      Logging.instance.log(
        "_startScans successfully at the tip",
        level: LogLevel.Info,
      );
      //Once scanner completes restart listener
      await listenToEpicbox();
    } catch (e, s) {
      Logging.instance.log(
        "_startScans failed: $e\n$s",
        level: LogLevel.Error,
      );
      rethrow;
    }
  }

  Future<double> get getSyncPercent async {
    int lastScannedBlock = DB.instance
            .get<dynamic>(boxName: walletId, key: 'lastScannedBlock') as int? ??
        0;
    final _chainHeight = await chainHeight;
    double restorePercent = lastScannedBlock / _chainHeight;
    GlobalEventBus.instance
        .fire(RefreshPercentChangedEvent(highestPercent, walletId));
    if (restorePercent > highestPercent) {
      highestPercent = restorePercent;
    }

    final int blocksRemaining = _chainHeight - lastScannedBlock;
    GlobalEventBus.instance
        .fire(BlocksRemainingEvent(blocksRemaining, walletId));

    return restorePercent < 0 ? 0.0 : restorePercent;
  }

  double highestPercent = 0;

  @override
  Future<void> recoverFromMnemonic(
      {required String mnemonic,
      required int maxUnusedAddressGap,
      required int maxNumberOfIndexesToCheck,
      required int height}) async {
    try {
      await _prefs.init();
      await DB.instance.init();
      await updateNode(false);
      final String password = generatePassword();

      String stringConfig = await getConfig();
      EpicBoxConfigModel epicboxConfig = await getEpicBoxConfig();
      final String name = _walletName.trim();

      await _secureStore.write(key: '${_walletId}_mnemonic', value: mnemonic);
      await _secureStore.write(key: '${_walletId}_config', value: stringConfig);
      await _secureStore.write(key: '${_walletId}_password', value: password);
      Logging.instance.log("Saving ${_walletId}_epicboxConfig: $stringConfig",
          level: LogLevel.Info);
      await _secureStore.write(
          key: '${_walletId}_epicboxConfig', value: epicboxConfig.toString());

      await epiccash.LibEpiccash.recoverWallet(
        config: stringConfig,
        password: password,
        mnemonic: mnemonic,
        name: name,
      );

      await DB.instance
          .put<dynamic>(boxName: walletId, key: "restoreHeight", value: height);

      await DB.instance
          .put<dynamic>(boxName: walletId, key: "id", value: _walletId);
      await DB.instance.put<dynamic>(
          boxName: walletId, key: 'receivingAddresses', value: ["0"]);
      await DB.instance
          .put<dynamic>(boxName: walletId, key: "receivingIndex", value: 0);
      if (height >= 0) {
        await DB.instance.put<dynamic>(
            boxName: walletId, key: "restoreHeight", value: height);
      }
      await DB.instance
          .put<dynamic>(boxName: walletId, key: "changeIndex", value: 0);
      await DB.instance.put<dynamic>(
        boxName: walletId,
        key: 'blocked_tx_hashes',
        value: ["0xdefault"],
      ); // A list of transaction hashes to represent frozen utxos in wallet
      // initialize address book entries
      await DB.instance.put<dynamic>(
          boxName: walletId,
          key: 'addressBookEntries',
          value: <String, String>{});
      await DB.instance
          .put<dynamic>(boxName: walletId, key: "isFavorite", value: false);

      //Open Wallet
      final walletOpen = openWallet(stringConfig, password);
      await _secureStore.write(key: '${_walletId}_wallet', value: walletOpen);

      //Store Epic box address info
      await currentReceivingAddress;
    } catch (e, s) {
      Logging.instance
          .log("Error recovering wallet $e\n$s", level: LogLevel.Error);
      rethrow;
    }
  }

  Future<void> listenToEpicbox() async {
    Logging.instance.log("STARTING WALLET LISTENER ....", level: LogLevel.Info);
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');
    EpicBoxConfigModel epicboxConfig = await getEpicBoxConfig();
    epiccash.LibEpiccash.startEpicboxListener(
        wallet: wallet!, epicboxConfig: epicboxConfig.toString());
  }

  Future<int> getRestoreHeight() async {
    return DB.instance.get<dynamic>(boxName: walletId, key: "restoreHeight")
            as int? ??
        DB.instance.get<dynamic>(boxName: walletId, key: "creationHeight")
            as int;
  }

  Future<int> get chainHeight async {
    final config = await getRealConfig();
    int? latestHeight =
        await epiccash.LibEpiccash.getChainHeight(config: config);
    return latestHeight;
  }

  int get storedChainHeight {
    return DB.instance.get<dynamic>(boxName: walletId, key: "storedChainHeight")
            as int? ??
        0;
  }

  Future<void> updateStoredChainHeight({required int newHeight}) async {
    await DB.instance.put<dynamic>(
        boxName: walletId, key: "storedChainHeight", value: newHeight);
  }

  bool _shouldAutoSync = true;

  @override
  bool get shouldAutoSync => _shouldAutoSync;

  @override
  set shouldAutoSync(bool shouldAutoSync) {
    if (_shouldAutoSync != shouldAutoSync) {
      _shouldAutoSync = shouldAutoSync;
      if (!shouldAutoSync) {
        Logging.instance.log("Should autosync", level: LogLevel.Info);
        timer?.cancel();
        timer = null;
        stopNetworkAlivePinging();
      } else {
        startNetworkAlivePinging();
        refresh();
      }
    }
  }

  Future<int> setCurrentIndex() async {
    try {
      final int receivingIndex = DB.instance
          .get<dynamic>(boxName: walletId, key: "receivingIndex") as int;
      // TODO: go through pendingarray and processed array and choose the index
      //  of the last one that has not been processed, or the index after the one most recently processed;
      return receivingIndex;
    } catch (e, s) {
      Logging.instance.log("$e $s", level: LogLevel.Error);
      return 0;
    }
  }

  Future<Map<dynamic, dynamic>> getSlatesToCommits() async {
    try {
      var slatesToCommits =
          DB.instance.get<dynamic>(boxName: walletId, key: "slatesToCommits");
      if (slatesToCommits == null) {
        slatesToCommits = <dynamic, dynamic>{};
      } else {
        slatesToCommits = slatesToCommits as Map<dynamic, dynamic>;
      }
      return slatesToCommits as Map<dynamic, dynamic>;
    } catch (e, s) {
      Logging.instance.log("$e $s", level: LogLevel.Error);
      return {};
    }
  }

  Future<bool> putSendToAddresses(
      ({String slateId, String commitId}) slateData, Map<String, String> txAddressInfo) async {
    try {
      var slatesToCommits = await getSlatesToCommits();

      final from = txAddressInfo['from'];
      final to = txAddressInfo['to'];
      slatesToCommits[slateData.slateId] = {
        "commitId": slateData.commitId,
        "from": from,
        "to": to,
      };
      await DB.instance.put<dynamic>(
          boxName: walletId, key: "slatesToCommits", value: slatesToCommits);
      return true;
    } catch (e, s) {
      Logging.instance.log("$e $s", level: LogLevel.Error);
      return false;
    }
  }

  Future<bool> putSlatesToCommits(String slateMessage, String encoded) async {
    try {
      var slatesToCommits = await getSlatesToCommits();
      final slate = jsonDecode(slateMessage);
      final part1 = jsonDecode(slate[0] as String);
      final part2 = jsonDecode(slate[1] as String);
      final slateId = part1[0]['tx_slate_id'];
      if (slatesToCommits[slateId] != null &&
          (slatesToCommits[slateId] as Map).isNotEmpty) {
        // This happens when the sender receives the response.
        return true;
      }
      final commitId = part2['tx']['body']['outputs'][0]['commit'];

      final toFromInfoString = jsonDecode(encoded);
      final toFromInfo = jsonDecode(toFromInfoString[0] as String);
      final from = toFromInfo['from'];
      final to = toFromInfo['to'];
      slatesToCommits[slateId] = {
        "commitId": commitId,
        "from": from,
        "to": to,
      };
      await DB.instance.put<dynamic>(
          boxName: walletId, key: "slatesToCommits", value: slatesToCommits);
      return true;
    } catch (e, s) {
      Logging.instance.log("$e $s", level: LogLevel.Error);
      return false;
    }
  }

  /// Refreshes display data for the wallet
  @override
  Future<void> refresh() async {
    Logging.instance
        .log("$walletId $walletName Calling refresh", level: LogLevel.Info);
    if (refreshMutex) {
      Logging.instance.log("$walletId $walletName refreshMutex denied",
          level: LogLevel.Info);
      return;
    } else {
      refreshMutex = true;
    }

    try {
      _isConnected = true;
      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.syncing,
          walletId,
          coin,
        ),
      );

      if (!DB.instance
          .containsKey<dynamic>(boxName: walletId, key: "creationHeight")) {
        await DB.instance.put<dynamic>(
            boxName: walletId, key: "creationHeight", value: await chainHeight);
      }

      await _startScans();

      // TODO: Is this supposed to be awaited????
      startSync();

      GlobalEventBus.instance.fire(RefreshPercentChangedEvent(0.0, walletId));

      GlobalEventBus.instance.fire(RefreshPercentChangedEvent(0.1, walletId));

      final currentHeight = await chainHeight;
      const storedHeight = 1; //await storedChainHeight;

      Logging.instance.log("chain height in refresh function: $currentHeight",
          level: LogLevel.Info);
      Logging.instance.log("cached height in refresh function: $storedHeight",
          level: LogLevel.Info);

      // TODO: implement refresh
      // TODO: check if it needs a refresh and if so get all of the most recent data.
      if (currentHeight != storedHeight) {
        if (currentHeight != -1) {
          // -1 failed to fetch current height
          unawaited(updateStoredChainHeight(newHeight: currentHeight));
        }

        final newTxData = await _fetchTransactionData();
        GlobalEventBus.instance
            .fire(RefreshPercentChangedEvent(0.50, walletId));

        _transactionData = Future(() => newTxData);
        txCount = newTxData.getAllTransactions().length;

        GlobalEventBus.instance.fire(UpdatedInBackgroundEvent(
            "New data found in $walletName in background!", walletId));
      }

      GlobalEventBus.instance.fire(RefreshPercentChangedEvent(1.0, walletId));
      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.synced,
          walletId,
          coin,
        ),
      );
      refreshMutex = false;
      if (shouldAutoSync) {
        // if a timer hasn't been started or our refresh period pref has changed since the last one was started, start a new one
        if (timer == null || timerPeriod != _prefs.refreshPeriod) {
          // if a timer exists, cancel it before starting a new one
          if (timer != null) {
            timer!.cancel();
          }
          timer = Timer.periodic(Duration(seconds: _prefs.refreshPeriod ?? 60),
              (timer) async {
            Logging.instance.log(
                "Periodic refresh check for $walletId $walletName in object instance: $hashCode (${_prefs.refreshPeriod ?? 60}s)",
                level: LogLevel.Info);
            // chain height check currently broken
            // if ((await chainHeight) != (await storedChainHeight)) {
            if (await refreshIfThereIsNewData()) {
              await refresh();
              GlobalEventBus.instance.fire(UpdatedInBackgroundEvent(
                  "New data found in $walletId $walletName in background!",
                  walletId));
            }
          });
          // }
          // set timerPeriod helper var: if _prefs.refreshPeriod is changed and thus differs from this, we cancel the old timer and create a new one
          timerPeriod = _prefs.refreshPeriod ?? 60;
        }
      }
    } catch (error, strace) {
      refreshMutex = false;
      _isConnected = false;
      GlobalEventBus.instance.fire(
        NodeConnectionStatusChangedEvent(
          NodeConnectionStatus.disconnected,
          walletId,
          coin,
        ),
      );
      GlobalEventBus.instance.fire(
        WalletSyncStatusChangedEvent(
          WalletSyncStatus.unableToSync,
          walletId,
          coin,
        ),
      );
      Logging.instance.log(
          "Caught exception in refreshWalletData(): $error\n$strace",
          level: LogLevel.Warning);
    }
  }

  Future<bool> refreshIfThereIsNewData() async {
    if (_hasCalledExit) return false;
    // TODO returning true here signals this class to call refresh() after which it will fire an event that notifies the UI that new data has been fetched/found for this wallet
    return true;
    // TODO: do a quick check to see if there is any new data that would require a refresh
  }

  @override
  Future<String> send(
      {required String toAddress,
      required int amount,
      Map<String, String> args = const {}}) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Future<bool> testNetworkConnection() async {
    try {
      // force unwrap optional as we want connection test to fail if wallet
      // wasn't initialized or epicbox node was set to null
      return await testEpicNodeConnection(
            NodeFormData()
              ..host = _epicNode!.host
              ..useSSL = _epicNode!.useSSL
              ..port = _epicNode!.port,
          ) !=
          null;
    } catch (e, s) {
      Logging.instance.log("$e\n$s", level: LogLevel.Warning);
      return false;
    }
  }

  Timer? _networkAliveTimer;

  void startNetworkAlivePinging() {
    // call once on start right away
    _periodicPingCheck();

    // then periodically check
    _networkAliveTimer = Timer.periodic(
      Constants.networkAliveTimerDuration,
      (_) async {
        _periodicPingCheck();
      },
    );
  }

  void _periodicPingCheck() async {
    bool hasNetwork = await testNetworkConnection();
    _isConnected = hasNetwork;
    if (_isConnected != hasNetwork) {
      NodeConnectionStatus status = hasNetwork
          ? NodeConnectionStatus.connected
          : NodeConnectionStatus.disconnected;
      GlobalEventBus.instance
          .fire(NodeConnectionStatusChangedEvent(status, walletId, coin));
    }
  }

  void stopNetworkAlivePinging() {
    _networkAliveTimer?.cancel();
    _networkAliveTimer = null;
  }

  bool _isConnected = true;

  @override
  bool get isConnected => _isConnected;

  bool _isEpicBoxConnected = true;

  @override
  bool get isEpicBoxConnected => _isEpicBoxConnected;

  @override
  Future<Decimal> get totalBalance async {
    var walletBalances = await allWalletBalances();
    double total = walletBalances.total;
    double awaiting = walletBalances.awaitingFinalization;
    total = total + awaiting;
    return Decimal.parse(total.toString());
  }

  Future<TransactionData> _fetchTransactionData() async {
    final currentChainHeight = await chainHeight;
    final wallet = await _secureStore.read(key: '${_walletId}_wallet');
    const refreshFromNode = 0;
    var transactions = await epiccash.LibEpiccash.getTransactions(
        wallet: wallet!, refreshFromNode: refreshFromNode);

    final priceData =
        await _priceAPI.getPricesAnd24hChange(baseCurrency: _prefs.currency);
    Decimal currentPrice = priceData[coin]?.item1 ?? Decimal.zero;
    final List<Map<String, dynamic>> midSortedArray = [];

    final slatesToCommits = await getSlatesToCommits();

    for (var tx in transactions) {
      Logging.instance.log("tx: $tx", level: LogLevel.Info);
      final txHeight = tx.kernelLookupMinHeight ?? 0;
      // TODO: does "confirmed" mean finalized? If so please remove this todo
      final isConfirmed = tx.confirmed;

      // Logging.instance.log("Transactions listed below");
      // Logging.instance.log(jsonTransactions);
      int amt = 0;
      if (tx.txType == TransactionType.TxReceived ||
          tx.txType == TransactionType.TxReceivedCancelled) {
        amt = int.parse(tx.amountCredited);
      } else {
        int debit = int.parse(tx.amountDebited);
        int credit = int.parse(tx.amountCredited);
        int fee = int.parse((tx.fee ?? "0"));
        amt = debit - credit - fee;
      }
      final String worthNow =
          (currentPrice * Decimal.parse(amt.toString())).toStringAsFixed(2);

      DateTime dt = DateTime.parse(tx.creationTs);

      int? numberOfMessages = tx.messages?.messages.length;
      String? onChainNote = tx.messages?.messages[0].message;

      Map<String, dynamic> midSortedTx = {};
      midSortedTx["txType"] = (tx.txType == TransactionType.TxReceived ||
              tx.txType == TransactionType.TxReceivedCancelled)
          ? "Received"
          : "Sent";
      String? slateId = tx.txSlateId;
      String? address = slatesToCommits[slateId]
                  ?[midSortedTx["txType"] == "TxReceived" ? "from" : "to"]
              as String? ??
          "";
      String? commitId = slatesToCommits[slateId]?['commitId'] as String?;
      Logging.instance.log(
          "commitId: $commitId, slateId: $slateId, id: ${tx.id}",
          level: LogLevel.Info);

      bool isCancelled = tx.txType == TransactionType.TxSentCancelled ||
          tx.txType == TransactionType.TxReceivedCancelled;

      midSortedTx["slateId"] = slateId;
      midSortedTx["isCancelled"] = isCancelled;
      midSortedTx["txid"] = commitId ?? tx.id.toString();
      midSortedTx["confirmed_status"] = isConfirmed;
      midSortedTx["timestamp"] = (dt.millisecondsSinceEpoch ~/ 1000);
      midSortedTx["amount"] = amt;
      midSortedTx["worthNow"] = worthNow;
      midSortedTx["worthAtBlockTimestamp"] = worthNow;
      midSortedTx["fees"] = (tx.fee == "null") ? 0 : int.parse(tx.fee!);
      midSortedTx["address"] =
          ""; // for this when you send a transaction you will just need to save in a hashmap in hive with the key being the txid, and the value being the address it was sent to. then you can look this value up right here in your hashmap.
      midSortedTx["address"] = address;
      midSortedTx["height"] = txHeight;
      int confirmations = 0;
      try {
        confirmations = currentChainHeight - txHeight;
      } catch (e, s) {
        debugPrint("$e $s");
      }
      midSortedTx["confirmations"] = confirmations;

      midSortedTx["inputSize"] = tx.numOutputs;
      midSortedTx["outputSize"] = tx.numOutputs;
      midSortedTx["aliens"] = <dynamic>[];
      midSortedTx["inputs"] = <dynamic>[];
      midSortedTx["outputs"] = <dynamic>[];
      midSortedTx["tx_slate_id"] = tx.txSlateId;
      midSortedTx["key_id"] = tx.parentKeyId;
      midSortedTx["otherData"] = tx.id.toString();
      midSortedTx["numberOfMessages"] = numberOfMessages;
      midSortedTx["note"] = onChainNote;

      midSortedArray.add(midSortedTx);
    }

    midSortedArray
        .sort((a, b) => (b["timestamp"] as int) - (a["timestamp"] as int));

    final Map<String, dynamic> result = {"dateTimeChunks": <dynamic>[]};
    final dateArray = <dynamic>[];

    for (int i = 0; i < midSortedArray.length; i++) {
      final txObject = midSortedArray[i];
      final date = extractDateFromTimestamp(txObject["timestamp"] as int);

      final txTimeArray = [txObject["timestamp"], date];

      if (dateArray.contains(txTimeArray[1])) {
        result["dateTimeChunks"].forEach((dynamic chunk) {
          if (extractDateFromTimestamp(chunk["timestamp"] as int) ==
              txTimeArray[1]) {
            if (chunk["transactions"] == null) {
              chunk["transactions"] = <Map<String, dynamic>>[];
            }
            chunk["transactions"].add(txObject);
          }
        });
      } else {
        dateArray.add(txTimeArray[1]);

        final chunk = {
          "timestamp": txTimeArray[0],
          "transactions": [txObject],
        };

        // result["dateTimeChunks"].
        result["dateTimeChunks"].add(chunk);
      }
    }
    final transactionsMap =
        TransactionData.fromJson(result).getAllTransactions();

    final txModel = TransactionData.fromMap(transactionsMap);

    await DB.instance.put<dynamic>(
        boxName: walletId, key: 'latest_tx_model', value: txModel);

    return txModel;
  }

  @override
  Future<TransactionData> get transactionData =>
      _transactionData ??= _fetchTransactionData();
  Future<TransactionData>? _transactionData;

  // not used in epic
  TransactionData? cachedTxData;

  @override
  Future<void> updateSentCachedTxData(Map<String, dynamic> txData) async {
    // not used in epic
  }

  @override
  Future<List<UtxoObject>> get unspentOutputs => throw UnimplementedError();

  @override
  bool validateAddress(String address) {
    //Invalid address that contains HTTP and epicbox domain
    if ((address.startsWith("http://") || address.startsWith("https://")) &&
        address.contains("@")) {
      return false;
    }
    if (address.startsWith("http://") || address.startsWith("https://")) {
      if (Uri.tryParse(address) != null) {
        return true;
      }
    }

    String validate = validateSendAddress(address);
    if (int.parse(validate) == 1) {
      if (address.contains("@")) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  @override
  String get walletId => _walletId;
  late String _walletId;

  @override
  String get walletName => _walletName;
  late String _walletName;

  @override
  set walletName(String newName) => _walletName = newName;

  @override
  void Function(bool)? get onIsActiveWalletChanged => (isActive) async {
        timer?.cancel();
        timer = null;
        if (isActive) {
          unawaited(startSync());
        } else {
          for (final isolate in isolates.values) {
            isolate.kill(priority: Isolate.immediate);
          }
          isolates.clear();
        }
        this.isActive = isActive;
      };

  bool isActive = false;

  @override
  Future<int> estimateFeeFor(int satoshiAmount, int feeRate) async {
    int currentFee = await nativeFee(satoshiAmount, ifErrorEstimateFee: true);
    // TODO: implement this
    return currentFee;
  }
}
