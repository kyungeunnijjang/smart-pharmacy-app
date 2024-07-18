import 'package:flutter/material.dart';
import 'package:pharmacy_app/inventories/inventory_screen.dart';

import 'package:pharmacy_app/models/medicine.detail.dart';

import 'package:pharmacy_app/services/api_service.dart';
import 'package:gap/gap.dart';

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

            return const LinearProgressIndicator();
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            medicine.imgURL,

                            width: 180, // 원하는 너비로 설정

                            height: 180,

                            fit: BoxFit.fill,

                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },

                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  medicine.name,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Gap(2),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '가격: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${medicine.price}원',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: '재고 : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${medicine.remaining}개',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: List.generate(5, (index) {
                                      IconData icon;

                                      if (index <
                                          medicine.averageRating.floor()) {
                                        icon = Icons.star;
                                      } else if (index <
                                          medicine.averageRating) {
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      DescrtionItem(
                    title: "부작용",
                    content: medicine.sideEffect,
                  ),
                  DescrtionItem(
                    title: "보관 방법",
                    content: medicine.howToStore,
                  ),
                  DescrtionItem(
                    title: "사용법",
                    content: medicine.usage,
                  ),
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
      floatingActionButton: SizedBox(
        width: 80.0, // 원하는 너비로 설정
        height: 80.0, // 원하는 높이로 설정
        child: FloatingActionButton(
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

          child: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
            size: 40,
          ), //size: 40,
        ),
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
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                ),
                foregroundColor: WidgetStateProperty.all(Colors.black),
              ),
              child: const Text(
                '장바구니에 담기',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
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
    if (content == "nan") {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
