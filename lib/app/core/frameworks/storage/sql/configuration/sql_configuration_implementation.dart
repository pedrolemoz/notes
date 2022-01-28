import '../../../../infrastructure/mappers/note_mapper.dart';
import '../operations/sql_create_table.dart';
import 'sql_configuration.dart';

class SQLConfigurationImplementation implements SQLConfiguration {
  @override
  String dataBaseName() => 'notes_app.db';

  @override
  int dataBaseVersion() => 1;

  @override
  List<SQLCreateTable> createTableStatements() {
    return [NoteMapper.tableCreationStatement];
  }
}
