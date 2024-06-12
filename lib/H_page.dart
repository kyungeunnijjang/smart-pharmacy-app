import 'package:flutter/material.dart';
import 'login_page.dart';

class HPage extends StatefulWidget {
  const HPage({super.key});

  @override
  State<HPage> createState() => _HPageState();
}

class _HPageState extends State<HPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void _verify() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: '인증번호'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verify,
              child: const Text('인증하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    void login() {
      if (passwordController.text == confirmPasswordController.text) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('로그인 확인'),
              content: const Text('비밀번호가 일치합니다. 로그인 화면으로 돌아가시겠습니까?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('알겠습니다'),
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('비밀번호가 다릅니다.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: '비밀번호 재입력'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('로그인하기'),
            ),
          ],
        ),
      ),
    );
  }
}
