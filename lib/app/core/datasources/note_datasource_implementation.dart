import '../domain/entities/note.dart';
import '../frameworks/storage/sql/sql_storage.dart';
import '../infrastructure/datasources/note_datasource.dart';
import '../infrastructure/errors/note_exceptions.dart';
import '../infrastructure/mappers/note_mapper.dart';

class NoteDataSourceImplementation implements NoteDataSource {
  final SQLStorage sqlStorage;

  const NoteDataSourceImplementation(this.sqlStorage);

  @override
  Future<Note> createNewNote(Note note) async {
    try {
      final newNoteCode = await sqlStorage.insert(NoteMapper.toSQLInsert(note));

      return note.copyWith(code: newNoteCode);
    } catch (exception) {
      throw NoteException(message: '$exception');
    }
  }
}
