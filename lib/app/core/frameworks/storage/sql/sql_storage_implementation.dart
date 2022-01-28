import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'configuration/sql_configuration.dart';
import 'errors/sql_exceptions.dart';
import 'operations/sql_insert.dart';
import 'operations/sql_select.dart';
import 'sql_storage.dart';

class SQFliteImplementation implements SQLStorage {
  bool hasInitializedDataBase = false;
  final SQLConfiguration sqlConfiguration;
  late Database _dataBase;

  SQFliteImplementation(this.sqlConfiguration);

  @override
  Future<void> initializeDataBase() async {
    final path = await getDatabasesPath();

    _dataBase = await openDatabase(
      join(path, sqlConfiguration.dataBaseName()),
      version: sqlConfiguration.dataBaseVersion(),
      onOpen: (dataBase) => hasInitializedDataBase = true,
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
    if (!hasInitializedDataBase) {
      await initializeDataBase();
    }

    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }

    if (parameters.data.isEmpty) {
      throw InvalidSQLValuesException();
    }

    try {
      return await _dataBase.insert(parameters.tableName, parameters.data);
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> select(SQLSelect parameters) async {
    if (!hasInitializedDataBase) {
      await initializeDataBase();
    }

    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }

    if (parameters.columnMode == SQLSelectColumnMode.filteredColumns &&
            parameters.columns == null ||
        parameters.columns != null && parameters.columns!.isEmpty) {
      throw InvalidSQLColumnsException();
    }

    try {
      return await _dataBase.rawQuery(parameters.asQuery());
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }
}
