import 'package:flutter/material.dart';
import 'package:pharmacy_app/home/home_screen.dart';
import 'package:pharmacy_app/services/api_service.dart';
import 'sign_up_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginPressed(BuildContext context) async {
    String username = _idController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
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
    } else {
      try {
        await ApiService().postToken(
          username: username,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
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
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "로그인",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text("로그인 정보를 입력하세요"),
      ],
    );
  }

  _inputField(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(
        controller: _idController,
        decoration: InputDecoration(
            hintText: "아이디",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.green.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person)),
      ),
      const SizedBox(
        height: 20,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            hintText: "비밀번호",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.green.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password)),
        obscureText: true,
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: () => _loginPressed(context),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green,
        ),
        child: const Text(
          "로그인",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ]);
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("계정이 없으신가요? "),
        TextButton(
          onPressed: () => _signUpPressed(context),
          child: const Text(
            "가입하기",
            style: TextStyle(color: Colors.green),
          ),
        )
      ],
    );
  }
}
