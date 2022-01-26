import '../../../../core/domain/errors/failure.dart';

class NoteCreationFailure extends Failure {
  const NoteCreationFailure({String? message}) : super(message: message);
}

class InvalidNoteCodeFailure extends NoteCreationFailure {}

class InvalidNoteContentFailure extends NoteCreationFailure {}

class InvalidNoteCreationDateFailure extends NoteCreationFailure {}

class InvalidNoteModificationDateFailure extends NoteCreationFailure {}
