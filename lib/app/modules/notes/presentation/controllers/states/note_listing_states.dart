import 'app_states.dart';

class FetchingNotesState implements ProcessingState {
  @override
  String? get message => 'Fetching notes';
}

class UnableToFetchNotesState implements ErrorState {
  @override
  String? get message => 'An error occurred while fetching notes';
}

class SuccessfullyFetchedNotesState implements SuccessState {
  @override
  String? get message => 'Notes have been fetched successfully';
}

class ClearedAllNotesState implements SuccessState {
  @override
  String? get message => 'Cleared all notes';
}
