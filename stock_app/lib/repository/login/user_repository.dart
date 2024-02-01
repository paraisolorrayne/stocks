import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/constants/constants.dart';

class UserRepository {
  final String baseUrl = ApiConstants.baseUrl;

  Future<String> authenticate({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['session-token'];
    } else {
      // Handle error, throw exception or return a message
      throw Exception('Failed to authenticate');
    }
  }
}
