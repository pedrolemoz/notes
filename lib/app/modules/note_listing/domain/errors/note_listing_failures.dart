import '../../../../core/domain/errors/failure.dart';

class InitializationFailure extends Failure {
  const InitializationFailure({String? message}) : super(message: message);
}
