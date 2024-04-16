import 'dart:convert';

import 'package:hive/hive.dart';

part 'type_adaptors/epicbox_server_model.g.dart';

// @HiveType(typeId: 13)
class EpicBoxServerModel {
  // @HiveField(0)
  final String id;
  // @HiveField(1)
  final String host;
  // @HiveField(2)
  final int? port;
  // @HiveField(3)
  final String name;
  // @HiveField(4)
  final bool? useSSL;
  // @HiveField(5)
  final bool? enabled;
  // @HiveField(6)
  final bool? isFailover;
  // @HiveField(7)
  final bool? isDown;

  EpicBoxServerModel({
    required this.id,
    required this.host,
    this.port,
    required this.name,
    this.useSSL,
    this.enabled,
    this.isFailover,
    this.isDown,
  });

  EpicBoxServerModel copyWith({
    String? host,
    int? port,
    String? name,
    bool? useSSL,
    bool? enabled,
    bool? isFailover,
    bool? isDown,
  }) {
    return EpicBoxServerModel(
      id: id,
      host: host ?? this.host,
      port: port ?? this.port,
      name: name ?? this.name,
      useSSL: useSSL ?? this.useSSL,
      enabled: enabled ?? this.enabled,
      isFailover: isFailover ?? this.isFailover,
      isDown: isDown ?? this.isDown,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['host'] = host;
    map['port'] = port;
    map['name'] = name;
    map['useSSL'] = useSSL;
    map['enabled'] = enabled;
    map['isFailover'] = isFailover;
    map['isDown'] = isDown;
    return map;
  }

  bool get isDefault => id.startsWith("default_");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host,
      'port': port,
      'name': name,
      'useSSL': useSSL,
      'enabled': enabled,
      'isFailover': isFailover,
      'isDown': isDown,
    };
  }

  /// Lol required for libepiccash ffi
  @override
  String toString() => jsonEncode({
        'epicbox_domain': host,
        'epicbox_port': port,
        'epicbox_protocol_insecure': false,
        'epicbox_address_index': 0,
      });
}
