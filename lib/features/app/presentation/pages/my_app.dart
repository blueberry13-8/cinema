import 'package:cinema/features/app/presentation/pages/admin_overview_page.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const AdminOverviewPage(),
      home: const AuthPage(),
    );
  }
}