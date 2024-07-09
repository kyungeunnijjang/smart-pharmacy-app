import 'package:flutter/material.dart';
import 'package:pharmacy_app/purchase_widget.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "구매 목록",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PurchaseWidget(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        ),
      ),
      // Add a green payment button below
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),
        onPressed: () {
          // Add your payment logic here
        },
        child: const Text('결제', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
