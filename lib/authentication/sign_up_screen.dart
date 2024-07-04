import 'package:flutter/material.dart';
import 'package:pharmacy_app/home/home_screen.dart';

import 'package:pharmacy_app/services/api_service.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // 추가: ApiService에서 bool 함수 checkId를 이용하여 틀린 경우 팝업 창을 띄우는 부분
  Future<void> CheckUsername(BuildContext context) async {}
  Future<void> signUp(BuildContext context) async {
    String username = _idController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String passwordConfirm = _confirmPasswordController.text;
    if (password != passwordConfirm) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '비밀번호가 다릅니다',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          );
        },
      );
    }

    await ApiService().postUsers(
      username: username,
      password: password,
      name: name,
      email: email,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: const InputDecoration(labelText: '아이디'),
                    ),
                  ),
                  ElevatedButton(
                    // 추가: 중복 확인 버튼
                    onPressed: () {
                      CheckUsername(context);
                    },
                    style: ElevatedButton.styleFrom(
                      // 초록색 배경
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10), // 버튼 내부 padding
                    ),
                    child: const Text('중복 확인'),
                  ),
                ],
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: '비밀번호 재입력'),
                obscureText: true,
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '이름'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '이메일'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp(context);
                },
                child: const Text('회원 가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
