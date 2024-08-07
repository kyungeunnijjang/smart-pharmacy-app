import 'package:flutter/material.dart';
import 'package:pharmacy_app/authentication/log_in_screen.dart';
import 'package:pharmacy_app/inventories/inventory_box.dart';
import 'package:pharmacy_app/medicines/medicine_page.dart';
import 'package:pharmacy_app/models/inventory.dart';
import 'package:pharmacy_app/services/api_service.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({
    super.key,
  });

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late Future<List<InventoryModel>> _inventoriesFuture;
  int total = 0;

  @override
  void initState() {
    super.initState();
    _inventoriesFuture = ApiService().getInventories();
    _calculateTotal();
  }

  void _calculateTotal() async {
    final inventories = await _inventoriesFuture;
    setState(() {
      total = inventories.fold(
        0,
        (sum, item) => sum + (item.quantity * item.medicinePrice).toInt(),
      );
    });
  }

  int getQuantityAsInt(int index, List<InventoryModel> inventories) {
    return inventories[index].quantity;
  }

  void _purchase() async {
    if (await ApiService().purchaseInventory()) {
      _purchasetrue();
    } else {
      _purchasefalse();
    }
  }

  void _updateTotal(int delta) {
    setState(() {
      total += delta;
    });
  }

  void _removeInventory(int id) {
    setState(() {
      _inventoriesFuture = ApiService().getInventories();
      _calculateTotal();
    });
  }

  void _purchasetrue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구매 완료'),
          content: const Text('구매가 성공적으로 완료되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _purchasefalse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구매 실패'),
          content: const Text('재고가 없거나 구매 목록이 비어 있습니다.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
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
        backgroundColor: const Color.fromARGB(255, 205, 218, 168),
        title: const Text(
          "장바구니",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 13, 7, 7),
            fontFamily: "TEST",
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MedicinePage(),
              ),
              (Route<dynamic> route) => false, // 추가된 부분
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: _inventoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Text("데이터가 없습니다.");
            }
            final List<InventoryModel> inventories = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: inventories.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InventoryBox(
                              inventory: inventories[index],
                              onDelete: _removeInventory,
                              onUpdate: _updateTotal,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '총 결제 금액: $total원', // 추가된 텍스트
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _purchase();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 205, 218, 168),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                '결제',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
