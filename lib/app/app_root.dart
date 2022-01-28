import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRoot extends StatefulWidget {
  const AppRoot();

  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          foregroundColor: Colors.grey.shade900,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        scaffoldBackgroundColor: Colors.grey.shade100,
        backgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme(
          primary: Colors.indigo.shade700,
          primaryVariant: Colors.indigo.shade900,
          secondary: Colors.pink.shade500,
          secondaryVariant: Colors.pink.shade900,
          surface: Colors.grey.shade200,
          background: Colors.grey.shade100,
          error: Colors.red,
          onPrimary: Colors.grey.shade100,
          onSecondary: Colors.grey.shade100,
          onSurface: Colors.grey.shade900,
          onBackground: Colors.grey.shade900,
          onError: Colors.grey.shade100,
          brightness: Brightness.light,
        ),
      ),
    ).modular();
  }
}
