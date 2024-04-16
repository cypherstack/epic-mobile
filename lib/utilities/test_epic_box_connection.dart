import 'package:epicpay/utilities/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<bool> _testEpicBoxConnection(String host, int port) async {
  WebSocketChannel? channel;
  try {
    final uri = Uri.parse('wss://$host:$port');

    channel = WebSocketChannel.connect(
      uri,
    );

    await channel.ready;

    final response = await channel.stream.first.timeout(
      const Duration(seconds: 2),
    );

    return response is String && response.contains("Challenge");
  } catch (_) {
    Logging.instance.log(
      "_testEpicBoxConnection failed on \"$host:$port\"",
      level: LogLevel.Info,
    );
    return false;
  } finally {
    await channel?.sink.close();
  }
}

// returns node data with properly formatted host/url if successful, otherwise null
Future<EpicBoxFormData?> testEpicBoxConnection(EpicBoxFormData data) async {
  // TODO update function to test properly like Likho does with wscat
  if (data.host == null || data.port == null) {
    return null;
  }

  try {
    if (await _testEpicBoxConnection(data.host!, data.port!)) {
      return data;
    } else {
      return null;
    }
  } catch (e, s) {
    Logging.instance.log("$e\n$s", level: LogLevel.Warning);
    return null;
  }
}

class EpicBoxFormData {
  String? name, host, login, password;
  int? port;
  bool? useSSL, isFailover;

  @override
  String toString() {
    return "{ name: $name, host: $host, port: $port, useSSL: $useSSL }";
  }
}
