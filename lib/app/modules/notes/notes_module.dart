import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_notes.dart';
import 'external/datasources/note_datasource_implementation.dart';
import 'infrastructure/repositories/note_repository_implementation.dart';
import 'presentation/controllers/blocs/note_listing_bloc.dart';
import 'presentation/pages/note_listing_page.dart';

class NotesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => NoteDataSourceImplementation(i())),
        Bind((i) => NoteRepositoryImplementation(i())),
        Bind((i) => GetNotesImplementation(i())),
        Bind((i) => NoteListingBloc(i())),
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
