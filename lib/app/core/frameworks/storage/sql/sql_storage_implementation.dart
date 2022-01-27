import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'configuration/sql_configuration.dart';
import 'errors/sql_exceptions.dart';
import 'operations/sql_insert.dart';
import 'operations/sql_select.dart';
import 'sql_storage.dart';

class SQFliteImplementation implements SQLStorage {
  final SQLConfiguration sqlConfiguration;
  Database? _dataBase;

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
  Future<int> insert(SQLInsert parameters) async {
    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }

    if (parameters.data.isEmpty) {
      throw InvalidSQLValuesException();
    }

    try {
      if (_dataBase == null || _dataBase!.isOpen == false) {
        await initializeDataBase();
      }

      return await _dataBase!.insert(parameters.tableName, parameters.data);
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> select(SQLSelect parameters) async {
    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }

    if (parameters.columnMode == SQLSelectColumnMode.filteredColumns &&
            parameters.columns == null ||
        parameters.columns!.isEmpty) {
      throw InvalidSQLColumnsException();
    }

    try {
      if (_dataBase == null || _dataBase!.isOpen == false) {
        await initializeDataBase();
      }

      return await _dataBase!.query(
        parameters.tableName,
        columns: parameters.columns,
      );
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }
}
