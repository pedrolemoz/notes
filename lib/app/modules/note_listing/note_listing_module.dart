import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_notes.dart';
import 'presentation/controllers/note_listing_controller.dart';
import 'presentation/pages/note_listing_page.dart';

class NoteListingModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => GetNotesImplementation(i())),
        Bind((i) => NoteListingController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => NoteListingPage(),
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
