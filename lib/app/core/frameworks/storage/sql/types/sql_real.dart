import 'sql_data_type.dart';

class SQLReal extends SQLDataType {
  SQLReal({
    required String description,
    bool isPrimaryKey = false,
    bool isForeignKey = false,
    bool isNotNull = true,
  }) : super(
          description: description,
          isAutoIncremented: false,
          isPrimaryKey: isPrimaryKey,
          isForeignKey: isForeignKey,
          isNotNull: isNotNull,
        );

  @override
  String asQuery() {
    final query = StringBuffer('$description REAL');

    final superQuery = super.asQuery();

    if (superQuery != '' && superQuery.isNotEmpty) {
      query.write(superQuery);
    }

    return query.toString();
  }
}
