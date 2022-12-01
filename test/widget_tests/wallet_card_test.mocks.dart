// Mocks generated by Mockito 5.3.2 from annotations
// in stackwallet/test/widget_tests/wallet_card_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i14;
import 'dart:ui' as _i16;

import 'package:decimal/decimal.dart' as _i9;
import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:epicmobile/electrumx_rpc/cached_electrumx.dart' as _i11;
import 'package:epicmobile/electrumx_rpc/electrumx.dart' as _i10;
import 'package:epicmobile/models/models.dart' as _i8;
import 'package:epicmobile/services/coins/bitcoin/bitcoin_wallet.dart' as _i17;
import 'package:epicmobile/services/coins/manager.dart' as _i6;
import 'package:epicmobile/services/locale_service.dart' as _i18;
import 'package:epicmobile/services/node_service.dart' as _i3;
import 'package:epicmobile/services/transaction_notification_tracker.dart'
    as _i7;
import 'package:epicmobile/services/wallets.dart' as _i12;
import 'package:epicmobile/services/wallets_service.dart' as _i2;
import 'package:epicmobile/utilities/enums/coin_enum.dart' as _i13;
import 'package:epicmobile/utilities/prefs.dart' as _i15;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWalletsService_0 extends _i1.SmartFake
    implements _i2.WalletsService {
  _FakeWalletsService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNodeService_1 extends _i1.SmartFake implements _i3.NodeService {
  _FakeNodeService_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeChangeNotifierProvider_2<Notifier extends _i4.ChangeNotifier?>
    extends _i1.SmartFake implements _i5.ChangeNotifierProvider<Notifier> {
  _FakeChangeNotifierProvider_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeManager_3 extends _i1.SmartFake implements _i6.Manager {
  _FakeManager_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTransactionNotificationTracker_4 extends _i1.SmartFake
    implements _i7.TransactionNotificationTracker {
  _FakeTransactionNotificationTracker_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUtxoData_5 extends _i1.SmartFake implements _i8.UtxoData {
  _FakeUtxoData_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDecimal_6 extends _i1.SmartFake implements _i9.Decimal {
  _FakeDecimal_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFeeObject_7 extends _i1.SmartFake implements _i8.FeeObject {
  _FakeFeeObject_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTransactionData_8 extends _i1.SmartFake
    implements _i8.TransactionData {
  _FakeTransactionData_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeElectrumX_9 extends _i1.SmartFake implements _i10.ElectrumX {
  _FakeElectrumX_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCachedElectrumX_10 extends _i1.SmartFake
    implements _i11.CachedElectrumX {
  _FakeCachedElectrumX_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeElectrumXNode_11 extends _i1.SmartFake
    implements _i10.ElectrumXNode {
  _FakeElectrumXNode_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Wallets].
///
/// See the documentation for Mockito's code generation for more information.
class MockWallets extends _i1.Mock implements _i12.Wallets {
  MockWallets() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WalletsService get walletsService => (super.noSuchMethod(
        Invocation.getter(#walletsService),
        returnValue: _FakeWalletsService_0(
          this,
          Invocation.getter(#walletsService),
        ),
      ) as _i2.WalletsService);
  @override
  set walletsService(_i2.WalletsService? _walletsService) => super.noSuchMethod(
        Invocation.setter(
          #walletsService,
          _walletsService,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.NodeService get nodeService => (super.noSuchMethod(
        Invocation.getter(#nodeService),
        returnValue: _FakeNodeService_1(
          this,
          Invocation.getter(#nodeService),
        ),
      ) as _i3.NodeService);
  @override
  set nodeService(_i3.NodeService? _nodeService) => super.noSuchMethod(
        Invocation.setter(
          #nodeService,
          _nodeService,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasWallets => (super.noSuchMethod(
        Invocation.getter(#hasWallets),
        returnValue: false,
      ) as bool);
  @override
  List<_i5.ChangeNotifierProvider<_i6.Manager>> get managerProviders =>
      (super.noSuchMethod(
        Invocation.getter(#managerProviders),
        returnValue: <_i5.ChangeNotifierProvider<_i6.Manager>>[],
      ) as List<_i5.ChangeNotifierProvider<_i6.Manager>>);
  @override
  List<_i6.Manager> get managers => (super.noSuchMethod(
        Invocation.getter(#managers),
        returnValue: <_i6.Manager>[],
      ) as List<_i6.Manager>);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<String> getWalletIdsFor({required _i13.Coin? coin}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWalletIdsFor,
          [],
          {#coin: coin},
        ),
        returnValue: <String>[],
      ) as List<String>);
  @override
  Map<_i13.Coin, List<_i5.ChangeNotifierProvider<_i6.Manager>>>
      getManagerProvidersByCoin() => (super.noSuchMethod(
            Invocation.method(
              #getManagerProvidersByCoin,
              [],
            ),
            returnValue: <_i13.Coin,
                List<_i5.ChangeNotifierProvider<_i6.Manager>>>{},
          ) as Map<_i13.Coin, List<_i5.ChangeNotifierProvider<_i6.Manager>>>);
  @override
  _i5.ChangeNotifierProvider<_i6.Manager> getManagerProvider(
          String? walletId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getManagerProvider,
          [walletId],
        ),
        returnValue: _FakeChangeNotifierProvider_2<_i6.Manager>(
          this,
          Invocation.method(
            #getManagerProvider,
            [walletId],
          ),
        ),
      ) as _i5.ChangeNotifierProvider<_i6.Manager>);
  @override
  _i6.Manager getManager(String? walletId) => (super.noSuchMethod(
        Invocation.method(
          #getManager,
          [walletId],
        ),
        returnValue: _FakeManager_3(
          this,
          Invocation.method(
            #getManager,
            [walletId],
          ),
        ),
      ) as _i6.Manager);
  @override
  void addWallet({
    required String? walletId,
    required _i6.Manager? manager,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #addWallet,
          [],
          {
            #walletId: walletId,
            #manager: manager,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeWallet({required String? walletId}) => super.noSuchMethod(
        Invocation.method(
          #removeWallet,
          [],
          {#walletId: walletId},
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i14.Future<void> load(_i15.Prefs? prefs) => (super.noSuchMethod(
        Invocation.method(
          #load,
          [prefs],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> loadAfterStackRestore(
    _i15.Prefs? prefs,
    List<_i6.Manager>? managers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadAfterStackRestore,
          [
            prefs,
            managers,
          ],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  void addListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [BitcoinWallet].
///
/// See the documentation for Mockito's code generation for more information.
class MockBitcoinWallet extends _i1.Mock implements _i17.BitcoinWallet {
  MockBitcoinWallet() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set timer(_i14.Timer? _timer) => super.noSuchMethod(
        Invocation.setter(
          #timer,
          _timer,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.TransactionNotificationTracker get txTracker => (super.noSuchMethod(
        Invocation.getter(#txTracker),
        returnValue: _FakeTransactionNotificationTracker_4(
          this,
          Invocation.getter(#txTracker),
        ),
      ) as _i7.TransactionNotificationTracker);
  @override
  set txTracker(_i7.TransactionNotificationTracker? _txTracker) =>
      super.noSuchMethod(
        Invocation.setter(
          #txTracker,
          _txTracker,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i8.UtxoObject> get outputsList => (super.noSuchMethod(
        Invocation.getter(#outputsList),
        returnValue: <_i8.UtxoObject>[],
      ) as List<_i8.UtxoObject>);
  @override
  set outputsList(List<_i8.UtxoObject>? _outputsList) => super.noSuchMethod(
        Invocation.setter(
          #outputsList,
          _outputsList,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get longMutex => (super.noSuchMethod(
        Invocation.getter(#longMutex),
        returnValue: false,
      ) as bool);
  @override
  set longMutex(bool? _longMutex) => super.noSuchMethod(
        Invocation.setter(
          #longMutex,
          _longMutex,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get refreshMutex => (super.noSuchMethod(
        Invocation.getter(#refreshMutex),
        returnValue: false,
      ) as bool);
  @override
  set refreshMutex(bool? _refreshMutex) => super.noSuchMethod(
        Invocation.setter(
          #refreshMutex,
          _refreshMutex,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isActive => (super.noSuchMethod(
        Invocation.getter(#isActive),
        returnValue: false,
      ) as bool);
  @override
  set isActive(bool? _isActive) => super.noSuchMethod(
        Invocation.setter(
          #isActive,
          _isActive,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set isFavorite(bool? markFavorite) => super.noSuchMethod(
        Invocation.setter(
          #isFavorite,
          markFavorite,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isFavorite => (super.noSuchMethod(
        Invocation.getter(#isFavorite),
        returnValue: false,
      ) as bool);
  @override
  _i13.Coin get coin => (super.noSuchMethod(
        Invocation.getter(#coin),
        returnValue: _i13.Coin.bitcoin,
      ) as _i13.Coin);
  @override
  _i14.Future<List<String>> get allOwnAddresses => (super.noSuchMethod(
        Invocation.getter(#allOwnAddresses),
        returnValue: _i14.Future<List<String>>.value(<String>[]),
      ) as _i14.Future<List<String>>);
  @override
  _i14.Future<_i8.UtxoData> get utxoData => (super.noSuchMethod(
        Invocation.getter(#utxoData),
        returnValue: _i14.Future<_i8.UtxoData>.value(_FakeUtxoData_5(
          this,
          Invocation.getter(#utxoData),
        )),
      ) as _i14.Future<_i8.UtxoData>);
  @override
  _i14.Future<List<_i8.UtxoObject>> get unspentOutputs => (super.noSuchMethod(
        Invocation.getter(#unspentOutputs),
        returnValue:
            _i14.Future<List<_i8.UtxoObject>>.value(<_i8.UtxoObject>[]),
      ) as _i14.Future<List<_i8.UtxoObject>>);
  @override
  _i14.Future<_i9.Decimal> get availableBalance => (super.noSuchMethod(
        Invocation.getter(#availableBalance),
        returnValue: _i14.Future<_i9.Decimal>.value(_FakeDecimal_6(
          this,
          Invocation.getter(#availableBalance),
        )),
      ) as _i14.Future<_i9.Decimal>);
  @override
  _i14.Future<_i9.Decimal> get pendingBalance => (super.noSuchMethod(
        Invocation.getter(#pendingBalance),
        returnValue: _i14.Future<_i9.Decimal>.value(_FakeDecimal_6(
          this,
          Invocation.getter(#pendingBalance),
        )),
      ) as _i14.Future<_i9.Decimal>);
  @override
  _i14.Future<_i9.Decimal> get balanceMinusMaxFee => (super.noSuchMethod(
        Invocation.getter(#balanceMinusMaxFee),
        returnValue: _i14.Future<_i9.Decimal>.value(_FakeDecimal_6(
          this,
          Invocation.getter(#balanceMinusMaxFee),
        )),
      ) as _i14.Future<_i9.Decimal>);
  @override
  _i14.Future<_i9.Decimal> get totalBalance => (super.noSuchMethod(
        Invocation.getter(#totalBalance),
        returnValue: _i14.Future<_i9.Decimal>.value(_FakeDecimal_6(
          this,
          Invocation.getter(#totalBalance),
        )),
      ) as _i14.Future<_i9.Decimal>);
  @override
  _i14.Future<String> get currentReceivingAddress => (super.noSuchMethod(
        Invocation.getter(#currentReceivingAddress),
        returnValue: _i14.Future<String>.value(''),
      ) as _i14.Future<String>);
  @override
  _i14.Future<String> get currentLegacyReceivingAddress => (super.noSuchMethod(
        Invocation.getter(#currentLegacyReceivingAddress),
        returnValue: _i14.Future<String>.value(''),
      ) as _i14.Future<String>);
  @override
  _i14.Future<String> get currentReceivingAddressP2SH => (super.noSuchMethod(
        Invocation.getter(#currentReceivingAddressP2SH),
        returnValue: _i14.Future<String>.value(''),
      ) as _i14.Future<String>);
  @override
  bool get hasCalledExit => (super.noSuchMethod(
        Invocation.getter(#hasCalledExit),
        returnValue: false,
      ) as bool);
  @override
  _i14.Future<_i8.FeeObject> get fees => (super.noSuchMethod(
        Invocation.getter(#fees),
        returnValue: _i14.Future<_i8.FeeObject>.value(_FakeFeeObject_7(
          this,
          Invocation.getter(#fees),
        )),
      ) as _i14.Future<_i8.FeeObject>);
  @override
  _i14.Future<int> get maxFee => (super.noSuchMethod(
        Invocation.getter(#maxFee),
        returnValue: _i14.Future<int>.value(0),
      ) as _i14.Future<int>);
  @override
  _i14.Future<List<String>> get mnemonic => (super.noSuchMethod(
        Invocation.getter(#mnemonic),
        returnValue: _i14.Future<List<String>>.value(<String>[]),
      ) as _i14.Future<List<String>>);
  @override
  _i14.Future<int> get chainHeight => (super.noSuchMethod(
        Invocation.getter(#chainHeight),
        returnValue: _i14.Future<int>.value(0),
      ) as _i14.Future<int>);
  @override
  int get storedChainHeight => (super.noSuchMethod(
        Invocation.getter(#storedChainHeight),
        returnValue: 0,
      ) as int);
  @override
  bool get shouldAutoSync => (super.noSuchMethod(
        Invocation.getter(#shouldAutoSync),
        returnValue: false,
      ) as bool);
  @override
  set shouldAutoSync(bool? shouldAutoSync) => super.noSuchMethod(
        Invocation.setter(
          #shouldAutoSync,
          shouldAutoSync,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isRefreshing => (super.noSuchMethod(
        Invocation.getter(#isRefreshing),
        returnValue: false,
      ) as bool);
  @override
  bool get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: false,
      ) as bool);
  @override
  _i14.Future<_i8.TransactionData> get transactionData => (super.noSuchMethod(
        Invocation.getter(#transactionData),
        returnValue:
            _i14.Future<_i8.TransactionData>.value(_FakeTransactionData_8(
          this,
          Invocation.getter(#transactionData),
        )),
      ) as _i14.Future<_i8.TransactionData>);
  @override
  String get walletId => (super.noSuchMethod(
        Invocation.getter(#walletId),
        returnValue: '',
      ) as String);
  @override
  String get walletName => (super.noSuchMethod(
        Invocation.getter(#walletName),
        returnValue: '',
      ) as String);
  @override
  set walletName(String? newName) => super.noSuchMethod(
        Invocation.setter(
          #walletName,
          newName,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i10.ElectrumX get electrumXClient => (super.noSuchMethod(
        Invocation.getter(#electrumXClient),
        returnValue: _FakeElectrumX_9(
          this,
          Invocation.getter(#electrumXClient),
        ),
      ) as _i10.ElectrumX);
  @override
  _i11.CachedElectrumX get cachedElectrumXClient => (super.noSuchMethod(
        Invocation.getter(#cachedElectrumXClient),
        returnValue: _FakeCachedElectrumX_10(
          this,
          Invocation.getter(#cachedElectrumXClient),
        ),
      ) as _i11.CachedElectrumX);
  @override
  set onIsActiveWalletChanged(void Function(bool)? _onIsActiveWalletChanged) =>
      super.noSuchMethod(
        Invocation.setter(
          #onIsActiveWalletChanged,
          _onIsActiveWalletChanged,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i14.Future<void> exit() => (super.noSuchMethod(
        Invocation.method(
          #exit,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> updateStoredChainHeight({required int? newHeight}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateStoredChainHeight,
          [],
          {#newHeight: newHeight},
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i17.DerivePathType addressType({required String? address}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addressType,
          [],
          {#address: address},
        ),
        returnValue: _i17.DerivePathType.bip44,
      ) as _i17.DerivePathType);
  @override
  _i14.Future<void> recoverFromMnemonic({
    required String? mnemonic,
    required int? maxUnusedAddressGap,
    required int? maxNumberOfIndexesToCheck,
    required int? height,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #recoverFromMnemonic,
          [],
          {
            #mnemonic: mnemonic,
            #maxUnusedAddressGap: maxUnusedAddressGap,
            #maxNumberOfIndexesToCheck: maxNumberOfIndexesToCheck,
            #height: height,
          },
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> getTransactionCacheEarly(List<String>? allAddresses) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransactionCacheEarly,
          [allAddresses],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<bool> refreshIfThereIsNewData() => (super.noSuchMethod(
        Invocation.method(
          #refreshIfThereIsNewData,
          [],
        ),
        returnValue: _i14.Future<bool>.value(false),
      ) as _i14.Future<bool>);
  @override
  _i14.Future<void> getAllTxsToWatch(_i8.TransactionData? txData) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTxsToWatch,
          [txData],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> refresh() => (super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<Map<String, dynamic>> prepareSend({
    required String? address,
    required int? satoshiAmount,
    Map<String, dynamic>? args,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #prepareSend,
          [],
          {
            #address: address,
            #satoshiAmount: satoshiAmount,
            #args: args,
          },
        ),
        returnValue:
            _i14.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i14.Future<Map<String, dynamic>>);
  @override
  _i14.Future<String> confirmSend({required Map<String, dynamic>? txData}) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmSend,
          [],
          {#txData: txData},
        ),
        returnValue: _i14.Future<String>.value(''),
      ) as _i14.Future<String>);
  @override
  _i14.Future<String> send({
    required String? toAddress,
    required int? amount,
    Map<String, String>? args = const {},
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [],
          {
            #toAddress: toAddress,
            #amount: amount,
            #args: args,
          },
        ),
        returnValue: _i14.Future<String>.value(''),
      ) as _i14.Future<String>);
  @override
  _i14.Future<bool> testNetworkConnection() => (super.noSuchMethod(
        Invocation.method(
          #testNetworkConnection,
          [],
        ),
        returnValue: _i14.Future<bool>.value(false),
      ) as _i14.Future<bool>);
  @override
  void startNetworkAlivePinging() => super.noSuchMethod(
        Invocation.method(
          #startNetworkAlivePinging,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void stopNetworkAlivePinging() => super.noSuchMethod(
        Invocation.method(
          #stopNetworkAlivePinging,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i14.Future<void> initializeNew() => (super.noSuchMethod(
        Invocation.method(
          #initializeNew,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> initializeExisting() => (super.noSuchMethod(
        Invocation.method(
          #initializeExisting,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  bool validateAddress(String? address) => (super.noSuchMethod(
        Invocation.method(
          #validateAddress,
          [address],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i14.Future<void> updateNode(bool? shouldRefresh) => (super.noSuchMethod(
        Invocation.method(
          #updateNode,
          [shouldRefresh],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<_i10.ElectrumXNode> getCurrentNode() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentNode,
          [],
        ),
        returnValue:
            _i14.Future<_i10.ElectrumXNode>.value(_FakeElectrumXNode_11(
          this,
          Invocation.method(
            #getCurrentNode,
            [],
          ),
        )),
      ) as _i14.Future<_i10.ElectrumXNode>);
  @override
  _i14.Future<void> addDerivation({
    required int? chain,
    required String? address,
    required String? pubKey,
    required String? wif,
    required _i17.DerivePathType? derivePathType,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDerivation,
          [],
          {
            #chain: chain,
            #address: address,
            #pubKey: pubKey,
            #wif: wif,
            #derivePathType: derivePathType,
          },
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> addDerivations({
    required int? chain,
    required _i17.DerivePathType? derivePathType,
    required Map<String, dynamic>? derivationsToAdd,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDerivations,
          [],
          {
            #chain: chain,
            #derivePathType: derivePathType,
            #derivationsToAdd: derivationsToAdd,
          },
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<int> getTxCount({required String? address}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTxCount,
          [],
          {#address: address},
        ),
        returnValue: _i14.Future<int>.value(0),
      ) as _i14.Future<int>);
  @override
  _i14.Future<void> checkCurrentReceivingAddressesForTransactions() =>
      (super.noSuchMethod(
        Invocation.method(
          #checkCurrentReceivingAddressesForTransactions,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<void> checkCurrentChangeAddressesForTransactions() =>
      (super.noSuchMethod(
        Invocation.method(
          #checkCurrentChangeAddressesForTransactions,
          [],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<List<Map<String, dynamic>>> fastFetch(
          List<String>? allTxHashes) =>
      (super.noSuchMethod(
        Invocation.method(
          #fastFetch,
          [allTxHashes],
        ),
        returnValue: _i14.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i14.Future<List<Map<String, dynamic>>>);
  @override
  int estimateTxFee({
    required int? vSize,
    required int? feeRatePerKB,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #estimateTxFee,
          [],
          {
            #vSize: vSize,
            #feeRatePerKB: feeRatePerKB,
          },
        ),
        returnValue: 0,
      ) as int);
  @override
  dynamic coinSelection(
    int? satoshiAmountToSend,
    int? selectedTxFeeRate,
    String? _recipientAddress,
    bool? isSendAll, {
    int? additionalOutputs = 0,
    List<_i8.UtxoObject>? utxos,
  }) =>
      super.noSuchMethod(Invocation.method(
        #coinSelection,
        [
          satoshiAmountToSend,
          selectedTxFeeRate,
          _recipientAddress,
          isSendAll,
        ],
        {
          #additionalOutputs: additionalOutputs,
          #utxos: utxos,
        },
      ));
  @override
  _i14.Future<Map<String, dynamic>> fetchBuildTxData(
          List<_i8.UtxoObject>? utxosToUse) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchBuildTxData,
          [utxosToUse],
        ),
        returnValue:
            _i14.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i14.Future<Map<String, dynamic>>);
  @override
  _i14.Future<Map<String, dynamic>> buildTransaction({
    required List<_i8.UtxoObject>? utxosToUse,
    required Map<String, dynamic>? utxoSigningData,
    required List<String>? recipients,
    required List<int>? satoshiAmounts,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #buildTransaction,
          [],
          {
            #utxosToUse: utxosToUse,
            #utxoSigningData: utxoSigningData,
            #recipients: recipients,
            #satoshiAmounts: satoshiAmounts,
          },
        ),
        returnValue:
            _i14.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i14.Future<Map<String, dynamic>>);
  @override
  _i14.Future<void> fullRescan(
    int? maxUnusedAddressGap,
    int? maxNumberOfIndexesToCheck,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fullRescan,
          [
            maxUnusedAddressGap,
            maxNumberOfIndexesToCheck,
          ],
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  _i14.Future<int> estimateFeeFor(
    int? satoshiAmount,
    int? feeRate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #estimateFeeFor,
          [
            satoshiAmount,
            feeRate,
          ],
        ),
        returnValue: _i14.Future<int>.value(0),
      ) as _i14.Future<int>);
  @override
  int roughFeeEstimate(
    int? inputCount,
    int? outputCount,
    int? feeRatePerKB,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #roughFeeEstimate,
          [
            inputCount,
            outputCount,
            feeRatePerKB,
          ],
        ),
        returnValue: 0,
      ) as int);
  @override
  int sweepAllEstimate(int? feeRate) => (super.noSuchMethod(
        Invocation.method(
          #sweepAllEstimate,
          [feeRate],
        ),
        returnValue: 0,
      ) as int);
  @override
  _i14.Future<bool> generateNewAddress() => (super.noSuchMethod(
        Invocation.method(
          #generateNewAddress,
          [],
        ),
        returnValue: _i14.Future<bool>.value(false),
      ) as _i14.Future<bool>);
}

/// A class which mocks [LocaleService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocaleService extends _i1.Mock implements _i18.LocaleService {
  MockLocaleService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get locale => (super.noSuchMethod(
        Invocation.getter(#locale),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i14.Future<void> loadLocale({bool? notify = true}) => (super.noSuchMethod(
        Invocation.method(
          #loadLocale,
          [],
          {#notify: notify},
        ),
        returnValue: _i14.Future<void>.value(),
        returnValueForMissingStub: _i14.Future<void>.value(),
      ) as _i14.Future<void>);
  @override
  void addListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i16.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
