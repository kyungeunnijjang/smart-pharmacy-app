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
          if (quantity == 0) {
            return const SizedBox.shrink(); // 수량이 0일 때 빈 컨테이너 반환
          }
          return GestureDetector(
            onTap: () {
              //구매 추가추가
            },
            child: Card(
              // Container 대신 Card 사용
              elevation: 2.0, // 그림자 효과 추가
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 모서리 둥글게
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
                mainAxisAlignment: MainAxisAlignment.center,
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
                    '${widget.inventory.medicinePrice}원',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '재고${widget.inventory.medicineRemaining}개',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      if (quantity >= 2)
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            int newQuantity = quantity - 1;
                            updateQuantity(newQuantity);
                          },
                        ),
                      if (quantity < 2)
                        const SizedBox(
                          width: 45,
                        ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: quantity > widget.inventory.medicineRemaining
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int newQuantity = quantity + 1;
                          updateQuantity(newQuantity);
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await ApiService().deleteInventory(
                                id: widget.inventory.id,
                                quantity: widget.inventory.quantity);
                            setState(() {
                              _quantity = Future.value(0);
                            });
                          },
                        ),
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
