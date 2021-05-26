import 'package:flutter/material.dart';
import 'package:patron_bloc/pages/home_page.dart';
import 'package:patron_bloc/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        'home': (_) => HomePage(),
        'login': (_) => LoginPage(),
      },
    );
  }
}