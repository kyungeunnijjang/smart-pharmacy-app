import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy_app/authentication/log_in_screen.dart';
// import 'package:pharmacy_app/second_screen.dart';
import 'package:pharmacy_app/medicines/medicine_page.dart';
import 'package:pharmacy_app/inventories/homepage_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "방문 유형을 선택하세요",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _loginbutton(context),
              // _home(context),
            ],
          ),
        ),
      ),
    );
  }
}

_loginbutton(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // ElevatedButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const QRScreen()),
      //     );
      //   },
      //   style: ElevatedButton.styleFrom(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(18),
      //     ),
      //     padding: const EdgeInsets.symmetric(vertical: 20),
      //     backgroundColor: const Color.fromARGB(255, 205, 218, 168),
      //     minimumSize: const Size(double.infinity, 0),
      //   ),
      //   child: const Text(
      //     "처방전 방문",
      //     style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 30,
      //         fontWeight: FontWeight.w500,
      //         fontFamily: "TEST"),
      //   ),
      // ),
      // const SizedBox(
      //   height: 80,
      // ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MedicinePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: const Color.fromARGB(255, 205, 218, 168),
          minimumSize: const Size(double.infinity, 0),
        ),
        child: const Text(
          "약 구경",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "TEST"),
        ),
      ),
      const SizedBox(
        height: 80,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InventoryScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 0),
        ),
        child: const Text(
          "홈페이지",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "TEST"),
        ),
      ),
    ],
  );
}

_home(context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            // IconButton으로 변경
            icon: const Icon(Icons.home), // 홈 모양 아이콘
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
          ),
        ],
      )
    ],
  );
}
