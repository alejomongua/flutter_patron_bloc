import 'package:flutter/material.dart';

bool validNumber(value) {
  if (value.isEmpty) return false;

  final number = num.tryParse(value);

  return number != null;
}

showAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Atención'),
      content: Text(message),
    ),
  );
}
