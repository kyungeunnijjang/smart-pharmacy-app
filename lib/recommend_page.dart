import 'package:flutter/material.dart';

class RecommendPage extends StatelessWidget {
  const RecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 약 구매'),
      ),
      body: const Center(
        child: Text('홈페이지 약 추천 구매'),
      ),
    );
  }
}
