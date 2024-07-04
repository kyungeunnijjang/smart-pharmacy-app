import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'urls.dart' as urls;
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static const baseURL = urls.baseURL;

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    void signUp() async {
      String username = idController.text;
      String password = passwordController.text;
      String name = nameController.text;
      String email = emailController.text;
      String apiUrl = '$baseURL/api/v1/users/';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'username': username,
          'password': password,
          'name': name,
          'email': email,
        })),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('회원가입 실패'),
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

    // String? validateInput(String value) {
    //   final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    //   if (!validCharacters.hasMatch(value)) {
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('입력 오류'),
    //           content: const Text('영어와 숫자만 입력 가능합니다.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('닫기'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //     return '영어와 숫자만 입력 가능합니다.';
    //   }
    //   return null;
    // }

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: '아이디'),
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: '비밀번호 재입력'),
                obscureText: true,
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: '이름'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: '이메일'),
              ),
              const Text(
                '영어와 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                child: const Text('회원 가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
