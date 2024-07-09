// import 'package:flutter/material.dart';
// import 'package:pharmacy_app/medicines/medicine_detail_screen.dart';
// import 'package:pharmacy_app/models/token_model.dart';
// import 'package:pharmacy_app/services/api_service.dart';

// class MedicineSearchPage extends StatefulWidget {
//   final String query;

//   const MedicineSearchPage({super.key, required this.query});

//   @override
//   _MedicineSearchPageState createState() => _MedicineSearchPageState();
// }

// class _MedicineSearchPageState extends State<MedicineSearchPage> {
//   late Future<List<MedicineTinyModel>> _searchResults;

//   @override
//   void initState() {
//     super.initState();
//     _searchResults = _fetchSearchResults(widget.query);
//   }

//   Future<List<MedicineTinyModel>> _fetchSearchResults(String query) async {
//     return await ApiService().searchMedicines(query: query);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Results for "${widget.query}"'),
//       ),
//       body: FutureBuilder<List<MedicineTinyModel>>(
//         future: _searchResults,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No results found'));
//           } else {
//             final medicines = snapshot.data!;
//             return GridView.builder(
//               padding: const EdgeInsets.all(8.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 0.75,
//               ),
//               itemCount: medicines.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               MedicineDetailScreen(id: medicines[index].id)),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Text(
//                         medicines[index].name,
//                         style: const TextStyle(fontSize: 16.0),
//                         maxLines: 6, // 최대 6줄로 제한
//                         overflow: TextOverflow.ellipsis, // 텍스트가 넘칠 경우 생략 부호 추가
//                       ),
//                       const SizedBox(height: 8.0),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
