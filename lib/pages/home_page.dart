import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Email: ${bloc.currentEmail}'),
              Text('Password: ${bloc.currentPassword}'),
            ],
          ),
        ),
      ),
    );
  }
}
