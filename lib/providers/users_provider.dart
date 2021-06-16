import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patron_bloc/secrets.dart';

const GOOGLE_LOGIN_URL =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';

class UserProvider {
  Future create(String email, String password) async {
    final requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.parse('$GOOGLE_LOGIN_URL$FIREBASE_API_KEY');

    final response = await http.post(url, body: json.encode(requestData));

    Map<String, dynamic> decodedResp = json.decode(response.body);

    print(decodedResp);
  }
}
