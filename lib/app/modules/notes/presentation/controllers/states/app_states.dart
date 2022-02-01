abstract class AppState {
  final String? message;

  AppState({this.message});
}

abstract class ProcessingState extends AppState {
  ProcessingState(String message) : super(message: message);
}

abstract class SuccessState extends AppState {
  SuccessState(String message) : super(message: message);
}

abstract class ErrorState extends AppState {
  ErrorState(String message) : super(message: message);
}

class IdleState implements AppState {
  @override
  String? get message => 'Controller was initialized';
}
