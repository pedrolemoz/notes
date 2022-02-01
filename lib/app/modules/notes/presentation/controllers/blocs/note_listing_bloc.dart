import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/usecases/get_notes.dart';
import '../events/note_listing_events.dart';
import '../states/app_states.dart';
import '../states/note_listing_states.dart';

class NoteListingBloc extends Bloc<NoteListingEvents, AppState>
    implements Disposable {
  final GetNotes _getNotes;

  NoteListingBloc(this._getNotes) : super(IdleState()) {
    on<FetchNotesEvent>(_onFetchNotesEvent);
    on<ClearAllNotesEvent>(_onClearAllNotesEvent);
  }

  var notes = <Note>[];

  Future<void> _onFetchNotesEvent(
    FetchNotesEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(FetchingNotesState());

    final result = await _getNotes();

    result.fold(
      (failure) => emit(UnableToFetchNotesState()),
      (success) {
        notes = success.toList();
        emit(SuccessfullyFetchedNotesState());
      },
    );
  }

  Future<void> _onClearAllNotesEvent(
    ClearAllNotesEvent event,
    Emitter<AppState> emit,
  ) async {
    notes.clear();

    emit(ClearedAllNotesState());
  }

  @override
  void dispose() => close();
}
