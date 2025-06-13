import 'dart:math';

import 'package:flutter/material.dart';
import 'package:PreSale/Auth/forgot_pass_screen.dart';
import 'package:PreSale/Screens/dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  bool rememberMe = false;

  String captchaCode = '';

  String generateCaptcha(int length) {
    const chars = 'AaBbCcDdEeFfGgHh1234567890';
    final rand = Random();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  @override
  void initState() {
    super.initState();
    captchaCode = generateCaptcha(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            children: [
              SizedBox(height: 20),

              // Logo
              Image.asset(
                'assets/images/logo.png',
                height: 80,
              ), // Add your logo in assets
              SizedBox(height: 30),
              // Login Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDC3545),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Welcome to login page', textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    // Username
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFFDC3545),
                        ),
                        labelText: 'Username',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Password
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Color(0xFFDC3545)),
                        labelText: 'Password',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Captcha
                    Text(
                      'Captcha',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            captchaCode,
                            style: TextStyle(letterSpacing: 4, fontSize: 24),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            color: Colors.teal,
                            onPressed: () {
                              setState(() {
                                captchaCode = generateCaptcha(6);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: captchaController,
                      decoration: InputDecoration(
                        hintText: 'Enter captcha text',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = val!;
                            });
                          },
                        ),
                        Text("Remember me"),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFDC3545),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(color: Color(0xFFDC3545)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
