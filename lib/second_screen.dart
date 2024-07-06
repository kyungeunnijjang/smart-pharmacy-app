import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/medicine_page.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('처방전 없이 방문',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 13, 7, 7),
                fontFamily: "TEST")),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            //약구경
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicinePage()));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "약 구경",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  fontFamily: "TEST"),
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}
