import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/note_failures.dart';
import '../../../../core/domain/repositories/note_repository.dart';

abstract class GetNotes {
  Future<Either<Failure, List<Note>>> call();
}

class GetNotesImplementation implements GetNotes {
  final NoteRepository repository;

  const GetNotesImplementation(this.repository);

  @override
  Future<Either<Failure, List<Note>>> call() async {
    try {
      return await repository.getNotes();
    } catch (exception) {
      return Left(NoteFailure(message: '$exception'));
    }
  }
}
