import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int code;
  final String title;
  final String content;
  final DateTime creationDate;
  final DateTime modificationDate;

  const Note({
    required this.code,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.modificationDate,
  });

  Duration get timeElapsedSinceCreation =>
      creationDate.difference(DateTime.now());

  @override
  List<Object?> get props => [
        code,
        title,
        content,
        creationDate,
        modificationDate,
      ];
}
