import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patron_bloc/secrets.dart';
import 'package:patron_bloc/utils/user_preferences.dart';

const GOOGLE_SIGN_UP_URL =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';
const GOOGLE_LOGIN_URL =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=';

class UserProvider {
  final _prefs = UserPreferences();

  Future<Map<String, dynamic>> create(String email, String password) async {
    final requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.parse('$GOOGLE_SIGN_UP_URL$FIREBASE_API_KEY');

    final response = await http.post(url, body: json.encode(requestData));

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.parse('$GOOGLE_LOGIN_URL$FIREBASE_API_KEY');

    final response = await http.post(url, body: json.encode(requestData));

    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final decodedResp = json.decode(response.body);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'payload': decodedResp['idToken']};
    }

    return {'ok': false, 'payload': decodedResp['error']['message']};
  }
}
