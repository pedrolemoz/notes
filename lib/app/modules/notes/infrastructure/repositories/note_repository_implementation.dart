import 'package:dartz/dartz.dart';

import '../../domain/entities/note.dart';
import '../../domain/errors/failure.dart';
import '../../domain/errors/note_failures.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_datasource.dart';
import '../errors/note_exceptions.dart';

class NoteRepositoryImplementation implements NoteRepository {
  final NoteDataSource dataSource;

  const NoteRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, Note>> createNewNote(Note note) async {
    try {
      return Right(await dataSource.createNewNote(note));
    } on NoteException catch (exception) {
      return Left(NoteFailure(message: exception.message));
    } catch (exception) {
      return Left(NoteFailure(message: '$exception'));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      return Right(await dataSource.getNotes());
    } on NoteException catch (exception) {
      return Left(NoteFailure(message: exception.message));
    } catch (exception) {
      return Left(NoteFailure(message: '$exception'));
    }
  }
}
