import 'dart:convert';

import 'package:hive/hive.dart';

import 'epicbox_server_model.dart';

part 'type_adaptors/epicbox_config_model.g.dart';

// @HiveType(typeId: 14)
class EpicBoxConfigModel {
  // @HiveField(1)
  final String host;
  // @HiveField(2)
  final int? port;
  // @HiveField(3)
  final bool? protocolInsecure;
  // @HiveField(4)
  final int? addressIndex;
  // @HiveField(5)
  final int? listenerInterval;
  // final String? id;
  // // @HiveField(6)
  // final String? name;

  EpicBoxConfigModel({
    required this.host,
    this.port,
    this.protocolInsecure,
    this.addressIndex,
    this.listenerInterval,
    // this.id,
    // this.name,
  });

  EpicBoxConfigModel copyWith({
    int? port,
    bool? protocolInsecure,
    int? addressIndex,
    // String? id,
    // String? name,
  }) {
    return EpicBoxConfigModel(
      host: host,
      port: this.port ?? 443,
      protocolInsecure: this.protocolInsecure ?? false,
      addressIndex: this.addressIndex ?? 0,
      listenerInterval: listenerInterval ?? 50,
      // id: id ?? this.id,
      // name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['epicbox_domain'] = host;
    map['epicbox_port'] = port ?? 443;
    map['epicbox_protocol_unsecure'] = protocolInsecure ?? false;
    map['epicbox_address_index'] = addressIndex ?? 0;
    map['epicbox_listener_interval'] = listenerInterval ?? 50;
    // map['id'] = id;
    // map['name'] = name;
    return map;
  }

  Map<String, dynamic> toJson() {
    return {
      'epicbox_domain': host,
      'epicbox_port': port ?? 443,
      'epicbox_protocol_unsecure': protocolInsecure ?? false,
      'epicbox_address_index': addressIndex ?? 0,
      'epicbox_listener_interval': listenerInterval ?? 50,
      // 'id': id,
      // 'name': name,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }

  static EpicBoxConfigModel fromString(String epicBoxConfigString) {
    dynamic _epicBox = json.decode(epicBoxConfigString);

    // handle old epicbox config formats
    final oldDomain = _epicBox["domain"] ?? "empty";
    if (oldDomain != "empty") {
      _epicBox['epicbox_domain'] = _epicBox['domain'];
    }
    final oldPort = _epicBox["port"] ?? "empty";
    if (oldPort != "empty") {
      _epicBox['epicbox_port'] = _epicBox['port'];
    }
    final oldProtocolInsecure = _epicBox["protocol_insecure"] ?? "empty";
    if (oldProtocolInsecure != "empty") {
      _epicBox['epicbox_protocol_unsecure'] = _epicBox['protocol_insecure'];
    }
    final oldAddressIndex = _epicBox["address_index"] ?? "empty";
    if (oldAddressIndex != "empty") {
      _epicBox['epicbox_address_index'] = _epicBox['address_index'];
    }

    _epicBox['epicbox_port'] ??= 443;
    _epicBox['epicbox_protocol_unsecure'] ??= false;
    _epicBox['epicbox_address_index'] ??= 0;
    _epicBox['epicbox_listener_interval'] ??= 50;

    return EpicBoxConfigModel(
      host: _epicBox['epicbox_domain'] as String,
      port: _epicBox['epicbox_port'] as int,
      protocolInsecure: _epicBox['epicbox_protocol_unsecure'] as bool,
      addressIndex: _epicBox['epicbox_address_index'] as int,
      listenerInterval: _epicBox['epicbox_listener_interval'] as int,
      // name: fields[5] as String,
      // id: fields[6] as String,
    );
  }

  static EpicBoxConfigModel fromServer(EpicBoxServerModel server,
      {bool? protocolInsecure, int? addressIndex}) {
    return EpicBoxConfigModel(
        host: server.host,
        port: server.port ?? 443,
        protocolInsecure: protocolInsecure ?? false,
        addressIndex: addressIndex ?? 0,
        listenerInterval: 50);
  }
}
