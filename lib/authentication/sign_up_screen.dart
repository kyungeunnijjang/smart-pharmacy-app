import 'package:flutter/material.dart';
import 'package:pharmacy_app/authentication/log_in_screen.dart';
import 'package:pharmacy_app/home/home_screen.dart';

import 'package:pharmacy_app/services/api_service.dart';

class SignUpPage extends StatelessWidget {
  // 변수 추가
  SignUpPage({super.key});
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isValidEmail(String email) {
    // 이메일 주소의 유효성을 확인하는 정규 표현식
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidName(String password) {
    final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> CheckUsername(BuildContext context) async {
    String username = _idController.text;
    if (await ApiService().checkId(username: username)) {
      // Username is available, proceed with sign up
      // 변수 추가
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '사용 가능한 아이디 입니다.',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('닫기'),
                )
              ],
            ),
          );
        },
      );
    } else {
      // 변수 추가
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '이미 사용중인 아이디입니다.',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('닫기'),
                )
              ],
            ),
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

    if (username.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        passwordConfirm.isEmpty) {
      // 모든 칸을 입력하도록 메시지 표시
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '모든 입력란을 채워주세요',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('닫기'),
                )
              ],
            ),
          );
        },
      );
      return;
    }

    if (password != passwordConfirm) {
      // 비밀번호가 일치하지 않을 때 메시지 표시
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('닫기'),
                )
              ],
            ),
          );
        },
      );
      return;
    }

    if (!isValidEmail(email)) {
      // 올바른 이메일 형식이 아닐 때 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('유효하지 않은 이메일 주소'),
        ),
      );
      return;
    }

    if (!isValidName(username) ||
        !isValidName(password) ||
        !isValidName(passwordConfirm)) {
      // 올바른 이메일 형식이 아닐 때 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디와 비밀번호는 영어와 숫자로만 이루어져야 합니다.'),
        ),
      );
      return;
    }

    // 모든 조건이 충족되면 HomeScreen으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _signheader(context),
              _signinputField(context),
              _signlogin(context),
            ],
          ),
        ),
      ),
    );
  }

  _signheader(context) {
    return const Column(
      children: [
        Text(
          "회원가입",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text("가입 정보를 입력하세요"),
      ],
    );
  }

  _signinputField(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                  hintText: "아이디",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                CheckUsername(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "중복확인",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
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
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
              hintText: "비밀번호 재입력",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.green.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
        ),
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: "이름",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.green.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "이메일",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.green.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const Text(
          '--@--.---의 형식으로 작성해주세요.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        ElevatedButton(
          onPressed: () {
            signUp(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 0),
          ),
          child: const Text(
            "회원가입",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  _signlogin(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("이미 계정이 있으신가요?"),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
              child: const Text(
                "로그인",
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        )
      ],
    );
  }
}
