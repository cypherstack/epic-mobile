import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final pIsarDB = Provider((ref) => IsarDB.instance);

class IsarDB {
  IsarDB._();
  static IsarDB? _instance;
  static IsarDB get instance => _instance ??= IsarDB._();

  Isar? _isar;

  Isar get isar {
    if (_isar == null) {
      throw Exception("IsarDB isar instance not initialized!");
    } else {
      return _isar!;
    }
  }

  void init(Isar isar) {
    if (_isar != null) {
      throw Exception("IsarDB isar instance was already initialized!");
    } else {
      _isar = isar;
    }
  }
}
