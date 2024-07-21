import 'package:flutter/material.dart';
import 'package:pharmacy_app/QR/qt_purchase1.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DoctorQrScreen extends StatefulWidget {
  const DoctorQrScreen({super.key});

  @override
  State<DoctorQrScreen> createState() => _DoctorQrScreenState();
}

class _DoctorQrScreenState extends State<DoctorQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  List<String>? dataList;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR/바코드 스캐너'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Barcode Type: ${result!.format}'),
                        Text('Data: ${result!.code}'),
                        Text('Raw Data: ${result!.rawBytes}'),
                        if (dataList != null)
                          Column(
                            children:
                                dataList!.map((item) => Text(item)).toList(),
                          ),
                      ],
                    )
                  : const Text('스캔 대기 중...'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null && result!.code != null) {
          dataList = result!.code!.split(','); // 콤마로 구분된 문자열을 리스트로 변환
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QtPurchaseScreen(dataList: dataList)),
          );
        }
      });
    });
  }
}


