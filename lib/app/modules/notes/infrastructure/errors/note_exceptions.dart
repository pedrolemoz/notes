class NoteException implements Exception {
  final String? message;
  late final StackTrace stackTrace;

  NoteException({this.message, StackTrace? stackTrace}) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }
}
