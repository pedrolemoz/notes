import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../controllers/blocs/note_creation_bloc.dart';
import '../controllers/blocs/note_listing_bloc.dart';
import '../controllers/events/note_creation_events.dart';
import '../controllers/events/note_listing_events.dart';
import '../controllers/states/app_states.dart';
import '../widgets/note_card.dart';
import '../widgets/note_card_shimmer.dart';

class NoteListingPage extends StatefulWidget {
  @override
  State<NoteListingPage> createState() => _NoteListingPageState();
}

class _NoteListingPageState extends State<NoteListingPage> {
  final noteListingBloc = Modular.get<NoteListingBloc>();
  final noteCreationBloc = Modular.get<NoteCreationBloc>();

  @override
  void initState() {
    noteListingBloc.add(FetchNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCreationBloc, AppState>(
      bloc: noteCreationBloc,
      listener: (context, state) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.message!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
      },
      child: BlocConsumer<NoteListingBloc, AppState>(
        bloc: noteListingBloc,
        listener: (context, state) {
          if (noteListingBloc.state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'An error ocurred',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProcessingState) {
            return _NoteListingSkeleton(
              noteListingBloc: noteListingBloc,
              noteCreationBloc: noteCreationBloc,
              child: ListView.separated(
                itemCount: 5,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) => NoteCardShimmer(),
              ),
            );
          }

          return _NoteListingSkeleton(
            noteListingBloc: noteListingBloc,
            noteCreationBloc: noteCreationBloc,
            child: RefreshIndicator(
              onRefresh: () async => noteListingBloc.add(FetchNotesEvent()),
              child: ListView.separated(
                itemCount: noteListingBloc.notes.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final note = noteListingBloc.notes.elementAt(index);

                  return NoteCard(note: note);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NoteListingSkeleton extends StatelessWidget {
  final NoteListingBloc noteListingBloc;
  final NoteCreationBloc noteCreationBloc;
  final Widget child;

  const _NoteListingSkeleton({
    required this.noteListingBloc,
    required this.noteCreationBloc,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          noteCreationBloc.add(
            const CreateNewNoteEvent(
              title: '',
              content: '',
            ),
          );
        },
        label: const Text('Create new note'),
        icon: const Icon(UniconsLine.plus),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 250),
          child: child,
        ),
      ),
    );
  }
}
