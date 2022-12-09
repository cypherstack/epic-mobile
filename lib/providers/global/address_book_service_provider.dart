import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicpay/services/address_book_service.dart';

final addressBookServiceProvider =
    ChangeNotifierProvider<AddressBookService>((ref) => AddressBookService());
