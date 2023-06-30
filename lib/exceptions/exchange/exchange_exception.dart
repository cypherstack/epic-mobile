import 'package:epicpay/exceptions/ep_exception.dart';

enum ExchangeExceptionType { generic, serializeResponseError, orderNotFound }

class ExchangeException extends EPException {
  ExchangeExceptionType type;
  ExchangeException(super.message, this.type);

  @override
  String toString() {
    return message;
  }
}
