import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/login_bloc.dart';
export 'package:patron_bloc/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider? _instance;

  factory Provider({Key? key, required Widget child}) {
    if (_instance == null) {
      _instance = Provider._(key: key, child: child);
    }

    return _instance!;
  }

  Provider._({Key? key, required this.child}) : super(key: key, child: child);

  final Widget child;
  final LoginBloc loginBloc = LoginBloc();

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) => true;
}
