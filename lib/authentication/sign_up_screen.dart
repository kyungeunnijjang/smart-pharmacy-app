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

  void signUp(BuildContext context) async {
    String username = _idController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    // try {
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
    // } catch (e) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Builder(
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             content: const Text('아이디 또는 비밀번호가 잘못되었습니다.'),
    //             actions: [
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: const Text('닫기'),
    //               ),
    //             ],
    //           );
    //         },
    //       );
    //     },
    //   );
    // }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: const InputDecoration(labelText: '아이디'),
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
