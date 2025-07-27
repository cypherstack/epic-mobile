import 'dart:async';
import 'dart:io';

import 'package:epicpay/db/hive/db.dart';
import 'package:epicpay/db/isar/isar_db.dart';
import 'package:epicpay/models/epicbox_server_model.dart';
import 'package:epicpay/models/isar/models/log.dart';
import 'package:epicpay/models/models.dart';
import 'package:epicpay/models/node_model.dart';
import 'package:epicpay/models/trade_wallet_lookup.dart';
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/pages/intro_view.dart';
import 'package:epicpay/pages/loading_view.dart';
import 'package:epicpay/pages/pinpad_views/lock_screen_view.dart';
import 'package:epicpay/providers/global/base_currencies_provider.dart';
import 'package:epicpay/providers/providers.dart';
import 'package:epicpay/providers/tx_count_on_startup_state_provider.dart';
import 'package:epicpay/providers/ui/color_theme_provider.dart';
import 'package:epicpay/route_generator.dart';
import 'package:epicpay/services/coins/epiccash/epiccash_wallet.dart';
import 'package:epicpay/services/coins/manager.dart';
import 'package:epicpay/services/debug_service.dart';
import 'package:epicpay/services/locale_service.dart';
import 'package:epicpay/services/node_service.dart';
import 'package:epicpay/utilities/constants.dart';
import 'package:epicpay/utilities/db_version_migration.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/prefs.dart';
import 'package:epicpay/utilities/theme/dark_colors.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:path_provider/path_provider.dart';

// main() is the entry point to the app. It initializes Hive (local database),
// runs the MyApp widget and checks for new users, caching the value in the
// miscellaneous box for later use
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  if (Platform.isIOS) {
    Util.libraryPath = await getLibraryDirectory();
  }

  Directory appDirectory = (await getApplicationDocumentsDirectory());
  if (Platform.isIOS) {
    appDirectory = (await getLibraryDirectory());
  }
  if (Platform.isLinux || Logging.isArmLinux) {
    appDirectory = Directory("${appDirectory.path}/.epicmobile");
    await appDirectory.create();
  }
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (!(Logging.isArmLinux || Logging.isTestEnv)) {
    final isar = await Isar.open(
      [
        LogSchema,
      ],
      directory: appDirectory.path,
      inspector: false,
    );
    await Logging.instance.init(isar);
    await DebugService.instance.init(isar);
    IsarDB.instance.init(isar);

    // clear out all info logs on startup. No need to await and block
    unawaited(DebugService.instance.deleteLogsOlderThan());
  }

  // Registering Transaction Model Adapters
  Hive.registerAdapter(TransactionDataAdapter());
  Hive.registerAdapter(TransactionChunkAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(InputAdapter());
  Hive.registerAdapter(OutputAdapter());

  // Registering Utxo Model Adapters
  Hive.registerAdapter(UtxoDataAdapter());
  Hive.registerAdapter(UtxoObjectAdapter());
  Hive.registerAdapter(StatusAdapter());

  // reference lookup data adapter
  Hive.registerAdapter(TradeWalletLookupAdapter());

  // node model adapter
  Hive.registerAdapter(NodeModelAdapter());

  // epic box model adapters
  Hive.registerAdapter(EpicBoxServerModelAdapter());

  await Hive.initFlutter(appDirectory.path);

  await Hive.openBox<dynamic>(DB.boxNameDBInfo);
  int dbVersion = DB.instance.get<dynamic>(
          boxName: DB.boxNameDBInfo, key: "hive_data_version") as int? ??
      0;
  if (dbVersion < Constants.currentHiveDbVersion) {
    try {
      await DbVersionMigrator().migrate(dbVersion);
    } catch (e, s) {
      Logging.instance.log("Cannot migrate database\n$e $s",
          level: LogLevel.Error, printFullLength: true);
    }
  }

  await Hive.openBox<dynamic>(DB.boxNameTheme);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);

  runApp(const ProviderScope(child: MyApp()));
}

/// MyApp initialises relevant services with a MultiProvider
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeService = LocaleService();
    localeService.loadLocale();

    return const KeyboardDismisser(
      child: MaterialAppWithTheme(),
    );
  }
}

// Sidenote: MaterialAppWithTheme and InitView are only separated for clarity. No other reason.

