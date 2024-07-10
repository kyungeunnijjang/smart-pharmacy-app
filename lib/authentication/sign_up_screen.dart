import 'package:flutter/material.dart';
import 'package:pharmacy_app/authentication/log_in_screen.dart';
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

  bool isValidEmail(String email) {
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
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 7, 7),
                        fontFamily: "TEST"),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
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
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 7, 7),
                        fontFamily: "TEST"),
                  ),
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
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 7, 7),
                        fontFamily: "TEST"),
                  ),
                )
              ],
            ),
          );
        },
      );
      return;
    }

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
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 7, 7),
                        fontFamily: "TEST"),
                  ),
                )
              ],
            ),
          );
        },
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '유효하지 않은 이메일 주소',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 13, 7, 7),
                fontFamily: "TEST"),
          ),
        ),
      );
      return;
    }

    if (!isValidName(username) ||
        !isValidName(password) ||
        !isValidName(passwordConfirm)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '아이디와 비밀번호는 영어와 숫자로만 이루어져야 합니다.',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 13, 7, 7),
                fontFamily: "TEST"),
          ),
        ),
      );
      return;
    }

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
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
        Text(
          "가입 정보를 입력하세요",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
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
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontFamily: "TEST",
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor:
                      const Color.fromARGB(255, 205, 218, 168).withOpacity(0.3),
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
                backgroundColor: const Color.fromARGB(255, 205, 218, 168),
                shadowColor: Colors.black, 
                elevation: 5,
              ),
              child: const Text(
                "중복확인",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(174, 0, 0, 0),
                    fontFamily: "TEST"),
              ),
            ),
          ],
        ),
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: "TEST"),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              hintText: "비밀번호",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: "TEST",
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor:
                  const Color.fromARGB(255, 205, 218, 168).withOpacity(0.3),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
        ),
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: "TEST"),
        ),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
              hintText: "비밀번호 재입력",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: "TEST",
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor:
                  const Color.fromARGB(255, 205, 218, 168).withOpacity(0.3),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
        ),
        const Text(
          '영어와 숫자만 입력 가능합니다.',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: "TEST"),
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: "이름",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: "TEST",
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor:
                  const Color.fromARGB(255, 205, 218, 168).withOpacity(0.3),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "이메일",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontFamily: "TEST",
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor:
                  const Color.fromARGB(255, 205, 218, 168).withOpacity(0.3),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const Text(
          '--@--.---의 형식으로 작성해주세요.',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: "TEST"),
        ),
        ElevatedButton(
          onPressed: () {
            signUp(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            minimumSize: const Size(double.infinity, 0),
            shadowColor: Colors.black, 
            elevation: 5,
          ),
          child: const Text(
            "회원가입",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(174, 0, 0, 0),
                fontFamily: "TEST"),
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
            const Text(
              "이미 계정이 있으신가요?",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 13, 7, 7),
                  fontFamily: "TEST"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInScreen()));
              },
              child: const Text(
                "로그인",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 205, 218, 168),
                    fontFamily: "TEST"),
              ),
            )
          ],
        )
      ],
    );
  }
}
