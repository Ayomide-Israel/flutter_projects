import 'package:flutter/material.dart';
import 'package:flutterproj/data/constants.dart';
import 'package:flutterproj/data/notifiers.dart';
import 'package:flutterproj/views/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

//MaterialApp
//Scaffold
//appBar
//bottomvavigationbar stateful

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initThemeMode();
    super.initState();
  }

  void initThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool(KConstants.themeModeKey);
    isDarkModeNotifier.value = repeat ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 34, 2, 66),
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WelcomePage(
            title: 'Welcome',
          ),
        );
      },
    );
  }
}
