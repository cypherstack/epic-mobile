import 'package:decimal/decimal.dart';
import 'package:epicpay/electrumx_rpc/electrumx.dart';
import 'package:epicpay/models/models.dart';
import 'package:epicpay/models/node_model.dart';
import 'package:epicpay/services/coins/epiccash/epiccash_wallet.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:epicpay/utilities/prefs.dart';

abstract class CoinServiceAPI {
  CoinServiceAPI();

  factory CoinServiceAPI.from(
    Coin coin,
    String walletId,
    String walletName,
    NodeModel node,
    Prefs prefs,
    List<NodeModel> failovers,
  ) {
    final electrumxNode = ElectrumXNode(
      address: node.host,
      port: node.port,
      name: node.name,
      id: node.id,
      useSSL: node.useSSL,
    );

    switch (coin) {
      case Coin.epicCash:
        return EpicCashWallet(
          walletId: walletId,
          walletName: walletName,
          coin: coin,
          // tracker: tracker,
        );
    }
  }

  Coin get coin;
  bool get isRefreshing;
  bool get shouldAutoSync;
  set shouldAutoSync(bool shouldAutoSync);
  bool get isFavorite;
  set isFavorite(bool markFavorite);
  int get txCount;

  Future<Map<String, dynamic>> prepareSend({
    required String address,
    required int satoshiAmount,
    Map<String, dynamic>? args,
  });

  Future<String> confirmSend({required Map<String, dynamic> txData});

  /// create and submit tx to network
  ///
  /// Returns the txid of the sent tx
  /// will throw exceptions on failure
  Future<String> send(
      {required String toAddress,
      required int amount,
      Map<String, String> args});

  Future<FeeObject> get fees;
  Future<int> get maxFee;

  Future<String> get currentReceivingAddress;
  // Future<String> get currentLegacyReceivingAddress;

  Future<Decimal> get availableBalance;
  Future<Decimal> get pendingBalance;
  Future<Decimal> get totalBalance;
  Future<Decimal> get balanceMinusMaxFee;

  Future<List<String>> get allOwnAddresses;

  Future<TransactionData> get transactionData;
  Future<List<UtxoObject>> get unspentOutputs;

  Future<void> refresh();

  Future<void> updateNode(bool shouldRefresh);

  // setter for updating on rename
  set walletName(String newName);

  String get walletName;
  String get walletId;

  bool validateAddress(String address);

  Future<List<String>> get mnemonic;

  Future<bool> testNetworkConnection();

  Future<void> recoverFromMnemonic({
    required String mnemonic,
    required int maxUnusedAddressGap,
    required int maxNumberOfIndexesToCheck,
    required int height,
  });

  Future<void> initializeNew();
  Future<void> initializeExisting();

  Future<void> exit();
  bool get hasCalledExit;

  Future<void> fullRescan(
      int maxUnusedAddressGap, int maxNumberOfIndexesToCheck);

  void Function(bool isActive)? onIsActiveWalletChanged;

  bool get isConnected;
  bool get isEpicBoxConnected;

  Future<int> estimateFeeFor(int satoshiAmount, int feeRate);

  // used for electrumx coins
  Future<void> updateSentCachedTxData(Map<String, dynamic> txData);
}
