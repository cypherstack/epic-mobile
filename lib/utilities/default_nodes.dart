import 'dart:convert';

import 'package:epicmobile/models/node_model.dart';
import 'package:epicmobile/utilities/enums/coin_enum.dart';

abstract class DefaultNodes {
  static String _nodeId(Coin coin) => "default_${coin.name}";
  static const String defaultName = "Stack Default";

  static List<NodeModel> get all => [
        epicCash,
      ];

  static NodeModel get epicCash => NodeModel(
        host: "http://epiccash.epicmobile.com",
        port: 3413,
        name: defaultName,
        id: _nodeId(Coin.epicCash),
        useSSL: false,
        enabled: true,
        coinName: Coin.epicCash.name,
        isFailover: true,
        isDown: false,
      );

  static NodeModel getNodeFor(Coin coin) {
    switch (coin) {
      case Coin.epicCash:
        return epicCash;
    }
  }

  static final String defaultEpicBoxConfig = jsonEncode({
    "domain": "209.127.179.199",
    "port": 13420,
  });
}
