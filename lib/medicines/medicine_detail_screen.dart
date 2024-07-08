import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _medicineFuture = ApiService().getMedicineDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정보'),
      ),
      body: FutureBuilder(
        future: _medicineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final MedicineDetailModel medicine = snapshot.data!;
            return RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(
                      text: '약 이름: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${medicine.name}\n'),
                  TextSpan(
                      text:
                          '효능: ${medicine.efficacy}\n복용할 때 주의해야하는 음식: ${medicine.bewareFood}\n사용에 주의해야하는 사항: ${medicine.sideEffect}\n'),
                  const TextSpan(
                      text: '가격: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${medicine.price}'),
                ],
              ),
            ); // Replace with your actual widget
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
    );
  }
}
