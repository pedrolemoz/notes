// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_listing_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteListingController on _NoteListingControllerBase, Store {
  final _$stateAtom = Atom(name: '_NoteListingControllerBase.state');

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

  final _$notesAtom = Atom(name: '_NoteListingControllerBase.notes');

  @override
  ObservableList<Note> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<Note> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  final _$getNotesAsyncAction =
      AsyncAction('_NoteListingControllerBase.getNotes');

  @override
  Future<void> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  @override
  String toString() {
    return '''
state: ${state},
notes: ${notes}
    ''';
  }
}
