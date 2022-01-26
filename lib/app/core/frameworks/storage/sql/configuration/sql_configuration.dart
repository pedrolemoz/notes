import '../operations/sql_create_table.dart';

abstract class SQLConfiguration {
  String dataBaseName();
  int dataBaseVersion();
  List<SQLCreateTable> createTableStatements();
}
