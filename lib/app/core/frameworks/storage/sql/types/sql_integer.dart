import 'sql_data_type.dart';

class SQLInteger extends SQLDataType {
  const SQLInteger({
    required String description,
    bool isAutoIncremented = false,
    bool isPrimaryKey = false,
    bool isForeignKey = false,
    bool isNotNull = true,
  }) : super(
          description: description,
          isAutoIncremented: isAutoIncremented,
          isPrimaryKey: isPrimaryKey,
          isForeignKey: isForeignKey,
          isNotNull: isNotNull,
        );

  @override
  String asQuery() {
    final query = StringBuffer('$description INTEGER');

    final superQuery = super.asQuery();

    if (superQuery != '' && superQuery.isNotEmpty) {
      query.write(superQuery);
    }

    return query.toString();
  }
}
