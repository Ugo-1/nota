import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nota/core/services/locator_services.dart';
import 'package:nota/core/services/navigation_service.dart';
import 'package:nota/core/utilities/app_router.dart';
import 'package:nota/core/utilities/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const NotaApp(),
  );
}

class NotaApp extends StatelessWidget {
  const NotaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: AppRoute.allNotes,
      onGenerateRoute: AppRoute().onGenerateRoute,
    );
  }
}
