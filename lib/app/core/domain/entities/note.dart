import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int code;
  final String content;
  final DateTime creationDate;
  final DateTime modificationDate;

  const Note({
    required this.code,
    required this.content,
    required this.creationDate,
    required this.modificationDate,
  });

  Duration get timeElapsedSinceCreation =>
      creationDate.difference(modificationDate);

  Note copyWith({
    int? code,
    String? content,
    DateTime? creationDate,
    DateTime? modificationDate,
  }) {
    return Note(
      code: code ?? this.code,
      content: content ?? this.content,
      creationDate: creationDate ?? this.creationDate,
      modificationDate: modificationDate ?? this.modificationDate,
    );
  }

  @override
  List<Object?> get props => [
        code,
        content,
        creationDate,
        modificationDate,
      ];
}
