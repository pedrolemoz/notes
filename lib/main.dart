import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_root.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppRoot(),
    ),
  );
}
