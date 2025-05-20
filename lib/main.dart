import 'package:flutter/material.dart';
import 'package:pre_sale/Auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Pre Sale', home: LoginScreen());
  }
}
