import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/repositories/note_repository.dart';
import '../validators/new_note_validator.dart';

abstract class CreateNewNote {
  Future<Either<Failure, Note>> call(Note note);
}

class CreateNewNoteImplementation implements CreateNewNote {
  final NoteRepository repository;
  final NewNoteValidator validator;

  const CreateNewNoteImplementation(this.repository, this.validator);

  @override
  Future<Either<Failure, Note>> call(Note note) async {
    try {
      final result = validator.hasValidNewNote(note);

      return result.fold(
        (failure) => Left(failure),
        (success) async => await repository.createNewNote(note),
      );
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
