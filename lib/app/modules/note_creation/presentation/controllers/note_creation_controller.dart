import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/presentation/controllers/controller_state.dart';
import '../../domain/errors/note_creation_failures.dart';
import '../../domain/usecases/create_new_note.dart';

part 'note_creation_controller.g.dart';

class NoteCreationController = _NoteCreationControllerBase
    with _$NoteCreationController;

abstract class _NoteCreationControllerBase with Store {
  final CreateNewNote _createNewNote;

  _NoteCreationControllerBase(this._createNewNote);

  @observable
  var state = ControllerState.idle;

  var errorMessage = 'An error ocurred';

  @action
  Future<void> createNewNote(String title, String content) async {
    state = ControllerState.loading;

    final now = DateTime.now();

    final note = Note(
      code: -1,
      title: title,
      content: content,
      creationDate: now,
      modificationDate: now,
    );

    final result = await _createNewNote(note);

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case InvalidNoteTitleFailure:
            errorMessage = 'A note must have a title';
            break;
          case InvalidNoteContentFailure:
            errorMessage = 'A note must have a content';
            break;
          default:
            errorMessage = 'An internal error ocurred';
        }
        state = ControllerState.error;
      },
      (success) => state = ControllerState.success,
    );
  }
}
