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

  Future<void> CheckUsername(BuildContext context) async {
    String username = _idController.text;
    if (await ApiService().checkId(username: username)) {
      // Username is available, proceed with sign up
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('사용 가능한 아이디입니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('이미 사용 중인 아이디입니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> signUp(BuildContext context) async {
    String username = _idController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String passwordConfirm = _confirmPasswordController.text;
    await ApiService().postUsers(
      username: username,
      password: password,
      name: name,
      email: email,
    );
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
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      return;
    }
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
                    onPressed: () {
                      CheckUsername(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
