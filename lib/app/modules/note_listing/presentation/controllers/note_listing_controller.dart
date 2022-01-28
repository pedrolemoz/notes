import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/note.dart';
import '../../../../core/presentation/controllers/controller_state.dart';
import '../../domain/usecases/get_notes.dart';

part 'note_listing_controller.g.dart';

class NoteListingController = _NoteListingControllerBase
    with _$NoteListingController;

abstract class _NoteListingControllerBase with Store {
  final GetNotes _getNotes;

  _NoteListingControllerBase(this._getNotes);

  @observable
  var state = ControllerState.idle;

  @observable
  var notes = <Note>[].asObservable();

  @action
  Future<void> getNotes() async {
    state = ControllerState.loading;

    final result = await _getNotes();

    result.fold(
      (failure) => state = ControllerState.error,
      (success) {
        notes = success.toList().asObservable();
        state = ControllerState.success;
      },
    );
  }
}
