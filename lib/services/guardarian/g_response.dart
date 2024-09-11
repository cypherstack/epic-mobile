class GResponse<T> {
  final T? value;
  final Exception? exception;

  GResponse({this.value, this.exception})
      : assert((value == null && exception != null) ||
            (value != null && exception == null));

  @override
  String toString() {
    return value != null
        ? "GResponse<${value!.runtimeType}>($value)"
        : "GResponse<${exception!.runtimeType}>($exception)";
  }
}
