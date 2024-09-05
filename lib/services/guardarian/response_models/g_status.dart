class GStatus {
  final String message;

  const GStatus({required this.message});

  static GStatus fromMap(Map<dynamic, dynamic> map) {
    try {
      return GStatus(
        message: map["message"] as String,
      );
    } catch (_) {
      throw Exception("Invalid json \"$map\" passed to GStatus.fromMap");
    }
  }

  @override
  String toString() {
    return "$runtimeType(message: $message)";
  }
}
