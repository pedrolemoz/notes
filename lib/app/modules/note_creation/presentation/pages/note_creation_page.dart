import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/controller_state.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/input_field.dart';
import '../controllers/note_creation_controller.dart';

class NoteCreationPage extends StatelessWidget {
  final noteCreationController = Modular.get<NoteCreationController>();
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (noteCreationController.state == ControllerState.error) {
          SchedulerBinding.instance!.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      noteCreationController.errorMessage,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
          );
        }

        if (noteCreationController.state == ControllerState.success) {
          Modular.to.navigate('/');
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Create a new note'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              tooltip: 'Return',
              splashRadius: 24,
              onPressed: () {
                Modular.to.navigate('/');
              },
              icon: const Icon(
                UniconsLine.arrow_left,
                size: 28,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputField(
                  controller: titleTextController,
                  hintText: 'Add title',
                ),
                SizedBox(height: 16),
                InputField(
                  controller: contentTextController,
                  hintText: 'Add content',
                  maxLines: 20,
                ),
                SizedBox(height: 16),
                Button(
                  text: 'Create note',
                  enableIcon: true,
                  icon: UniconsLine.plus,
                  onPressed: () async {
                    await noteCreationController.createNewNote(
                      titleTextController.text,
                      contentTextController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
