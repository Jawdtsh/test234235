import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = 'http://localhost:5000/api';
  final storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'user', value: json.encode(data['user']));
        return true;
      }
      throw Exception('Invalid credentials');
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
