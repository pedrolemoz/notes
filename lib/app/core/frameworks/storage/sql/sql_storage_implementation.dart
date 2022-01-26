import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'configuration/sql_configuration.dart';
import 'errors/sql_exceptions.dart';
import 'operations/sql_insert.dart';
import 'sql_storage.dart';

class SQFliteImplementation implements SQLStorage {
  late final Database _dataBase;

  Future<void> initializeDataBase() async {
    _dataBase = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (dataBase, version) async {
        for (var statement in SQLConfiguration.createTableStatements) {
          await dataBase.execute(statement.asQuery());
        }
      },
    );
  }

  @override
  Future<void> insert(SQLInsert parameters) async {
    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }

    if (parameters.data.isEmpty) {
      throw InvalidSQLValuesException();
    }

    await _dataBase.insert(parameters.tableName, parameters.data);
  }
}
