import 'package:flutter/material.dart';
import 'auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HR Department',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.black38,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthPage(),
    );
  }
}