import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'sql_query.dart';

class SQLDataType extends Equatable implements SQLQuery {
  final String description;
  final bool isAutoIncremented;
  final bool isPrimaryKey;
  final bool isForeignKey;
  final bool isNotNull;

  const SQLDataType({
    required this.description,
    this.isAutoIncremented = false,
    this.isPrimaryKey = false,
    this.isForeignKey = false,
    this.isNotNull = true,
  });

  @override
  @mustCallSuper
  String asQuery() {
    final query = StringBuffer();

    if (isPrimaryKey) {
      query.write(' PRIMARY KEY');
    } else if (isForeignKey) {
      query.write(' FOREIGN KEY');
    }

    if (isAutoIncremented) {
      query.write(' AUTO INCREMENT');
    }

    if (isNotNull) {
      query.write(' NOT NULL');
    }

    return query.toString();
  }

  @override
  List<Object?> get props => [
        description,
        isAutoIncremented,
        isPrimaryKey,
        isForeignKey,
      ];
}
