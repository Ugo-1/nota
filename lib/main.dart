import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nota/utilities/theme_data.dart';
import 'package:nota/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const NotaApp());
}

class NotaApp extends StatelessWidget {
  const NotaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

