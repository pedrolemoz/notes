import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/external/datasources/note_datasource_implementation.dart';
import 'core/frameworks/storage/sql/configuration/sql_configuration_implementation.dart';
import 'core/frameworks/storage/sql/sql_storage_implementation.dart';
import 'core/infrastructure/repositories/note_repository_implementation.dart';
import 'modules/note_creation/note_creation_module.dart';
import 'modules/note_listing/note_listing_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SQLConfigurationImplementation()),
        Bind((i) => SQFliteImplementation(i())),
        Bind((i) => NoteDataSourceImplementation(i())),
        Bind((i) => NoteRepositoryImplementation(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: NoteListingModule(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
        ModuleRoute(
          '/note_creation',
          module: NoteCreationModule(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
      ];
}
