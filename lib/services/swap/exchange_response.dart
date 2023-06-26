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

  ExchangeException(this.message);

  @override
  String toString() {
    return message;
  }
}
