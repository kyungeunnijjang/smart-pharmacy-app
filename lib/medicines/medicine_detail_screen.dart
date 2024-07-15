import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/purchase_screen.dart';
import 'package:pharmacy_app/models/medicine.detail.dart'; // 올바른 모델 경로 확인 필요
import 'package:pharmacy_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // shared_preferences 추가

class MedicineDetailScreen extends StatefulWidget {
  final int id;
  const MedicineDetailScreen({super.key, required this.id});

  @override
  State<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  late Future<MedicineDetailModel> _medicineFuture;
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _medicineFuture = ApiService().getMedicineDetail(widget.id);
    _loadQuantity(); // 앱 시작 시 저장된 수량 불러오기
  }

  // 저장된 수량 불러오기
  void _loadQuantity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _quantity = prefs.getInt('medicine_${widget.id}_quantity') ?? 0;
    });
  }

  // 수량 저장하기
  Future<void> _saveQuantity() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('medicine_${widget.id}_quantity', _quantity);
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _medicineFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final MedicineDetailModel medicine = snapshot.data!;
                return Text(medicine.name);
              } else {
                return const Text('Error: No data');
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _medicineFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final MedicineDetailModel medicine = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          const Text(
                            "효능",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              medicine.efficacy,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                        elevation: 8,
                        child: Column(
                          children: [
                            const Text(
                              "복용할 때 주의 해야하는 음식",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                medicine.efficacy,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          const Text(
                            "사용에 주의해야하는 사항",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              medicine.sideEffect,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _decrementQuantity,
                        ),
                        Text('$_quantity',
                            style: const TextStyle(fontSize: 25)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _incrementQuantity,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _saveQuantity(); // 담기 버튼을 누를 때 수량 저장
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all(Colors.black),
                          ),
                          child: const Text('담기',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text('Unable to load data'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PurchaseScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
