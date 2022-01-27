import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/errors/failure.dart';
import '../errors/note_creation_failures.dart';

abstract class NewNoteValidator {
  Either<Failure, bool> hasValidNewNote(Note note);
  bool hasValidCode(int code);
  bool hasValidContent(String content);
  bool hasValidCreationDate(DateTime creationDate);
  bool hasValidModificationDate(
    DateTime modificationDate,
    DateTime creationDate,
  );
}

class NewNoteValidatorImplementation implements NewNoteValidator {
  @override
  Either<Failure, bool> hasValidNewNote(Note note) {
    if (!hasValidCode(note.code)) {
      return Left(InvalidNoteCodeFailure());
    }

    if (!hasValidContent(note.content)) {
      return Left(InvalidNoteContentFailure());
    }

    if (!hasValidCreationDate(note.creationDate)) {
      return Left(InvalidNoteCreationDateFailure());
    }

    if (!hasValidModificationDate(note.modificationDate, note.creationDate)) {
      return Left(InvalidNoteModificationDateFailure());
    }

    return Right(true);
  }

  @override
  bool hasValidCode(int code) => code == -1;

  @override
  bool hasValidContent(String content) => content != '' && content.isNotEmpty;

  @override
  bool hasValidCreationDate(DateTime creationDate) =>
      !creationDate.isAfter(DateTime.now());

  @override
  bool hasValidModificationDate(
    DateTime modificationDate,
    DateTime creationDate,
  ) =>
      modificationDate.isAtSameMomentAs(creationDate);
}
