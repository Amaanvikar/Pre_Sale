import 'package:flutter/material.dart';
import 'package:PreSale/Auth/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pre Sale',
      home: const SplashScreen(),
    );
  }
}
