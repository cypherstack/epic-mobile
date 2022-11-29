import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicmobile/models/wallet_restore_state.dart';
import 'package:epicmobile/services/coins/manager.dart';
import 'package:epicmobile/utilities/enums/stack_restoring_status.dart';

class StackRestoringUIState extends ChangeNotifier {
  bool _walletsWasSet = false;
  bool get done {
    if (!_walletsWasSet) {
      return false;
    }

    bool _done = (_decryption == StackRestoringStatus.success) ||
        (_decryption == StackRestoringStatus.failed);
    _done &= (_addressBook == StackRestoringStatus.success) ||
        (_addressBook == StackRestoringStatus.failed);
    _done &= (_preferences == StackRestoringStatus.success) ||
        (_preferences == StackRestoringStatus.failed);
    _done &= (_trades == StackRestoringStatus.success) ||
        (_trades == StackRestoringStatus.failed);
    _done &= (_nodes == StackRestoringStatus.success) ||
        (_nodes == StackRestoringStatus.failed);

    for (final wallet in _walletStates.values) {
      _done &= (wallet.restoringState == StackRestoringStatus.success) ||
          (wallet.restoringState == StackRestoringStatus.failed);
    }

    return _done;
  }

  bool get succeeded {
    if (!_walletsWasSet) {
      return false;
    }

    bool _succeeded = _decryption == StackRestoringStatus.success;
    _succeeded &= _addressBook == StackRestoringStatus.success;
    _succeeded &= _preferences == StackRestoringStatus.success;
    _succeeded &= _trades == StackRestoringStatus.success;
    _succeeded &= _nodes == StackRestoringStatus.success;

    for (final wallet in _walletStates.values) {
      _succeeded &= wallet.restoringState == StackRestoringStatus.success;
    }

    return _succeeded;
  }

  StackRestoringStatus _decryption = StackRestoringStatus.waiting;
  StackRestoringStatus get decryption => _decryption;
  set decryption(StackRestoringStatus state) {
    _decryption = state;
    notifyListeners();
  }

  StackRestoringStatus _addressBook = StackRestoringStatus.waiting;
  StackRestoringStatus get addressBook => _addressBook;
  set addressBook(StackRestoringStatus state) {
    _addressBook = state;
    notifyListeners();
  }

  StackRestoringStatus _preferences = StackRestoringStatus.waiting;
  StackRestoringStatus get preferences => _preferences;
  set preferences(StackRestoringStatus state) {
    _preferences = state;
    notifyListeners();
  }

  StackRestoringStatus _trades = StackRestoringStatus.waiting;
  StackRestoringStatus get trades => _trades;
  set trades(StackRestoringStatus state) {
    _trades = state;
    notifyListeners();
  }

  StackRestoringStatus _nodes = StackRestoringStatus.waiting;
  StackRestoringStatus get nodes => _nodes;
  set nodes(StackRestoringStatus state) {
    _nodes = state;
    notifyListeners();
  }

  List<Manager> get managers {
    List<Manager> _managers = [];
    for (final item in _walletStates.values) {
      if (item.manager != null) {
        _managers.add(item.manager!);
      }
    }
    return _managers;
  }

  Map<String, WalletRestoreState> _walletStates = {};
  set walletStates(Map<String, WalletRestoreState> state) {
    _walletStates = state;
    _walletStateProviders = {};
    for (final wallet in _walletStates.values) {
      _walletStateProviders[wallet.walletId] =
          ChangeNotifierProvider<WalletRestoreState>((_) => wallet);
    }
    _walletsWasSet = true;
    notifyListeners();
  }

  Map<String, ChangeNotifierProvider<WalletRestoreState>>
      _walletStateProviders = {};
  Map<String, ChangeNotifierProvider<WalletRestoreState>>
      get walletStateProviders => _walletStateProviders;

  WalletRestoreState getWalletRestoreState(String walletId) {
    return _walletStates[walletId]!;
  }

  ChangeNotifierProvider<WalletRestoreState> getWalletRestoreStateProvider(
      String walletId) {
    return _walletStateProviders[walletId]!;
  }

  void update({
    required String walletId,
    required StackRestoringStatus restoringStatus,
    Manager? manager,
    String? address,
    String? mnemonic,
    int? height,
  }) {
    _walletStates[walletId]!.restoringState = restoringStatus;
    _walletStates[walletId]!.manager =
        manager ?? _walletStates[walletId]!.manager;
    _walletStates[walletId]!.address =
        address ?? _walletStates[walletId]!.address;
    _walletStates[walletId]!.mnemonic =
        mnemonic ?? _walletStates[walletId]!.mnemonic;
    _walletStates[walletId]!.height = height ?? _walletStates[walletId]!.height;
    notifyListeners();
  }
}
