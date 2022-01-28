// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_creation_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteCreationController on _NoteCreationControllerBase, Store {
  final _$stateAtom = Atom(name: '_NoteCreationControllerBase.state');

  @override
  ControllerState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ControllerState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$createNewNoteAsyncAction =
      AsyncAction('_NoteCreationControllerBase.createNewNote');

  @override
  Future<void> createNewNote(String title, String content) {
    return _$createNewNoteAsyncAction
        .run(() => super.createNewNote(title, content));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
