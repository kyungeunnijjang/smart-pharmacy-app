import 'package:flutter/material.dart';
import 'package:pharmacy_app/next_screen.dart';
import 'package:pharmacy_app/second_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.car_crash),
        title: const Text("방문 유형을 골라주세요"),
        actions: const [
          Icon(Icons.search),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 205, 218, 168),
              ),
              child: const Text(
                "처방전 방문",
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 205, 218, 168),
              ),
              child: const Text(
                "처방전 없이 방문",
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
