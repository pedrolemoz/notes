import 'package:equatable/equatable.dart';

import '../types/sql_query.dart';

class SQLInsert extends Equatable implements SQLQuery {
  final String tableName;
  final Map<String, dynamic> data;

  const SQLInsert({required this.tableName, required this.data});

  @override
  String asQuery() {
    final columns = data.keys.toList().reduce((a, b) => a += ', $b');
    final values = data.values.toList().reduce((a, b) => a += ', $b');

    return 'INSERT INTO $tableName ($columns) VALUES ($values);';
  }

  @override
  List<Object?> get props => [tableName, data];
}
