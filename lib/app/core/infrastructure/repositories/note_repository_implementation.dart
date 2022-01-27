import 'package:dartz/dartz.dart';

import '../../domain/entities/note.dart';
import '../../domain/errors/failure.dart';
import '../../domain/errors/note_failures.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_datasource.dart';

class NoteRepositoryImplementation implements NoteRepository {
  final NoteDataSource dataSource;

  const NoteRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, Note>> createNewNote(Note note) async {
    try {
      return Right(await dataSource.createNewNote(note));
    } catch (exception) {
      return Left(NoteFailure(message: exception.toString()));
    }
  }
}
