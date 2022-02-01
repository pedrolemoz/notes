import 'failure.dart';

class NoteFailure extends Failure {
  NoteFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}

class InvalidNoteCodeFailure extends NoteFailure {}

class InvalidNoteTitleFailure extends NoteFailure {}

class InvalidNoteContentFailure extends NoteFailure {}

class InvalidNoteCreationDateFailure extends NoteFailure {}

class InvalidNoteModificationDateFailure extends NoteFailure {}
