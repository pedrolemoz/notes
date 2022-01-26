import 'package:equatable/equatable.dart';

import '../types/sql_data_type.dart';
import '../types/sql_query.dart';

class SQLCreateTable extends Equatable implements SQLQuery {
  final String tableName;
  final List<SQLDataType> tableContents;

  SQLCreateTable({required this.tableName, required this.tableContents});

  @override
  String asQuery() =>
      'CREATE TABLE $tableName (${tableContents.map((e) => e.asQuery()).reduce((a, b) => a += ', $b')});';

  @override
  List<Object?> get props => [tableName, tableContents];
}
