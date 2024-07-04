import 'package:flutter/material.dart';
import 'package:pharmacy_app/info_page.dart';

class MedicinePage extends StatelessWidget {
  const MedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약 구경'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "감기약",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 버튼들을 중앙에 배치
            children: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TylenolPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "타이레놀",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
