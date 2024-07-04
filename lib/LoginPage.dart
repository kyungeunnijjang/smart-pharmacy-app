import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart'; // FirstPage 클래스가 정의된 파일을 import
import 'SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'urls.dart' as urls;

// HPage 클래스가 정의된 파일을 import

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController _idController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void loginPressed() async {
    String id = _idController.text;
    String password = _passwordController.text;

    String apiUrl = '${SignUpPage.baseURL}/api/v1/users/token/';

    Future<void> saveData(response) async {
      _prefs.setString('refresh', response.body);
      _prefs.setString("access", response.body);
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(jsonEncode({
        'username': id,
        'password': password,
      })),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: Text('오류: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    }
  }

  void signUpPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginPressed,
              child: const Text('로그인'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: signUpPressed,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
