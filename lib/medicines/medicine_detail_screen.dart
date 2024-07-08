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
        title: const Text('약 정보'),
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView here
        child: FutureBuilder(
          future: _medicineFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final MedicineDetailModel medicine = snapshot.data!;
              return RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                        text: ' 약 이름: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                    TextSpan(
                        text: '${medicine.name}\n\n',
                        style: const TextStyle(
                            color: Colors.blue, fontSize: 25.0)),
                    const TextSpan(
                        text: ' 효능:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                        )),
                    TextSpan(
                        text: ' ${medicine.efficacy}\n',
                        style: const TextStyle(fontSize: 18.0)),
                    const TextSpan(
                      text: ' 복용할 때 ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    const TextSpan(
                      text: '주의',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.red),
                    ),
                    const TextSpan(
                      text: '해야하는 음식: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    TextSpan(
                      text: ' ${medicine.bewareFood}\n',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const TextSpan(
                      text: ' 사용에 ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    const TextSpan(
                      text: '주의',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.red),
                    ),
                    const TextSpan(
                      text: '해야하는 사항: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    TextSpan(
                      text: ' ${medicine.sideEffect}\n',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const TextSpan(
                        text: ' 가격: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0)),
                    TextSpan(
                        text: ' ${medicine.price}원',
                        style: const TextStyle(fontSize: 25.0)),
                  ],
                ),
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
    );
  }
}
