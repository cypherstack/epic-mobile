class GException implements Exception {
  final int statusCode;
  final String code;
  final String message;

  GException({
    required this.statusCode,
    required this.code,
    required this.message,
  });

  factory GException.fromMap(Map<dynamic, dynamic> map) {
    try {
      return GException(
        statusCode: map["statusCode"] as int,
        code: map["code"] as String,
        message: map["message"] as String,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GException.fromMap");
    }
  }

  @override
  String toString() {
    return "GException(statusCode: $statusCode, code: $code, message: $message)";
  }
}
