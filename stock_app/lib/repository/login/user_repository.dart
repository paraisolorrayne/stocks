import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = 'https://stock-server-theta.vercel.app/api';

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

  Future<Map<String, dynamic>> getPortfolio(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/portfolio'),
      headers: <String, String>{
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Handle error, throw exception or return a message
      throw Exception('Failed to load portfolio');
    }
  }

  // Implement other methods as needed...
}
