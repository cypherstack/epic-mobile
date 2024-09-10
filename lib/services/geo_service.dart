import 'dart:convert';

import 'package:country_state_city/country_state_city.dart';
import 'package:epicpay/services/guardarian/response_models/g_country.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:http/http.dart';

abstract final class GeoService {
  static List<Country> countries = [];
  static List<State> states = [];

  static Future<void> load() async {
    if (countries.isEmpty) {
      countries = await getAllCountries();
    }
    if (states.isEmpty) {
      states = await getAllStates();
    }
  }

  static Future<String?> externalIpCountryCode() async {
    try {
      final ipResponse = await get(Uri.parse("https://4.icanhazip.com/"));
      final dataResponse = await get(
        Uri.parse(
          "http://ipwho.is/${ipResponse.body}",
        ),
      );
      final data = jsonDecode(dataResponse.body);
      return data["country_code"] as String?;
    } catch (_) {
      try {
        Logging.instance.log(
          "Failed to determine country by external ip address",
          level: LogLevel.Warning,
        );
      } catch (_) {}
      return null;
    }
  }

  static List<GCountry> guardarianCountries = [];
}
