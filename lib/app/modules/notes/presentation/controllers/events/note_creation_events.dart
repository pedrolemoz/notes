abstract class NoteCreationEvents {}

class CreateNewNoteEvent implements NoteCreationEvents {
  final String title;
  final String content;

  const CreateNewNoteEvent({required this.title, required this.content});
}
