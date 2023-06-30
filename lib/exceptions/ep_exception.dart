// generic stack wallet exception which all other custom exceptions should
// extend from

class EPException implements Exception {
  EPException(this.message);

  final String message;

  @override
  toString() => message;
}
