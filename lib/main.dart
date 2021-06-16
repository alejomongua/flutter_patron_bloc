import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';
import 'package:patron_bloc/pages/home_page.dart';
import 'package:patron_bloc/pages/login_page.dart';
import 'package:patron_bloc/pages/product_page.dart';
import 'package:patron_bloc/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
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
