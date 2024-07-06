import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/medicine.dart';
import 'package:pharmacy_app/models/token_model.dart';
import 'package:pharmacy_app/services/api_service.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  late Future<List<MedicineTinyModel>> _medicinesFutre =
      ApiService().getMedicineTinyList();

  final List<String> categories = ['감기약', '영양제', '위염약', '한약', '연고', '기타'];

  String selectedCategory = '감기약';

  // final List<Map<String, String>> items = [
  //   {'name': '마데카솔', 'description': '상처 치료제'},
  //   {'name': '타이레놀', 'description': '진통제'},
  //   {'name': '판콜에이', 'description': '감기약'},
  //   {'name': '비타민C', 'description': '영양제'},
  //   {'name': '소화제', 'description': '소화불량 치료제'},
  //   {'name': '후시딘', 'description': '항생제 연고'},
  // ];

  @override
  void initState() {
    super.initState();
    _medicinesFutre = ApiService().getMedicineTinyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약 구경',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 13, 7, 7),
                fontFamily: "TEST")),
      ),
      body: FutureBuilder(
          future: _medicinesFutre,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<MedicineTinyModel> medicines = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '약 이름을 검색해 보세요',
                        prefixIcon: Icon(Icons.search),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChoiceChip(
                            label: Text(categories[index]),
                            selected: selectedCategory == categories[index],
                            onSelected: (bool selected) {
                              setState(() {
                                selectedCategory = categories[index];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                      height:
                          32.0), // Increase space between categories and grid
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
                      itemCount: medicines.length, // Number of items
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicineDetailScreen(
                                      id: medicines[index].id)),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                medicines[index].name,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                medicines[index].name,
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
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
