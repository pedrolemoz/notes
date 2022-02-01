class AppException implements Exception {
  final String? message;
  late final StackTrace stackTrace;

  AppException({this.message, StackTrace? stackTrace}) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }
}
