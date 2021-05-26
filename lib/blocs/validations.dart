import 'dart:async';

class Validators {
  static final emailRegexp =
      RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String value, sink) {
      if (value.length >= 6) {
        sink.add(value);
        return;
      }

      sink.addError('Contraseña demasiado corta');
    },
  );
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, sink) {
    if (emailRegexp.hasMatch(value)) {
      sink.add(value);
      return;
    }

    sink.addError('Formato de correo electrónico incorrecto');
  });

  // Stream<bool> get formValidStream =>
  // Rx.combineLatest2(emailStream, passwStream, (e, p) => true);
}
