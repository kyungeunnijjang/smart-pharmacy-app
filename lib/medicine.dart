import 'package:flutter/material.dart';

class Medicine extends StatelessWidget {
  const Medicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정보'),
      ),
      body: const Center(
        child: Text('타이레놀에 대한 정보가 여기에 표시됩니다.'),
      ),
    );
  }
}
