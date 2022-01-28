import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/create_new_note.dart';
import 'domain/validators/new_note_validator.dart';
import 'presentation/controllers/note_creation_controller.dart';
import 'presentation/pages/note_creation_page.dart';

class NoteCreationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => NewNoteValidatorImplementation()),
        Bind((i) => CreateNewNoteImplementation(i(), i())),
        Bind((i) => NoteCreationController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => NoteCreationPage(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
          ),
        ),
      ];
}
