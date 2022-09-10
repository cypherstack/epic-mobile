// Mocks generated by Mockito 5.2.0 from annotations
// in stackwallet/test/screen_tests/lockscreen_view_screen_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:ui' as _i9;

import 'package:decimal/decimal.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:stackwallet/models/models.dart' as _i4;
import 'package:stackwallet/models/node_model.dart' as _i11;
import 'package:stackwallet/services/coins/coin_service.dart' as _i3;
import 'package:stackwallet/services/coins/manager.dart' as _i12;
import 'package:stackwallet/services/node_service.dart' as _i10;
import 'package:stackwallet/services/wallets_service.dart' as _i6;
import 'package:stackwallet/utilities/enums/coin_enum.dart' as _i8;
import 'package:stackwallet/utilities/flutter_secure_storage_interface.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeFlutterSecureStorageInterface_0 extends _i1.Fake
    implements _i2.FlutterSecureStorageInterface {}

class _FakeCoinServiceAPI_1 extends _i1.Fake implements _i3.CoinServiceAPI {}

class _FakeFeeObject_2 extends _i1.Fake implements _i4.FeeObject {}

class _FakeDecimal_3 extends _i1.Fake implements _i5.Decimal {}

class _FakeTransactionData_4 extends _i1.Fake implements _i4.TransactionData {}

