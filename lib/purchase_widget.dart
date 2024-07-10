import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/purchase_screen.dart';

class PurchaseWidget extends StatefulWidget {
  const PurchaseWidget({super.key});

  @override
  State<PurchaseWidget> createState() => _PurchaseWidgetState();
}

class _PurchaseWidgetState extends State<PurchaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PurchaseScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
      body: const Placeholder(),
    );
  }
}