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
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ColdaeWonPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "콜대원",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PancolPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "판콜",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "소화기계약",
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
                        builder: (context) => const SohwajePage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "소화제",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WiyeomPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "위염약",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ByeonbiPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "변비약",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "건강",
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
                        builder: (context) => const HongsamPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "홍삼",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LemonaPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "영양제",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CheolbunjePage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "철분제",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "연고류",
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
                        builder: (context) => const MadekasolPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "마데카솔",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HusidinPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "후시딘",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HwasangPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "화상연고",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 205, 218, 168),
            ),
            child: const Text(
              "기타",
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
                        builder: (context) => const IngongnunmulPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "인공눈물",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SumyeonjePage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "수면제",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
