import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/purchase_screen.dart';
import 'package:pharmacy_app/models/medicine.detail.dart';
import 'package:pharmacy_app/services/api_service.dart';
import 'package:pharmacy_app/purchase_widget.dart'; // Import the PurchaseScreen class

class MedicineDetailScreen extends StatefulWidget {
  final int id;
  const MedicineDetailScreen({super.key, required this.id});

  @override
  State<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  late Future<MedicineDetailModel> _medicineFuture;
  int _quantity = 0;

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
  void initState() {
    super.initState();
    _medicineFuture = ApiService().getMedicineDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _medicineFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final MedicineDetailModel medicine = snapshot.data!;
              return Text(medicine.name);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _medicineFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13.0), // Add padding to create space
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Price: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0)),
                          TextSpan(
                              text: ' ${medicine.price}원',
                              style: const TextStyle(fontSize: 25.0)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                      ),
                      Text('$_quantity',
                          style: const TextStyle(
                              fontSize: 25)), // Increase font size
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementQuantity,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                        child: const Text('담기',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16)), // Change text color to black
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Add a default return statement
            return const Center(
              child: Text('Unable to load data'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const PurchaseScreen(), // Use PurchaseScreen class here
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
