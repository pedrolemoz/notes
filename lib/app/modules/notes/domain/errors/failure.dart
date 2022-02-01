import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  late final StackTrace stackTrace;

  Failure({this.message, StackTrace? stackTrace}) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }

  @override
  List<Object?> get props => [message, stackTrace];
}
