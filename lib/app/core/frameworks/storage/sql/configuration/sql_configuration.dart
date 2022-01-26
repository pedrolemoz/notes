import '../../../../infrastructure/mappers/note_mapper.dart';
import '../operations/sql_create_table.dart';

class SQLConfiguration {
  static List<SQLCreateTable> get createTableStatements {
    return [NoteMapper.createTable];
  }
}
