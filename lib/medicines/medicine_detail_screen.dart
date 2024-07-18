import 'package:flutter/material.dart';
import 'package:pharmacy_app/inventories/inventory_screen.dart';
import 'package:pharmacy_app/models/medicine.detail.dart';
import 'package:pharmacy_app/services/api_service.dart';

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

  void _showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80.0, // Adjust the position as needed
        left: MediaQuery.of(context).size.width / 2 - 70, // Center the overlay

        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 227, 222, 222),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              '장바구니에 담겼습니다',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 205, 218, 168),
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
                  DescrtionItem(
                    title: "효능",
                    content: medicine.efficacy,
                  ),

                  DescrtionItem(
                    title: "복용할 때 주의 해야하는 음식",
                    content: medicine.bewareFood,
                  ),
                  DescrtionItem(
                    title: "사용에 주의해야하는 사항",
                    content: medicine.cautions,
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
                  Text(medicine.averageRating.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          IconData icon;
                          if (index < medicine.averageRating.floor()) {
                            icon = Icons.star;
                          } else if (index < medicine.averageRating) {
                            icon = Icons.star_half;
                          } else {
                            icon = Icons.star_border;
                          }
                          return Icon(
                            icon,
                            color: Colors.amber,
                          );
                        }),
                      ),
                      const SizedBox(
                          width:
                              8), // Add some space between stars and review count
                      Text('(${medicine.reviewCount})'),
                    ],
                  ),
                  // Remove the Row with buttons from here
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text('Unable to load data'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 205, 218, 168),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const InventoryScreen(), // Use PurchaseScreen class here
            ),
          );
        },
        child: const Icon(Icons.shopping_cart, color: Colors.black),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 236, 242, 219),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrementQuantity,
            ),
            Text('$_quantity', style: const TextStyle(fontSize: 25)),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _incrementQuantity,
            ),
            ElevatedButton(
              onPressed: () {
                ApiService().postInventory(
                  medicineId: widget.id,
                  quantity: _quantity,
                );
                // Show Overlay when button is pressed
                _showOverlay(context);
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.black),
              ),
              child: const Text('장바구니에 담기',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class DescrtionItem extends StatelessWidget {
  const DescrtionItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
