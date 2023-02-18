import 'dart:convert';

import 'package:epicpay/pages/settings_views/epicbox_settings_view/manage_epicbox_views/add_edit_epicbox_view.dart';
import 'package:epicpay/utilities/logger.dart';
import 'package:http/http.dart' as http;

Future<bool> _testEpicBoxConnection(Uri uri) async {
  try {
    final client = http.Client();
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(milliseconds: 2000),
        onTimeout: () async => http.Response('Error', 408));

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json["node_version"] != null) {
      return true;
    } else {
      return false;
    }
  } catch (e, s) {
    Logging.instance.log("$e\n$s", level: LogLevel.Warning);
    return false;
  }
}

// returns node data with properly formatted host/url if successful, otherwise null
Future<EpicBoxFormData?> testEpicBoxConnection(EpicBoxFormData data) async {
  // TODO update function to test properly like Likho does with wscat
  if (data.host == null || data.port == null || data.useSSL == null) {
    return null;
  }
  const String path_postfix = "/v1/version";

  if (data.host!.startsWith("https://")) {
    data.useSSL = true;
  } else if (data.host!.startsWith("http://")) {
    data.useSSL = false;
  } else {
    if (data.useSSL!) {
      data.host = "https://${data.host!}";
    } else {
      data.host = "http://${data.host!}";
    }
  }

  Uri uri = Uri.parse(data.host! + path_postfix);

  uri = uri.replace(port: data.port);

  try {
    if (await _testEpicBoxConnection(uri)) {
      return data;
    } else {
      return null;
    }
  } catch (e, s) {
    Logging.instance.log("$e\n$s", level: LogLevel.Warning);
    return null;
  }
}
