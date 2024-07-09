import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/inventory.dart';
import 'package:pharmacy_app/services/api_service.dart';

class InventoryBox extends StatefulWidget {
  const InventoryBox({
    super.key,
    required this.inventory,
  });

  final InventoryModel inventory;

  @override
  State<InventoryBox> createState() => _InventoryBoxState();
}

class _InventoryBoxState extends State<InventoryBox> {
  late Future<int> _quantity;

  @override
  void initState() {
    super.initState();

    _quantity = Future.value(widget.inventory.quantity);
  }

  void updateQuantity(int quantity) async {
    setState(() {
      _quantity = Future.value(-1); // 로딩 상태를 나타내기 위해 -1 설정
    });

    await ApiService()
        .putInventory(id: widget.inventory.id, quantity: quantity);
    setState(() {
      _quantity = Future.value(quantity); // 업데이트된 수량 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _quantity,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == -1) {
          return const Center(child: CircularProgressIndicator()); // 로딩 중일 때
        } else if (snapshot.hasData) {
          final quantity = snapshot.data!;
          return GestureDetector(
            onTap: () {
              //구매 추가추가
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Align children in the center horizontally

                children: [
                  Text(
                    widget.inventory.medicineName,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    widget.inventory.medicineCompany,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    widget.inventory.medicinePrice.toString(),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      if (quantity >= 2)
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            int newQuantity = quantity - 1;
                            updateQuantity(newQuantity);
                          },
                        ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int newQuantity = quantity + 1;
                          updateQuantity(newQuantity);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}