import '../types/sql_query.dart';

class SQLSelect implements SQLQuery {
  final SQLSelectColumnMode columnMode;
  final String tableName;
  final List<String>? columns;

  const SQLSelect({
    this.columnMode = SQLSelectColumnMode.allColumns,
    required this.tableName,
    this.columns,
  });

  @override
  String asQuery() {
    if (columnMode == SQLSelectColumnMode.allColumns) {
      return 'SELECT * FROM $tableName';
    } else {
      return 'SELECT ${columns!.reduce((a, b) => a += ', $b')} FROM $tableName';
    }
  }
}

enum SQLSelectColumnMode { allColumns, filteredColumns }