/// A class which mocks [WalletsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockWalletsService extends _i1.Mock implements _i6.WalletsService {
  @override
  _i7.Future<Map<String, _i6.WalletInfo>> get walletNames =>
      (super.noSuchMethod(Invocation.getter(#walletNames),
              returnValue: Future<Map<String, _i6.WalletInfo>>.value(
                  <String, _i6.WalletInfo>{}))
          as _i7.Future<Map<String, _i6.WalletInfo>>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i7.Future<bool> renameWallet(
          {String? from, String? to, bool? shouldNotifyListeners}) =>
      (super.noSuchMethod(
          Invocation.method(#renameWallet, [], {
            #from: from,
            #to: to,
            #shouldNotifyListeners: shouldNotifyListeners
          }),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<void> addExistingStackWallet(
          {String? name,
          String? walletId,
          _i8.Coin? coin,
          bool? shouldNotifyListeners}) =>
      (super.noSuchMethod(
          Invocation.method(#addExistingStackWallet, [], {
            #name: name,
            #walletId: walletId,
            #coin: coin,
            #shouldNotifyListeners: shouldNotifyListeners
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<String?> addNewWallet(
          {String? name, _i8.Coin? coin, bool? shouldNotifyListeners}) =>
      (super.noSuchMethod(
          Invocation.method(#addNewWallet, [], {
            #name: name,
            #coin: coin,
            #shouldNotifyListeners: shouldNotifyListeners
          }),
          returnValue: Future<String?>.value()) as _i7.Future<String?>);
  @override
  _i7.Future<List<String>> getFavoriteWalletIds() =>
      (super.noSuchMethod(Invocation.method(#getFavoriteWalletIds, []),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i7.Future<List<String>>);
  @override
  _i7.Future<void> saveFavoriteWalletIds(List<String>? walletIds) => (super
      .noSuchMethod(Invocation.method(#saveFavoriteWalletIds, [walletIds]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> addFavorite(String? walletId) =>
      (super.noSuchMethod(Invocation.method(#addFavorite, [walletId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> removeFavorite(String? walletId) =>
      (super.noSuchMethod(Invocation.method(#removeFavorite, [walletId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> moveFavorite({int? fromIndex, int? toIndex}) =>
      (super.noSuchMethod(
          Invocation.method(
              #moveFavorite, [], {#fromIndex: fromIndex, #toIndex: toIndex}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<bool> checkForDuplicate(String? name) =>
      (super.noSuchMethod(Invocation.method(#checkForDuplicate, [name]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<String?> getWalletId(String? walletName) =>
      (super.noSuchMethod(Invocation.method(#getWalletId, [walletName]),
          returnValue: Future<String?>.value()) as _i7.Future<String?>);
  @override
  _i7.Future<bool> isMnemonicVerified({String? walletId}) =>
      (super.noSuchMethod(
          Invocation.method(#isMnemonicVerified, [], {#walletId: walletId}),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<void> setMnemonicVerified({String? walletId}) =>
      (super.noSuchMethod(
          Invocation.method(#setMnemonicVerified, [], {#walletId: walletId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<int> deleteWallet(String? name, bool? shouldNotifyListeners) =>
      (super.noSuchMethod(
          Invocation.method(#deleteWallet, [name, shouldNotifyListeners]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<void> refreshWallets(bool? shouldNotifyListeners) => (super
      .noSuchMethod(Invocation.method(#refreshWallets, [shouldNotifyListeners]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [NodeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNodeService extends _i1.Mock implements _i10.NodeService {
  @override
  _i2.FlutterSecureStorageInterface get secureStorageInterface =>
      (super.noSuchMethod(Invocation.getter(#secureStorageInterface),
              returnValue: _FakeFlutterSecureStorageInterface_0())
          as _i2.FlutterSecureStorageInterface);
  @override
  List<_i11.NodeModel> get primaryNodes =>
      (super.noSuchMethod(Invocation.getter(#primaryNodes),
          returnValue: <_i11.NodeModel>[]) as List<_i11.NodeModel>);
  @override
  List<_i11.NodeModel> get nodes =>
      (super.noSuchMethod(Invocation.getter(#nodes),
          returnValue: <_i11.NodeModel>[]) as List<_i11.NodeModel>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i7.Future<void> updateDefaults() =>
      (super.noSuchMethod(Invocation.method(#updateDefaults, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> setPrimaryNodeFor(
          {_i8.Coin? coin,
          _i11.NodeModel? node,
          bool? shouldNotifyListeners = false}) =>
      (super.noSuchMethod(
          Invocation.method(#setPrimaryNodeFor, [], {
            #coin: coin,
            #node: node,
            #shouldNotifyListeners: shouldNotifyListeners
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i11.NodeModel? getPrimaryNodeFor({_i8.Coin? coin}) => (super.noSuchMethod(
          Invocation.method(#getPrimaryNodeFor, [], {#coin: coin}))
      as _i11.NodeModel?);
  @override
  List<_i11.NodeModel> getNodesFor(_i8.Coin? coin) =>
      (super.noSuchMethod(Invocation.method(#getNodesFor, [coin]),
          returnValue: <_i11.NodeModel>[]) as List<_i11.NodeModel>);
  @override
  _i11.NodeModel? getNodeById({String? id}) =>
      (super.noSuchMethod(Invocation.method(#getNodeById, [], {#id: id}))
          as _i11.NodeModel?);
  @override
  List<_i11.NodeModel> failoverNodesFor({_i8.Coin? coin}) => (super
      .noSuchMethod(Invocation.method(#failoverNodesFor, [], {#coin: coin}),
          returnValue: <_i11.NodeModel>[]) as List<_i11.NodeModel>);
  @override
  _i7.Future<void> add(_i11.NodeModel? node, String? password,
          bool? shouldNotifyListeners) =>
      (super.noSuchMethod(
          Invocation.method(#add, [node, password, shouldNotifyListeners]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> delete(String? id, bool? shouldNotifyListeners) => (super
      .noSuchMethod(Invocation.method(#delete, [id, shouldNotifyListeners]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> setEnabledState(
          String? id, bool? enabled, bool? shouldNotifyListeners) =>
      (super.noSuchMethod(
          Invocation.method(
              #setEnabledState, [id, enabled, shouldNotifyListeners]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> edit(_i11.NodeModel? editedNode, String? password,
          bool? shouldNotifyListeners) =>
      (super.noSuchMethod(
          Invocation.method(
              #edit, [editedNode, password, shouldNotifyListeners]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> updateCommunityNodes() =>
      (super.noSuchMethod(Invocation.method(#updateCommunityNodes, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [Manager].
///
/// See the documentation for Mockito's code generation for more information.
class MockManager extends _i1.Mock implements _i12.Manager {
  @override
  bool get isActiveWallet => (super
          .noSuchMethod(Invocation.getter(#isActiveWallet), returnValue: false)
      as bool);
  @override
  set isActiveWallet(bool? isActive) =>
      super.noSuchMethod(Invocation.setter(#isActiveWallet, isActive),
          returnValueForMissingStub: null);
  @override
  _i3.CoinServiceAPI get wallet =>
      (super.noSuchMethod(Invocation.getter(#wallet),
          returnValue: _FakeCoinServiceAPI_1()) as _i3.CoinServiceAPI);
  @override
  bool get hasBackgroundRefreshListener =>
      (super.noSuchMethod(Invocation.getter(#hasBackgroundRefreshListener),
          returnValue: false) as bool);
  @override
  _i8.Coin get coin => (super.noSuchMethod(Invocation.getter(#coin),
      returnValue: _i8.Coin.bitcoin) as _i8.Coin);
  @override
  bool get isRefreshing =>
      (super.noSuchMethod(Invocation.getter(#isRefreshing), returnValue: false)
          as bool);
  @override
  bool get shouldAutoSync => (super
          .noSuchMethod(Invocation.getter(#shouldAutoSync), returnValue: false)
      as bool);
  @override
  set shouldAutoSync(bool? shouldAutoSync) =>
      super.noSuchMethod(Invocation.setter(#shouldAutoSync, shouldAutoSync),
          returnValueForMissingStub: null);
  @override
  bool get isFavorite =>
      (super.noSuchMethod(Invocation.getter(#isFavorite), returnValue: false)
          as bool);
  @override
  set isFavorite(bool? markFavorite) =>
      super.noSuchMethod(Invocation.setter(#isFavorite, markFavorite),
          returnValueForMissingStub: null);
  @override
  _i7.Future<_i4.FeeObject> get fees =>
      (super.noSuchMethod(Invocation.getter(#fees),
              returnValue: Future<_i4.FeeObject>.value(_FakeFeeObject_2()))
          as _i7.Future<_i4.FeeObject>);
  @override
  _i7.Future<int> get maxFee => (super.noSuchMethod(Invocation.getter(#maxFee),
      returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<String> get currentReceivingAddress =>
      (super.noSuchMethod(Invocation.getter(#currentReceivingAddress),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i5.Decimal> get availableBalance =>
      (super.noSuchMethod(Invocation.getter(#availableBalance),
              returnValue: Future<_i5.Decimal>.value(_FakeDecimal_3()))
          as _i7.Future<_i5.Decimal>);
  @override
  _i5.Decimal get cachedAvailableBalance =>
      (super.noSuchMethod(Invocation.getter(#cachedAvailableBalance),
          returnValue: _FakeDecimal_3()) as _i5.Decimal);
  @override
  _i7.Future<_i5.Decimal> get pendingBalance =>
      (super.noSuchMethod(Invocation.getter(#pendingBalance),
              returnValue: Future<_i5.Decimal>.value(_FakeDecimal_3()))
          as _i7.Future<_i5.Decimal>);
  @override
  _i7.Future<_i5.Decimal> get balanceMinusMaxFee =>
      (super.noSuchMethod(Invocation.getter(#balanceMinusMaxFee),
              returnValue: Future<_i5.Decimal>.value(_FakeDecimal_3()))
          as _i7.Future<_i5.Decimal>);
  @override
  _i7.Future<_i5.Decimal> get totalBalance =>
      (super.noSuchMethod(Invocation.getter(#totalBalance),
              returnValue: Future<_i5.Decimal>.value(_FakeDecimal_3()))
          as _i7.Future<_i5.Decimal>);
  @override
  _i5.Decimal get cachedTotalBalance =>
      (super.noSuchMethod(Invocation.getter(#cachedTotalBalance),
          returnValue: _FakeDecimal_3()) as _i5.Decimal);
  @override
  _i7.Future<List<String>> get allOwnAddresses =>
      (super.noSuchMethod(Invocation.getter(#allOwnAddresses),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i7.Future<List<String>>);
  @override
  _i7.Future<_i4.TransactionData> get transactionData =>
      (super.noSuchMethod(Invocation.getter(#transactionData),
              returnValue:
                  Future<_i4.TransactionData>.value(_FakeTransactionData_4()))
          as _i7.Future<_i4.TransactionData>);
  @override
  _i7.Future<List<_i4.UtxoObject>> get unspentOutputs => (super.noSuchMethod(
          Invocation.getter(#unspentOutputs),
          returnValue: Future<List<_i4.UtxoObject>>.value(<_i4.UtxoObject>[]))
      as _i7.Future<List<_i4.UtxoObject>>);
  @override
  set walletName(String? newName) =>
      super.noSuchMethod(Invocation.setter(#walletName, newName),
          returnValueForMissingStub: null);
  @override
  String get walletName =>
      (super.noSuchMethod(Invocation.getter(#walletName), returnValue: '')
          as String);
  @override
  String get walletId =>
      (super.noSuchMethod(Invocation.getter(#walletId), returnValue: '')
          as String);
  @override
  _i7.Future<List<String>> get mnemonic =>
      (super.noSuchMethod(Invocation.getter(#mnemonic),
              returnValue: Future<List<String>>.value(<String>[]))
          as _i7.Future<List<String>>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i7.Future<void> updateNode(bool? shouldRefresh) =>
      (super.noSuchMethod(Invocation.method(#updateNode, [shouldRefresh]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  _i7.Future<Map<String, dynamic>> prepareSend(
          {String? address, int? satoshiAmount, Map<String, dynamic>? args}) =>
      (super.noSuchMethod(
              Invocation.method(#prepareSend, [], {
                #address: address,
                #satoshiAmount: satoshiAmount,
                #args: args
              }),
              returnValue:
                  Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i7.Future<Map<String, dynamic>>);
  @override
  _i7.Future<String> confirmSend({Map<String, dynamic>? txData}) => (super
      .noSuchMethod(Invocation.method(#confirmSend, [], {#txData: txData}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> send(
          {String? toAddress,
          int? amount,
          Map<String, String>? args = const {}}) =>
      (super.noSuchMethod(
          Invocation.method(
              #send, [], {#toAddress: toAddress, #amount: amount, #args: args}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<void> refresh() =>
      (super.noSuchMethod(Invocation.method(#refresh, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  bool validateAddress(String? address) =>
      (super.noSuchMethod(Invocation.method(#validateAddress, [address]),
          returnValue: false) as bool);
  @override
  _i7.Future<bool> testNetworkConnection() =>
      (super.noSuchMethod(Invocation.method(#testNetworkConnection, []),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<void> initializeNew() =>
      (super.noSuchMethod(Invocation.method(#initializeNew, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> initializeExisting() =>
      (super.noSuchMethod(Invocation.method(#initializeExisting, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> recoverFromMnemonic(
          {String? mnemonic,
          int? maxUnusedAddressGap,
          int? maxNumberOfIndexesToCheck,
          int? height}) =>
      (super.noSuchMethod(
          Invocation.method(#recoverFromMnemonic, [], {
            #mnemonic: mnemonic,
            #maxUnusedAddressGap: maxUnusedAddressGap,
            #maxNumberOfIndexesToCheck: maxNumberOfIndexesToCheck,
            #height: height
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> exitCurrentWallet() =>
      (super.noSuchMethod(Invocation.method(#exitCurrentWallet, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> fullRescan(
          int? maxUnusedAddressGap, int? maxNumberOfIndexesToCheck) =>
      (super.noSuchMethod(
          Invocation.method(
              #fullRescan, [maxUnusedAddressGap, maxNumberOfIndexesToCheck]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<bool> isOwnAddress(String? address) =>
      (super.noSuchMethod(Invocation.method(#isOwnAddress, [address]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<int> estimateFeeFor(int? satoshiAmount, int? feeRate) =>
      (super.noSuchMethod(
          Invocation.method(#estimateFeeFor, [satoshiAmount, feeRate]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<bool> generateNewAddress() =>
      (super.noSuchMethod(Invocation.method(#generateNewAddress, []),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
