import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/frameworks/storage/sql/configuration/sql_configuration_implementation.dart';
import 'core/frameworks/storage/sql/sql_storage_implementation.dart';
import 'modules/notes/notes_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SQLConfigurationImplementation()),
        Bind((i) => SQFliteImplementation(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: NotesModule(),
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
