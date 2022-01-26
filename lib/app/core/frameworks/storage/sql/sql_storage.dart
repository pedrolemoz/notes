import 'operations/sql_insert.dart';

abstract class SQLStorage {
  Future<void> insert(SQLInsert parameters);
}
