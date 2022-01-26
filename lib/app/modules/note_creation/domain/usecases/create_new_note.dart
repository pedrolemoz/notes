import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/repositories/note_repository.dart';
import '../errors/note_creation_failures.dart';

abstract class CreateNewNote {
  Future<Either<Failure, Note>> call(Note note);
}

class CreateNewNoteImplementation implements CreateNewNote {
  final NoteRepository repository;

  const CreateNewNoteImplementation(this.repository);

  @override
  Future<Either<Failure, Note>> call(Note note) async {
    try {
      if (note.code.isNegative) {
        return Left(InvalidNoteCodeFailure());
      }

      if (note.content == '' || note.content.isEmpty) {
        return Left(InvalidNoteContentFailure());
      }

      if (note.creationDate.isAfter(DateTime.now())) {
        return Left(InvalidNoteCreationDateFailure());
      }

      if (!note.modificationDate.isAtSameMomentAs(note.creationDate)) {
        return Left(InvalidNoteModificationDateFailure());
      }

      return await repository.createNewNote(note);
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
