import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pharmacy_app/models/token_model.dart';

class ApiService {
  final String baseUrl = "http://192.168.0.90:8000/api/v1";
  static const storage = FlutterSecureStorage();

  Future<bool> postUsers({
    required username,
    required password,
    required name,
    required email,
  }) async {
    final url = Uri.parse("$baseUrl/users/");
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonData);
      try {
        postToken(username: username, password: password);
        return true;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> postToken({
    required username,
    required password,
  }) async {
    final url = Uri.parse("$baseUrl/users/token/");
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      try {
        final token = TokenModel.fromJson(jsonData);
        await storage.write(key: 'access', value: token.access);
        await storage.write(key: 'refresh', value: token.refresh);
        return true;
      } catch (e) {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }
}
