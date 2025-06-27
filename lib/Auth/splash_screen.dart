import 'package:flutter/material.dart';
import 'package:PreSale/Auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roleId = prefs.getInt('roleId'); // fetch userId

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Right Circles
          Positioned(
            top: -10,
            right: -30,
            child: Image.asset(
              'assets/images/Ellipse 1 (1).png',
              height: 200,
              width: 180,
            ),
          ),
          Positioned(
            top: -50,
            right: 80,
            child: Image.asset(
              'assets/images/Ellipse 2 (2).png',
              height: 200,
              width: 200,
            ),
          ),

          // Bottom Right Circles
          Positioned(
            bottom: -100,
            right: -20,
            child: Image.asset(
              'assets/images/Ellipse 3 (1).png',
              height: 300,
              width: 180,
            ),
          ),
          Positioned(
            bottom: -50,
            right: 100,
            child: Image.asset(
              'assets/images/Ellipse 4 (1).png',
              height: 200,
              width: 200,
            ),
          ),

          // Center Logo
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.asset('assets/images/logo.png', height: 200)],
            ),
          ),
        ],
      ),
    );
  }
}
