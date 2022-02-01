import '../../../../core/frameworks/storage/sql/errors/sql_exceptions.dart';
import '../../../../core/frameworks/storage/sql/sql_storage.dart';
import '../../domain/entities/note.dart';
import '../../infrastructure/datasources/note_datasource.dart';
import '../../infrastructure/errors/note_exceptions.dart';
import '../../infrastructure/mappers/note_mapper.dart';

class NoteDataSourceImplementation implements NoteDataSource {
  final SQLStorage sqlStorage;

  const NoteDataSourceImplementation(this.sqlStorage);

  @override
  Future<Note> createNewNote(Note note) async {
    try {
      final newNoteCode = await sqlStorage.insert(NoteMapper.toSQLInsert(note));

      return NoteMapper.copyWith(note, code: newNoteCode);
    } on SQLException catch (exception) {
      throw NoteException(message: exception.message);
    } catch (exception) {
      throw NoteException(message: '$exception');
    }
  }

  @override
  Future<List<Note>> getNotes() async {
    try {
      final result = await sqlStorage.select(NoteMapper.toSQLSelect());

      return result.map<Note>((note) => NoteMapper.fromMap(note)).toList();
    } on SQLException catch (exception) {
      throw NoteException(message: exception.message);
    } catch (exception) {
      throw NoteException(message: '$exception');
    }
  }
}
