import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/inventories_model.dart';
import 'package:pharmacy_app/services/api_service.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late Future<List<InventoriesModel>> _inventoriesFuture;

  @override
  void initState() {
    super.initState();
    _inventoriesFuture = ApiService().getInventoryTinyModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "홈페이지 구매 목록",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 7, 7),
              fontFamily: "TEST"),
        ),
      ),
      body: FutureBuilder(
          future: _inventoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const Text("데이터가 없습니다.");
              }
              final List<InventoriesModel> inventories = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Increase space between categories and grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: inventories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            //구매 추가추가
                          },
                          child: Column(
                            children: [
                              Text(
                                inventories[index].medicineName,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
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
          }),
    );
  }
}
