import 'package:flutter/material.dart';
import 'package:habit_app/features/splash/presentation/pages/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Default dark theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
