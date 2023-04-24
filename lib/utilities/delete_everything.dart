import 'package:epicpay/hive/db.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:hive/hive.dart';

Future<bool> deleteEverything() async {
  try {
    await Hive.box(DB.boxNameAddressBook).clear();
    await Hive.box(DB.boxNameDebugInfo).clear();
    await Hive.box(DB.boxNameNodeModels).clear();
    await Hive.box(DB.boxNamePrimaryNodes).clear();
    await Hive.box(DB.boxNameEpicBoxModels).clear();
    await Hive.box(DB.boxNamePrimaryEpicBox).clear();
    await Hive.box(DB.boxNameAllWalletsData).clear();
    await Hive.box(DB.boxNameNotifications).clear();
    await Hive.box(DB.boxNameWatchedTransactions).clear();
    await Hive.box(DB.boxNameFavoriteWallets).clear();
    await Hive.box(DB.boxNamePrefs).clear();
    await Hive.box(DB.boxNameWalletsToDeleteOnStart).clear();
    await Hive.box(DB.boxNamePriceCache).clear();
    await Hive.box(DB.boxNameDBInfo).clear();
    await Hive.box(DB.boxNameTheme).clear();

    return true;
  } catch (e, s) {
    Logging.instance.log("$e $s", level: LogLevel.Error);
    return false;
  }
}
