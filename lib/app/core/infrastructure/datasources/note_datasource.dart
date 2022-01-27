import '../../domain/entities/note.dart';

abstract class NoteDataSource {
  Future<Note> createNewNote(Note note);
}
