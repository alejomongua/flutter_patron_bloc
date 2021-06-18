import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';
import 'package:patron_bloc/pages/home_page.dart';
import 'package:patron_bloc/pages/login_page.dart';
import 'package:patron_bloc/pages/product_page.dart';
import 'package:patron_bloc/pages/register_page.dart';
import 'package:patron_bloc/utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _prefs = UserPreferences();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _prefs.token == '' ? LoginPage() : HomePage(),
        routes: {
          'home': (_) => HomePage(),
          'login': (_) => LoginPage(),
          'product': (_) => ProductPage(),
          'register': (_) => RegisterPage(),
        },
      ),
    );
  }
}
