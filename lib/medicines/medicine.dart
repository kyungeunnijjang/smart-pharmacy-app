import 'package:flutter/material.dart';

class MedicineDetailScreen extends StatelessWidget {
  final int id;
  const MedicineDetailScreen({super.key, required this.id});

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
