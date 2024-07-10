import 'package:flutter/material.dart';
import 'package:pharmacy_app/medicines/medicine_detail_screen.dart';
import 'package:pharmacy_app/medicines/purchase_screen.dart';
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
  final List<MedicineTinyModel> _medicines = [];
  bool _isLoadingMore = false;

  // Add a TextEditingController
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchMedicines();
  }

  // Dispose the controller when the widget is disposed
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Update _fetchMedicines to accept a search query
  Future<void> _fetchMedicines({String search = ""}) async {
    final newMedicines =
        await ApiService().getMedicineTinyList(page: _page, search: search);

    setState(() {
      if (_page == 1) {
        _medicines.clear(); // Clear the list if it's a new search
      }
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController, // Attach the controller
              decoration: InputDecoration(
                hintText: '약 이름을 검색해 보세요',
                prefixIcon: const Icon(Icons.search),
                border: const UnderlineInputBorder(),
                // Add a suffix icon to delete one character at a time
                suffixIcon: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchController.text = _searchController.text
                          .substring(0, _searchController.text.length - 1);
                    }
                  },
                ),
              ),
              // Add onChanged to trigger search
              onChanged: (value) {
                setState(() {
                  _page = 1; // Reset to first page for new search
                });
                _fetchMedicines(search: value);
              },
            ),
          ),
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
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis if text overflows
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const PurchaseScreen()), // Use PurchaseWidget
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
