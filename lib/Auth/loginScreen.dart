import 'dart:convert';

import 'package:PreSale/Api/ApiEndPoints/apiEndPoints.dart';
import 'package:PreSale/Api/Helper/constant.dart';
import 'package:PreSale/Api/Helper/dbHelper.dart';
import 'package:PreSale/Api/Helper/sharedPreferences.dart';
import 'package:PreSale/Api/Model/getUserRoleModel.dart';
import 'package:PreSale/Api/Services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:PreSale/Auth/forgotPassScreen.dart';
import 'package:PreSale/Screens/dashboardScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  bool rememberMe = false;
  bool _isLoading = false;

  Future<void> validateAndLogin() async {
    setState(() => _isLoading = true);

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username and Password can't be empty")),
      );
      return;
    }

    final url = Uri.parse(ApiEndPoints.appLogin);
    final headers = {"Content-Type": "application/json"};
    final body = {
      "action": "NONDOMLOG",
      "loginId": username,
      "password": password,
      "newPassword": "",
      "emailID": "",
      "attemptCount": "",
      "isLocked": true,
      "modifiedBy": "",
      "webMailProfile": "",
      "emailApplicationURL": "",
      "supportNo": "",
      "supportEmailID": "",
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (Navigator.canPop(context)) Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true &&
            data['data'] is List &&
            data['data'].isNotEmpty &&
            data['data'][0]?['LoginStatus'] == 1) {
          final LoggedInUserName = data['data'][0]?['UserName'] ?? 'User';
          await SharedPreferenceHelper.setUserName(LoggedInUserName);

          final roles = await UserService.fetchUserRoles(username);
          print("user role: $roles");

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            'userRoles',
            jsonEncode(roles.map((e) => e.toJson()).toList()),
          );

          if (roles.isNotEmpty && roles[0] is UserRole) {
            final firstRole = roles[0] as UserRole;
            if (firstRole.roleId != null) {
              await prefs.setInt('roleId', firstRole.roleId);
              await prefs.setString('roleName', firstRole.roleName);
            }
          }

          final message = data['data']?[0]?['Message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message?.toString() ?? 'Login successful')),
          );
          if (rememberMe) {
            await prefs.setBool('rememberMe', true);
            await prefs.setString('username', username);
            await prefs.setString('password', password);
          }

          setState(() => _isLoading = false);

          try {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardScreen()),
            );
          } catch (e) {
            print("Navigation error: $e");
          }
        } else {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['data']?[0]?['Message'] ?? 'Login failed'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login error: $e")));
      print("Login Exception: $e");
    }
  }

  Future<List<dynamic>> fetchUserRoles(String loginId) async {
    final url = Uri.parse(ApiEndPoints.getUserRole);
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"loginId": loginId});

    try {
      final response = await http.post(url, headers: headers, body: body);
      print("fetchUserRoles raw response: ${response.body}");

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        print("Decoded 'data' field: ${result['data']}");

        if (result['success'] == true && result['data'] is List) {
          final roles =
              (result['data'] as List)
                  .map((roleJson) => UserRole.fromJson(roleJson))
                  .toList();

          final db = DBHelper();
          await db.clearAllRoles();
          for (var role in roles) {
            await db.insertUserRole(role);
          }
          print("${roles.length} user roles saved to local DB.");
        } else {
          print(
            "fetchUserRoles error: API call succeeded but returned unexpected data format.",
          );
        }
      } else {
        print("fetchUserRoles error: Status ${response.statusCode}");
      }
    } catch (e) {
      print("fetchUserRoles exception: $e");
    }

    return [];
  }

  @override
  void initState() {
    super.initState();
    loadRememberedLogin();
  }

  Future<void> loadRememberedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool remember = prefs.getBool('rememberMe') ?? false;

    if (remember) {
      setState(() {
        rememberMe = true;
        usernameController.text = prefs.getString('username') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      });
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: kPrimaryColor) : null,
        labelText: label,
        border: UnderlineInputBorder(),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
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
              ), // logo in assets
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
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Welcome to login page', textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    // Username
                    buildTextField(
                      controller: usernameController,
                      label: 'Username',
                      icon: Icons.person,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    // Password
                    buildTextField(
                      controller: passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    /* Captcha
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
                    */
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (val) async {
                            setState(() {
                              rememberMe = val!;
                            });
                            if (!rememberMe) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('rememberMe');
                              await prefs.remove('username');
                              await prefs.remove('password');
                            }
                          },
                        ),
                        const Text("Remember me"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildButton(
                      text: "LOGIN",
                      onPressed: validateAndLogin,
                      isLoading: _isLoading,
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
                        style: TextStyle(color: kPrimaryColor),
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
