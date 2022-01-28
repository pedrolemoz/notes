import '../../domain/entities/note.dart';
import '../../frameworks/storage/sql/operations/sql_create_table.dart';
import '../../frameworks/storage/sql/operations/sql_insert.dart';
import '../../frameworks/storage/sql/operations/sql_select.dart';
import '../../frameworks/storage/sql/types/sql_datetime.dart';
import '../../frameworks/storage/sql/types/sql_integer.dart';
import '../../frameworks/storage/sql/types/sql_text.dart';

class NoteMapper {
  static SQLInsert toSQLInsert(Note note) {
    return SQLInsert(
      tableName: 'NOTES',
      data: {
        'TITLE': note.title,
        'CONTENT': note.content,
        'CREATION_DATE': note.creationDate.toIso8601String(),
        'MODIFICATION_DATE': note.modificationDate.toIso8601String(),
      },
    );
  }

  static SQLSelect toSQLSelect() => SQLSelect(tableName: 'NOTES');

  static fromMap(Map<String, dynamic> map) {
    return Note(
      code: map['ID'],
      title: map['TITLE'],
      content: map['CONTENT'],
      creationDate: DateTime.parse(map['CREATION_DATE']),
      modificationDate: DateTime.parse(map['MODIFICATION_DATE']),
    );
  }

  static Note copyWith(
    Note note, {
    int? code,
    String? title,
    String? content,
    DateTime? creationDate,
    DateTime? modificationDate,
  }) {
    return Note(
      code: code ?? note.code,
      title: title ?? note.title,
      content: content ?? note.content,
      creationDate: creationDate ?? note.creationDate,
      modificationDate: modificationDate ?? note.modificationDate,
    );
  }

  static SQLCreateTable get tableCreationStatement => SQLCreateTable(
        tableName: 'NOTES',
        tableContents: [
          SQLInteger(
            description: 'ID',
            isPrimaryKey: true,
            isAutoIncremented: true,
          ),
          SQLText(description: 'TITLE'),
          SQLText(description: 'CONTENT'),
          SQLDateTime(description: 'CREATION_DATE'),
          SQLDateTime(description: 'MODIFICATION_DATE'),
        ],
      );
}
