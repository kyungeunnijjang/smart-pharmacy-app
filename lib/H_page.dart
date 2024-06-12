import 'package:flutter/material.dart';
import 'login_page.dart';

class HPage extends StatelessWidget {
  const HPage({super.key});

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

    String? validateInput(String value) {
      final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
      if (!validCharacters.hasMatch(value)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('입력 오류'),
              content: const Text('영어와 숫자만 입력 가능합니다.'),
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
        return '영어와 숫자만 입력 가능합니다.';
      }
      return null;
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
              onChanged: (value) {
                validateInput(value);
              },
            ),
            const Text(
              '영어와 숫자만 입력 가능합니다.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
              onChanged: (value) {
                validateInput(value);
              },
            ),
            const Text(
              '영어와 숫자만 입력 가능합니다.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: '비밀번호 재입력'),
              obscureText: true,
              onChanged: (value) {
                validateInput(value);
              },
            ),
            const Text(
              '영어와 숫자만 입력 가능합니다.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
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
