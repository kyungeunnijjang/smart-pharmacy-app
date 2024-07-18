import 'package:flutter/material.dart';

class QtPurchaseScreen extends StatefulWidget {
  final List<String>? dataList;
  const QtPurchaseScreen({super.key, this.dataList});

  @override
  _QtPurchaseScreenState createState() => _QtPurchaseScreenState();
}

class _QtPurchaseScreenState extends State<QtPurchaseScreen> {
  List<Map<String, int>> inventory = [
    {"id": 3, "quantity": 2},
    {"id": 2, "quantity": 3},
    {"id": 5, "quantity": 2},
    {"id": 100, "quantity": 3},
    {"id": 2000, "quantity": 2},
  ];

  void clearText() {
    setState(() {
      inventory = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory List'),
      ),
      body: ListView.builder(
        itemCount: inventory.length,
        itemBuilder: (context, index) {
          final item = inventory[index];
          return ListTile(
            title: Text('ID: ${item["id"]}'),
            subtitle: Text('Quantity: ${item["quantity"]}'),
          );
        },
      ),
    );
  }
}

// QR 인식 후 화면을 여는 함수
void openQtPurchaseScreen(BuildContext context) {
  bool isScreenOpen = false;

  Navigator.of(context).popUntil((route) {
    if (route.settings.name == '/qtPurchaseScreen') {
      isScreenOpen = true;
    }
    return true;
  });

  if (!isScreenOpen) {
    Navigator.of(context).pushNamed('/qtPurchaseScreen');
  }

  // QR 인식 후 텍스트 지우기
  final state = context.findAncestorStateOfType<_QtPurchaseScreenState>();
  state?.clearText();
}