class MaterialAppWithTheme extends ConsumerStatefulWidget {
  const MaterialAppWithTheme({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MaterialAppWithTheme> createState() =>
      _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends ConsumerState<MaterialAppWithTheme>
    with WidgetsBindingObserver {
  // static const platform = MethodChannel("STACK_WALLET_RESTORE");
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final Prefs _prefs;
  late final NodeService _nodeService;

  late final Completer<void> loadingCompleter;

  bool didLoad = false;

  Future<void> load() async {
    try {
      if (didLoad) {
        return;
      }
      didLoad = true;

      await DB.instance.init();
      await _prefs.init();

      final familiarity = ref.read(prefsChangeNotifierProvider).familiarity + 1;
      ref.read(prefsChangeNotifierProvider).familiarity = familiarity;
      Constants.exchangeForExperiencedUsers(familiarity);

      _nodeService = ref.read(nodeServiceChangeNotifierProvider);

      unawaited(ref.read(baseCurrenciesProvider).update());

      await _nodeService.updateDefaults();
      await _nodeService.updateDefaultEpicBoxes();
      ref.read(priceAnd24hChangeNotifierProvider).start(true);

      final walletInfo =
          await ref.read(walletsServiceChangeNotifierProvider).walletNames;

      if (walletInfo.isNotEmpty) {
        if (walletInfo.entries.length > 1) {
          Logging.instance.log(
            "MORE THAN ONE WALLET: $walletInfo",
            level: LogLevel.Fatal,
          );
        }
        final info = walletInfo.values.first;

        ref.read(walletStateProvider.state).state = Manager(
          EpicCashWallet(
            walletId: info.walletId,
            walletName: info.name,
            coin: info.coin,
          ),
        );
        await ref.read(walletProvider)!.initializeExisting();
        ref.read(txCountOnStartUpProvider.state).state =
            ref.read(walletProvider)!.txCount;
      }

      loadingCompleter.complete();
    } catch (e, s) {
      Logger.print("$e $s", normalLength: false);
    }
  }

  @override
  void initState() {
    // final colorScheme = DB.instance
    //     .get<dynamic>(boxName: DB.boxNameTheme, key: "colorScheme") as String?;
    //
    // ThemeType themeType;
    // switch (colorScheme) {
    //   case "dark":
    //     themeType = ThemeType.dark;
    //     break;
    //   case "light":
    //   default:
    //     themeType = ThemeType.light;
    // }
    loadingCompleter = Completer();
    WidgetsBinding.instance.addObserver(this);
    // load locale and prefs
    ref
        .read(localeServiceChangeNotifierProvider.notifier)
        .loadLocale(notify: false);

    _prefs = ref.read(prefsChangeNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(colorThemeProvider.state).state =
          StackColors.fromStackColorTheme(DarkColors());
    });

    super.initState();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  InputBorder _buildOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(Constants.size.circularBorderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILD: $runtimeType");
    // ref.listen(shouldShowLockscreenOnResumeStateProvider, (previous, next) {
    //   Logging.instance.log("shouldShowLockscreenOnResumeStateProvider set to: $next",
    //       addToDebugMessagesDB: false);
    // });

    final colorScheme = ref.watch(colorThemeProvider.state).state;

    return MaterialApp(
      key: GlobalKey(),
      navigatorKey: navigatorKey,
      title: 'Epic Pay',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: colorScheme.textGold,
              brightness: Brightness.dark,
            ),
        extensions: [colorScheme],
        highlightColor: colorScheme.highlight,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        unselectedWidgetColor: colorScheme.radioButtonBorderDisabled,
        // textTheme: GoogleFonts.interTextTheme().copyWith(
        //   button: STextStyles.button(context),
        //   subtitle1: STextStyles.field(context).copyWith(
        //     color: colorScheme.textDark,
        //   ),
        // ),
        radioTheme: const RadioThemeData(
          splashRadius: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        // splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        buttonTheme: ButtonThemeData(
          splashColor: colorScheme.splash,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            // splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(colorScheme.splash),
            minimumSize: MaterialStateProperty.all<Size>(const Size(46, 46)),
            // textStyle: MaterialStateProperty.all<TextStyle>(
            //     STextStyles.button(context)),
            foregroundColor:
                MaterialStateProperty.all(colorScheme.buttonTextSecondary),
            backgroundColor: MaterialStateProperty.all<Color>(
                colorScheme.buttonBackSecondary),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                // 1000 to be relatively sure it keeps its pill shape
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
          ),
        ),
        primaryColor: colorScheme.accentColorDark,
        primarySwatch: Util.createMaterialColor(colorScheme.accentColorDark),
        checkboxTheme: CheckboxThemeData(
          splashRadius: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Constants.size.checkboxBorderRadius),
          ),
          checkColor: MaterialStateColor.resolveWith(
            (state) {
              if (state.contains(MaterialState.selected)) {
                return colorScheme.checkboxIconChecked;
              }
              return colorScheme.checkboxBGChecked;
            },
          ),
          fillColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return colorScheme.checkboxBGChecked;
              }
              return colorScheme.checkboxBorderEmpty;
            },
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          color: colorScheme.background,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: colorScheme.textFieldDefaultBG,
          fillColor: colorScheme.textFieldDefaultBG,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          // labelStyle: STextStyles.fieldLabel(context),
          // hintStyle: STextStyles.fieldLabel(context),
          enabledBorder:
              _buildOutlineInputBorder(colorScheme.textFieldDefaultBG),
          focusedBorder:
              _buildOutlineInputBorder(colorScheme.textFieldDefaultBG),
          errorBorder: _buildOutlineInputBorder(colorScheme.textFieldDefaultBG),
          disabledBorder:
              _buildOutlineInputBorder(colorScheme.textFieldDefaultBG),
          focusedErrorBorder:
              _buildOutlineInputBorder(colorScheme.textFieldDefaultBG),
        ),
      ),
      home: FutureBuilder(
        future: load(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // FlutterNativeSplash.remove();
            if (_prefs.hasPin && ref.read(walletProvider) != null) {
              return const LockscreenView(
                isInitialAppLogin: true,
                routeOnSuccess: HomeView.routeName,
                routeOnSuccessArguments: null,
                biometricsAuthenticationTitle: "Unlock Stack",
                biometricsLocalizedReason:
                    "Unlock your Epic wallet using biometrics",
                biometricsCancelButtonString: "Cancel",
              );
            } else {
              return const IntroView();
            }
          } else {
            // CURRENTLY DISABLED as cannot be animated
            // technically not needed as FlutterNativeSplash will overlay
            // anything returned here until the future completes but
            // FutureBuilder requires you to return something
            return const LoadingView();
          }
        },
      ),
    );
  }
}
