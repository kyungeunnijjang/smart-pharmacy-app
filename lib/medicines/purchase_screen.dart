import 'package:flutter/material.dart';
import 'package:pharmacy_app/receipt_screen.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('결제 완료'),
          content: const Text('결제가 성공적으로 완료되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReceiptScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "구매 목록",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: "TEST"),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        ),
      ),
      // Add a green payment button below
      bottomNavigationBar: Container(
        //margin: const EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
                const Color.fromARGB(255, 205, 218, 168)),
          ),
          onPressed: () {
            _showPaymentDialog();
          },
          child: const Text('결제',
              style: TextStyle(
                  color: Color.fromARGB(174, 0, 0, 0), fontSize: 30.0)),
        ),
      ),
    );
  }
}
