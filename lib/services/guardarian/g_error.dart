class GException implements Exception {
  final int statusCode;
  final int? code;
  final String codeName;
  final String message;

  GException({
    required this.statusCode,
    required this.code,
    required this.codeName,
    required this.message,
  });

  factory GException.fromMap(Map<dynamic, dynamic> map) {
    try {
      return GException(
        statusCode: map["httpStatusCode"] as int,
        code: map["statusCode"] as int?,
        codeName: map["code"] as String,
        message: map["message"] as String,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GException.fromMap");
    }
  }

  @override
  String toString() {
    return "GException("
        "statusCode: $statusCode, "
        "code: $code, "
        "codeName: $codeName, "
        "message: $message)";
  }
}
