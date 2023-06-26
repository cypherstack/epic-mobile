import 'package:isar/isar.dart';

part 'currency.g.dart';

@Collection(accessor: "currencies")
class Currency {
  Id id = Isar.autoIncrement;
}
