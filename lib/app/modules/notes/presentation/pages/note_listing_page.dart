import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/frameworks/storage/sql/sql_storage_implementation.dart';
import '../../domain/entities/note.dart';
import '../../infrastructure/mappers/note_mapper.dart';
import '../controllers/blocs/note_listing_bloc.dart';
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

  @override
  void initState() {
    noteListingBloc.add(FetchNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteListingBloc, AppState>(
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
        // state = FetchingNotesState();

        if (state is ProcessingState) {
          return _NoteListingSkeleton(
            noteListingBloc: noteListingBloc,
            child: ListView.separated(
              itemCount: 5,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) => NoteCardShimmer(),
            ),
          );
        }

        return _NoteListingSkeleton(
          noteListingBloc: noteListingBloc,
          child: RefreshIndicator(
            onRefresh: () async => noteListingBloc.add(FetchNotesEvent()),
            child: ListView.separated(
              itemCount: noteListingBloc.notes.length,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final note = noteListingBloc.notes.elementAt(index);

                return NoteCard(note: note);
              },
            ),
          ),
        );
      },
    );
  }
}

class _NoteListingSkeleton extends StatelessWidget {
  final NoteListingBloc noteListingBloc;
  final Widget child;

  const _NoteListingSkeleton({
    required this.noteListingBloc,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final now = DateTime.now();

          final note = Note(
            code: -1,
            title: 'Título de teste',
            content: 'Conteúdo de teste',
            creationDate: now,
            modificationDate: now,
          );

          await Modular.get<SQFliteImplementation>()
              .insert(NoteMapper.toSQLInsert(note));

          noteListingBloc.add(FetchNotesEvent());
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
