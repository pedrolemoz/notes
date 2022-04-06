import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/errors/note_failures.dart';
import '../../../domain/usecases/create_new_note.dart';
import '../events/note_creation_events.dart';
import '../states/app_states.dart';
import '../states/note_creation_states.dart';

class NoteCreationBloc extends Bloc<NoteCreationEvents, AppState>
    implements Disposable {
  final CreateNewNote _createNewNote;

  NoteCreationBloc(this._createNewNote) : super(IdleState()) {
    on<CreateNewNoteEvent>(_onCreateNewNoteEvent);
  }

  Future<void> _onCreateNewNoteEvent(
    CreateNewNoteEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(CreatingNewNoteState());

    final currentDateTime = DateTime.now();

    final note = Note(
      code: -1,
      title: event.content,
      content: event.content,
      creationDate: currentDateTime,
      modificationDate: currentDateTime,
    );

    final result = await _createNewNote(note);

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case InvalidNoteTitleFailure:
            emit(
              UnableToCreateNewNoteState(
                reason: 'The note title is invalid',
              ),
            );
            break;
          case InvalidNoteContentFailure:
            emit(
              UnableToCreateNewNoteState(
                reason: 'The note content is invalid',
              ),
            );
            break;
          default:
            emit(UnableToCreateNewNoteState());
        }
      },
      (success) => emit(SuccessfullyCreatedNewNoteState()),
    );
  }

  @override
  void dispose() => close();
}
