import 'package:flutter/material.dart';
import 'package:pharmacy_app/QR/doctor_qr_screen.dart';
import 'package:pharmacy_app/inventories/inventory_screen.dart';
import 'package:pharmacy_app/medicines/medicine_page.dart';
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
            title: const Text(
              '로그인 실패',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 13, 7, 7),
                  fontFamily: "TEST"),
            ),
            content: const Text(
              '아이디 또는 비밀번호가 잘못되었습니다.',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 13, 7, 7),
                  fontFamily: "TEST"),
            ),
            actions: [
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
        var inventory = await ApiService().getInventories();

        if (inventory.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  '구매 목록 확인',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                content: const Text(
                  '장바구니에 약이 있습니다. 구매하시겠습니까?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 13, 7, 7),
                      fontFamily: "TEST"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _goInventory(context);
                    },
                    child: const Text(
                      '예',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 13, 7, 7),
                          fontFamily: "TEST"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _goMedicine(context);
                    },
                    child: const Text(
                      '아니오',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 13, 7, 7),
                          fontFamily: "TEST"),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          _goMedicine(context);
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                '로그인 실패',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 13, 7, 7),
                    fontFamily: "TEST"),
              ),
              content: const Text(
                '아이디 또는 비밀번호가 잘못되었습니다.',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 13, 7, 7),
                    fontFamily: "TEST"),
              ),
              actions: [
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
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _signUpPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void _goMedicine(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MedicinePage(),
      ),
      (Route<dynamic> route) => false, // 추가된 부분
    );
  }

  void _goInventory(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const InventoryScreen(),
      ),
      (Route<dynamic> route) => false, // 추가된 부분
    );
  }

  // void _QrPressed(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const DoctorQrScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 추가
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
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
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
        Text(
          "로그인 정보를 입력하세요",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TextField(
        controller: _idController,
        decoration: InputDecoration(
            hintText: "아이디",
            hintStyle: const TextStyle(
              // hintStyle 추가

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
      const SizedBox(
        height: 20,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            hintText: "비밀번호",
            hintStyle: const TextStyle(
              // hintStyle 추가

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
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        onPressed: () => _loginPressed(context),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color.fromARGB(255, 205, 218, 168),
          shadowColor: Colors.black, // 그림자 색상 추가
          elevation: 5,
        ),
        child: const Text(
          "로그인",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(174, 0, 0, 0),
              fontFamily: "TEST"),
        ),
      ),
      // const SizedBox(
      //   height: 10,
      // ),
      // const Row(
      //   children: [
      //     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 8.0),
      //       child: Text('or'),
      //     ),
      //     Expanded(child: Divider(thickness: 1, color: Colors.grey)),
      //   ],
      // ),
      // const SizedBox(
      //   height: 10,
      // ),
      // ElevatedButton(
      //   onPressed: () => _QrPressed(context),
      //   style: ElevatedButton.styleFrom(
      //     shape: const StadiumBorder(),
      //     padding: const EdgeInsets.symmetric(vertical: 16),
      //     backgroundColor: const Color.fromARGB(255, 205, 218, 168),
      //     shadowColor: Colors.black, // 그림자 색상 추가
      //     elevation: 5,
      //   ),
      //   child: const Text(
      //     "진단서 qr",
      //     style: TextStyle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.w600,
      //         color: Color.fromARGB(174, 0, 0, 0),
      //         fontFamily: "TEST"),
      //   ),
      // ),
    ]);
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "계정이 없으신가요? ",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
        TextButton(
          onPressed: () => _signUpPressed(context),
          child: const Text(
            "가입하기",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 205, 218, 168),
                fontFamily: "TEST"),
          ),
        )
      ],
    );
  }
}
