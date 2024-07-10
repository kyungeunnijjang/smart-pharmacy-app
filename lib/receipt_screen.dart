import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/receipts_model.dart';
import 'package:pharmacy_app/services/api_service.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  List<String> receipts = [];

  @override
  void initState() {
    super.initState();

    getReceipts();
  }

  void getReceipts() async {
    List<ReceiptsModel> fetchedReceipts = await ApiService().getReceipts();
    setState(() {
      receipts = fetchedReceipts.map((receipt) => receipt.toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영수증'),
      ),
      body: Column(children: [Text(receipts.toString())]),
    );
  }
}
