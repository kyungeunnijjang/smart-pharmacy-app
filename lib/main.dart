import 'package:flutter/material.dart';
import 'package:pharmacy_app/authentication/log_in_screen.dart';
import 'package:pharmacy_app/medicines/medicine_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogInScreen(),
    );
  }
}
