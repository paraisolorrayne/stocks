import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'authentication_token');
  }

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: 'authentication_token', value: token);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: 'authentication_token');
  }
}
