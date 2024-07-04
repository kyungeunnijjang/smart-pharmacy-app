import 'package:flutter/material.dart';
import 'package:pharmacy_app/services/api_service.dart';
import 'sign_up_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginPressed(BuildContext context) async {
    String username = _idController.text;
    String password = _passwordController.text;
    try {
      final userToken = await ApiService().postToken(
        username: username,
        password: password,
      );
      // GPT 너가 만들코드
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('아이디 또는 비밀번호가 잘못되었습니다.'),
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

  void _signUpPressed(BuildContext context) {
    // context를 매개변수로 추가

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
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
              onPressed: () => _loginPressed(context), // context 전달
              child: const Text('로그인'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _signUpPressed(context), // context 전달
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
