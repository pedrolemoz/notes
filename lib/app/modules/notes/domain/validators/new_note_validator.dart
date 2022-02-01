import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../errors/failure.dart';
import '../errors/note_failures.dart';

abstract class NewNoteValidator {
  Either<Failure, bool> hasValidNewNote(Note note);
  bool hasValidCode(int code);
  bool hasValidTitle(String title);
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

    if (!hasValidTitle(note.title)) {
      return Left(InvalidNoteTitleFailure());
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

    return const Right(true);
  }

  @override
  bool hasValidCode(int code) => code == -1;

  @override
  bool hasValidTitle(String title) => title != '' && title.isNotEmpty;

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
