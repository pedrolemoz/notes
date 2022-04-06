import 'app_states.dart';

class CreatingNewNoteState implements ProcessingState {
  @override
  String? get message => 'Creating a new note';
}

class UnableToCreateNewNoteState implements ErrorState {
  @override
  late final String message;

  UnableToCreateNewNoteState({String? reason}) {
    message = reason ??
        'An error occurred while creating a new note due an internal error';
  }
}

class SuccessfullyCreatedNewNoteState implements SuccessState {
  @override
  String? get message => 'New note created successfully successfully';
}
