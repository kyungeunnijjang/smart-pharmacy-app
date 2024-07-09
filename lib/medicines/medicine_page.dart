import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/medicine_detail_screen.dart';
import 'package:pharmacy_app/models/token_model.dart';
import 'package:pharmacy_app/services/api_service.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  late Future<List<MedicineTinyModel>> _medicinesFutre;

  int _page = 1;
  final List<String> categories = ['감기약', '영양제', '위염약', '한약', '연고', '기타'];

  String selectedCategory = '감기약';
  List<MedicineTinyModel> _medicines = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _fetchMedicines();
  }

  Future<void> _fetchMedicines() async {
    final newMedicines = await ApiService().getMedicineTinyList(page: _page);

    setState(() {
      _medicines.addAll(newMedicines);
    });
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
      body: Column(
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
              height: 32.0), // Increase space between categories and grid

          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!_isLoadingMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    _isLoadingMore = true;
                    _page++;
                  });

                  _fetchMedicines().then((_) {
                    setState(() {
                      _isLoadingMore = false;
                    });
                  });
                }
                return true;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),

                itemCount: _medicines.length +
                    (_isLoadingMore
                        ? 1
                        : 0), // Add one more item for the loading indicator

                itemBuilder: (context, index) {
                  if (index == _medicines.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MedicineDetailScreen(id: _medicines[index].id)),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          _medicines[index].name,
                          style: const TextStyle(fontSize: 16.0),
                          maxLines: 6, // Limit to 6 lines
                          overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}