import '../../domain/entities/note.dart';

abstract class NoteDataSource {
  Future<List<Note>> getNotes();
  Future<Note> createNewNote(Note note);
}
