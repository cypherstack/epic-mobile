// import 'package:epicpay/models/contact_address_entry.dart';
import 'package:decimal/decimal.dart';
import 'package:epicpay/models/exchange/estimate.dart';
import 'package:epicpay/models/exchange/incomplete_exchange.dart';
import 'package:epicpay/models/isar/models/exchange/trade.dart';
import 'package:epicpay/models/paymint/transactions_model.dart';
import 'package:epicpay/pages/add_wallet_views/create_restore_wallet_view.dart';
import 'package:epicpay/pages/add_wallet_views/restore_wallet_view/restore_options_view/restore_options_view.dart';
import 'package:epicpay/pages/add_wallet_views/restore_wallet_view/restore_wallet_view.dart';
import 'package:epicpay/pages/buy_view/buy_view.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_refund_address_entry.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_1.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_2.dart';
import 'package:epicpay/pages/buy_view/buy_with_crypto_flow/buy_with_crypto_step_3.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_1.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_2.dart';
import 'package:epicpay/pages/buy_view/buy_with_fiat_flow/buy_with_fiat_step_3.dart';
import 'package:epicpay/pages/buy_view/confirm_crypto_buy_view.dart';
import 'package:epicpay/pages/buy_view/fiat_buy_details_view.dart';
import 'package:epicpay/pages/buy_view/fiat_country_unsupported_view.dart';
import 'package:epicpay/pages/exchange_view/edit_trade_note_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/confirm_send_details_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_1_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_2_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_3_view.dart';
import 'package:epicpay/pages/exchange_view/exchange_step_views/step_4_view.dart';
import 'package:epicpay/pages/exchange_view/trade_details_view.dart';
// import 'package:epicpay/pages/address_book_views/address_book_view.dart';
// import 'package:epicpay/pages/address_book_views/subviews/add_address_book_entry_view.dart';
// import 'package:epicpay/pages/address_book_views/subviews/edit_contact_address_view.dart';
import 'package:epicpay/pages/help/help_view.dart';
import 'package:epicpay/pages/home_view/home_view.dart';
import 'package:epicpay/pages/intro_view.dart';
import 'package:epicpay/pages/pinpad_views/create_pin_view.dart';
import 'package:epicpay/pages/receive_view/generate_receiving_uri_qr_code_view.dart';
import 'package:epicpay/pages/receive_view/receive_view.dart';
import 'package:epicpay/pages/send_view/send_amount_view.dart';
import 'package:epicpay/pages/send_view/send_view.dart';
import 'package:epicpay/pages/settings_views/advanced_views/debug_view.dart';
import 'package:epicpay/pages/settings_views/currency_view.dart';
import 'package:epicpay/pages/settings_views/delete_account_view.dart';
import 'package:epicpay/pages/settings_views/epicbox_settings_view/epicbox_settings_view.dart';
import 'package:epicpay/pages/settings_views/epicbox_settings_view/manage_epicbox_views/add_edit_epicbox_view.dart';
import 'package:epicpay/pages/settings_views/hidden_settings.dart';
import 'package:epicpay/pages/settings_views/language_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/manage_nodes_views/add_edit_node_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/manage_nodes_views/coin_nodes_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/manage_nodes_views/manage_nodes_view.dart';
import 'package:epicpay/pages/settings_views/network_settings_view/network_settings_view.dart';
import 'package:epicpay/pages/settings_views/security_views/change_pin_view/change_pin_view.dart';
import 'package:epicpay/pages/settings_views/security_views/security_view.dart';
import 'package:epicpay/pages/settings_views/settings_view.dart';
import 'package:epicpay/pages/settings_views/wallet_backup_views/wallet_backup_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/confirm_delete_wallet_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/delete_wallet_recovery_phrase_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/refresh_period_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/verify_mnemonic_view.dart';
import 'package:epicpay/pages/settings_views/wallet_settings/wallet_settings_view.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/transaction_details_view.dart';
import 'package:epicpay/pages/wallet_view/transaction_views/transaction_search_filter_view.dart';
import 'package:epicpay/pages/wallet_view/wallet_view.dart';
import 'package:epicpay/services/guardarian/response_models/g_currency.dart';
import 'package:epicpay/services/guardarian/response_models/g_estimate.dart';
import 'package:epicpay/utilities/enums/coin_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class RouteGenerator {
  static const bool useMaterialPageRoute = true;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed into Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case IntroView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const IntroView(),
            settings: RouteSettings(name: settings.name));

      case CreateRestoreWalletView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const CreateRestoreWalletView(),
            settings: RouteSettings(name: settings.name));

      case DeleteAccountView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const DeleteAccountView(),
            settings: RouteSettings(name: settings.name));

      case HomeView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const HomeView(),
            settings: RouteSettings(name: settings.name));

      case CreatePinView.routeName:
        if (args is Tuple2<bool, bool>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => CreatePinView(
              popOnSuccess: args.item1,
              isNewWallet: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case SettingsView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const SettingsView(),
            settings: RouteSettings(name: settings.name));

      case HelpView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const HelpView(),
            settings: RouteSettings(name: settings.name));

      // case AddressBookView.routeName:
      //   if (args is void Function(String, String)) {
      //     return getRoute(
      //       shouldUseMaterialRoute: useMaterialPageRoute,
      //       builder: (_) => AddressBookView(
      //         onSendPressed: args,
      //       ),
      //       settings: RouteSettings(
      //         name: settings.name,
      //       ),
      //     );
      //   }
      //   return getRoute(
      //     shouldUseMaterialRoute: useMaterialPageRoute,
      //     builder: (_) => const AddressBookView(),
      //     settings: RouteSettings(
      //       name: settings.name,
      //     ),
      //   );

      case SecurityView.routeName:
        if (args is bool) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => SecurityView(
              biometrics: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const SecurityView(),
            settings: RouteSettings(name: settings.name));

      case ChangePinView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const ChangePinView(),
            settings: RouteSettings(name: settings.name));

      case BaseCurrencySettingsView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const BaseCurrencySettingsView(),
            settings: RouteSettings(name: settings.name));

      case LanguageSettingsView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const LanguageSettingsView(),
            settings: RouteSettings(name: settings.name));

      case DebugView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const DebugView(),
            settings: RouteSettings(name: settings.name));

      case ManageNodesView.routeName:
        return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => const ManageNodesView(),
            settings: RouteSettings(name: settings.name));

      // case AddAddressBookEntryView.routeName:
      //   return getRoute(
      //       shouldUseMaterialRoute: useMaterialPageRoute,
      //       builder: (_) => const AddAddressBookEntryView(),
      //       settings: RouteSettings(name: settings.name));

      case HiddenSettings.routeName:
        return getRoute(
            shouldUseMaterialRoute: false,
            builder: (_) => const HiddenSettings(),
            settings: RouteSettings(name: settings.name));

      case CoinNodesView.routeName:
        if (args is Coin) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => CoinNodesView(
              coin: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case AddEditNodeView.routeName:
        if (args is Tuple4<AddEditNodeViewType, Coin, String?, String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => AddEditNodeView(
              viewType: args.item1,
              coin: args.item2,
              nodeId: args.item3,
              routeOnSuccessOrDelete: args.item4,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case AddEditEpicBoxView.routeName:
        if (args is Tuple3<AddEditEpicBoxViewType, String?, String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => AddEditEpicBoxView(
              viewType: args.item1,
              epicBoxId: args.item2,
              routeOnSuccessOrDelete: args.item3,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      // case EditContactAddressView.routeName:
      //   if (args is Tuple2<String, ContactAddressEntry>) {
      //     return getRoute(
      //       shouldUseMaterialRoute: useMaterialPageRoute,
      //       builder: (_) => EditContactAddressView(
      //         contactId: args.item1,
      //         addressEntry: args.item2,
      //       ),
      //       settings: RouteSettings(
      //         name: settings.name,
      //       ),
      //     );
      //   }
      //   return _routeError("${settings.name} invalid args: ${args.toString()}");

      case NetworkSettingsView.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const NetworkSettingsView(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      case EpicBoxSettingsView.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const EpicBoxSettingsView(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      case WalletBackupView.routeName:
        if (args is Tuple2<String, List<String>>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => WalletBackupView(
              walletId: args.item1,
              mnemonic: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case WalletSettingsView.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const WalletSettingsView(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      case RefreshPeriodView.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const RefreshPeriodView(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      case RestoreOptionsView.routeName:
        if (args is Tuple2<String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => RestoreOptionsView(
              walletName: args.item1,
              coin: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case RestoreWalletView.routeName:
        if (args is Tuple4<String, Coin, int, DateTime>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => RestoreWalletView(
              walletName: args.item1,
              coin: args.item2,
              seedWordsLength: args.item3,
              restoreFromDate: args.item4,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case WalletView.routeName:
        if (args is String) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => WalletView(
              walletId: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case TransactionDetailsView.routeName:
        if (args is Tuple3<Transaction, Coin, String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => TransactionDetailsView(
              transaction: args.item1,
              coin: args.item2,
              walletId: args.item3,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case TransactionSearchFilterView.routeName:
        if (args is Coin) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => TransactionSearchFilterView(
              coin: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case ReceiveView.routeName:
        if (args is Tuple2<String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => ReceiveView(
              walletId: args.item1,
              coin: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyView.routeName:
        if (args is Tuple2<String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyView(
              walletId: args.item1,
              coin: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyWithCryptoStep1.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const BuyWithCryptoStep1(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      case BuyWithCryptoStep2.routeName:
        if (args is ({
          CryptoBuyOption option,
          Decimal min,
          Decimal max,
          Decimal usdtRate
        })) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyWithCryptoStep2(
              option: args.option,
              min: args.min,
              max: args.max,
              usdtRate: args.usdtRate,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyWithCryptoStep3.routeName:
        if (args is ({CryptoBuyOption option, Estimate estimate})) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyWithCryptoStep3(
              option: args.option,
              estimate: args.estimate,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyWithFiatStep1.routeName:
        if (args is (List<GCurrency>, GCurrency)) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyWithFiatStep1(
              currencies: args.$1,
              epic: args.$2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyWithFiatStep2.routeName:
        if (args is ({
          GCurrency option,
          GCurrency epic,
          Decimal min,
          Decimal max,
        })) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyWithFiatStep2(
              option: args.option,
              epic: args.epic,
              min: args.min,
              max: args.max,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyWithFiatStep3.routeName:
        if (args is ({
          GEstimate estimate,
          GCurrency option,
          GCurrency epic,
          Decimal sendAmount,
        })) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyWithFiatStep3(
              option: args.option,
              epic: args.epic,
              estimate: args.estimate,
              sendAmount: args.sendAmount,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      // case BuyWithFiatStep4.routeName:
      //   if (args is ({
      //     GEstimate estimate,
      //     GCurrency option,
      //     GCurrency epic,
      //     Decimal sendAmount,
      //   })) {
      //     return getRoute(
      //       shouldUseMaterialRoute: useMaterialPageRoute,
      //       builder: (_) => BuyWithFiatStep4(
      //         option: args.option,
      //         epic: args.epic,
      //         estimate: args.estimate,
      //         sendAmount: args.sendAmount,
      //       ),
      //       settings: RouteSettings(
      //         name: settings.name,
      //       ),
      //     );
      //   }
      //   return _routeError("${settings.name} invalid args: ${args.toString()}");

      case BuyRefundAddressEntry.routeName:
        if (args is ({CryptoBuyOption option, Estimate estimate})) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => BuyRefundAddressEntry(
              option: args.option,
              estimate: args.estimate,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case ConfirmCryptoBuyView.routeName:
        if (args is Trade) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => ConfirmCryptoBuyView(
              trade: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case SendView.routeName:
        if (args is Tuple2<String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => SendView(
              walletId: args.item1,
              coin: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case SendAmountView.routeName:
        if (args is Tuple3<String, String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => SendAmountView(
              walletId: args.item1,
              address: args.item2,
              coin: args.item3,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        } else if (args is Tuple3<String, String, Coin>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => SendAmountView(
              walletId: args.item1,
              address: args.item2,
              coin: args.item3,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case DeleteWalletRecoveryPhraseView.routeName:
        if (args is List<String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => DeleteWalletRecoveryPhraseView(
              mnemonic: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case VerifyMnemonicView.routeName:
        if (args is List<String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => VerifyMnemonicView(
              mnemonic: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case ConfirmWalletDeleteView.routeName:
        return getRoute(
          shouldUseMaterialRoute: useMaterialPageRoute,
          builder: (_) => const ConfirmWalletDeleteView(),
          settings: RouteSettings(
            name: settings.name,
          ),
        );

      // exchange steps

      case Step1View.routeName:
        if (args is IncompleteExchangeModel) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => Step1View(
              model: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case Step2View.routeName:
        if (args is IncompleteExchangeModel) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => Step2View(
              model: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case Step3View.routeName:
        if (args is IncompleteExchangeModel) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => Step3View(
              model: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case Step4View.routeName:
        if (args is IncompleteExchangeModel) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => Step4View(
              model: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case ConfirmSendDetails.routeName:
        if (args is IncompleteExchangeModel) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => ConfirmSendDetails(
              model: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case TradeDetailsView.routeName:
        if (args is ({
          String tradeId,
          Transaction? transactionIfSentFromStack,
          String? walletId,
          String? walletName,
          bool isBuy,
        })) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => TradeDetailsView(
              walletId: args.walletId,
              walletName: args.walletName,
              tradeId: args.tradeId,
              transactionIfSentFromStack: args.transactionIfSentFromStack,
              isBuy: args.isBuy,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case FiatBuyDetailsView.routeName:
        if (args is String) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => FiatBuyDetailsView(
              transactionId: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case FiatCountryUnsupportedView.routeName:
        if (args is String) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => FiatCountryUnsupportedView(
              unsupportedCountry: args,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case EditTradeNoteView.routeName:
        if (args is ({String tradeId, String note})) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => EditTradeNoteView(
              tradeId: args.tradeId,
              note: args.note,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      case GenerateUriQrCodeView.routeName:
        if (args is Tuple2<Coin, String>) {
          return getRoute(
            shouldUseMaterialRoute: useMaterialPageRoute,
            builder: (_) => GenerateUriQrCodeView(
              coin: args.item1,
              receivingAddress: args.item2,
            ),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
        }
        return _routeError("${settings.name} invalid args: ${args.toString()}");

      default:
        return _routeError("test");
    }
  }

  static Route<dynamic> getRoute({
    bool shouldUseMaterialRoute = useMaterialPageRoute,
    required Widget Function(BuildContext) builder,
    String? title,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    if (shouldUseMaterialRoute) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    } else {
      return CupertinoPageRoute(
        builder: builder,
        settings: settings,
        title: title,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    }
  }

  static Route<dynamic> createSlideTransitionRoute(Widget viewToInsert) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => viewToInsert,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _routeError(String message) {
    // Replace with robust ErrorView page
    Widget errorView = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Navigation error'),
      ),
      body: Center(
        child: Text(
            'Error handling route, this is not supposed to happen. Try restarting the app.\n$message'),
      ),
    );

    return getRoute(
        shouldUseMaterialRoute: useMaterialPageRoute,
        builder: (_) => errorView);
  }
}

class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute(this.child, RouteSettings settings) : _settings = settings;

  final Widget child;
  final RouteSettings _settings;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  RouteSettings get settings => _settings;
}
