import 'package:isar/isar.dart';

part 'trade.g.dart';

@Collection(accessor: "trades")
class Trade {
  Id id = Isar.autoIncrement;
}
