import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/controller_state.dart';
import '../controllers/note_listing_controller.dart';
import '../widgets/note_card.dart';

class NoteListingPage extends StatefulWidget {
  @override
  State<NoteListingPage> createState() => _NoteListingPageState();
}

class _NoteListingPageState extends State<NoteListingPage> {
  final noteListingController = Modular.get<NoteListingController>();

  @override
  void initState() {
    noteListingController.getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (noteListingController.state == ControllerState.error) {
          SchedulerBinding.instance!.addPostFrameCallback(
            (_) {
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
            },
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text('Notes')),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Modular.to.navigate('/note_creation/'),
            label: Text('Create new note'),
            icon: Icon(UniconsLine.plus),
          ),
          body: noteListingController.notes.isEmpty
              ? Center(
                  child: Text(
                    'Nothing to show',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.separated(
                  itemCount: noteListingController.notes.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final note = noteListingController.notes.elementAt(index);

                    return NoteCard(note: note);
                  },
                ),
        );
      },
    );
  }
}
