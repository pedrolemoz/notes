import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../errors/failure.dart';
import '../errors/note_failures.dart';
import '../repositories/note_repository.dart';

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
