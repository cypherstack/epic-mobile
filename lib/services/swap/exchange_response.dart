class ExchangeResponse<T> {
  late final T? value;
  late final ExchangeException? exception;

  ExchangeResponse({this.value, this.exception});

  @override
  String toString() {
    return "{error: $exception, value: $value}";
  }
}

class ExchangeException implements Exception {
  final String message;
  final int? code;

  ExchangeException(this.message, [this.code]);

  @override
  String toString() {
    return "[code=$code]: $message";
  }
}
