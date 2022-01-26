import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'configuration/sql_configuration.dart';
import 'errors/sql_exceptions.dart';
import 'operations/sql_insert.dart';
import 'sql_storage.dart';

class SQFliteImplementation implements SQLStorage {
  final SQLConfiguration sqlConfiguration;
  late final Database _dataBase;

  SQFliteImplementation(this.sqlConfiguration);

  Future<void> initializeDataBase() async {
    _dataBase = await openDatabase(
      join(await getDatabasesPath(), sqlConfiguration.dataBaseName()),
      version: sqlConfiguration.dataBaseVersion(),
      onCreate: (dataBase, version) async {
        final statements = sqlConfiguration.createTableStatements();

        for (var statement in statements) {
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
