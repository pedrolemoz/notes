import 'package:dartz/dartz.dart';

import '../entities/note.dart';
import '../errors/failure.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> createNewNote(Note note);
}
