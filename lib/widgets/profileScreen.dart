import 'package:flutter/material.dart';

import 'package:presale/Api/Helper/constant.dart';
import 'package:presale/Api/Helper/dbHelper.dart';
import 'package:presale/Api/Helper/sharedPreferences.dart';
import 'package:presale/Api/Model/getUserRoleModel.dart';
import 'package:presale/Auth/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<UserRole> allUserRoles = [];

  String userName = 'User';
  String? roleName;
  int? roleId;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final name = await SharedPreferenceHelper.getUserName();
    final storedRoleName = await SharedPreferenceHelper.getRoleName();
    final storedRoleId = await SharedPreferenceHelper.getRoleId();
    final currentUserId = await SharedPreferenceHelper.getUserId();
    print("Current Logged-in UserId: $currentUserId");

    final db = DBHelper();
    final roles = await db.getRolesByUserId(currentUserId!);
    print("Roles fetched from DB for user $currentUserId: ${roles.length}");

    setState(() {
      userName = name ?? 'User';
      roleName = storedRoleName;
      roleId = storedRoleId;
      allUserRoles = roles.take(5).toList();
    });
  }

  Future<void> logout() async {
    await SharedPreferenceHelper.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: kPrimaryColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (allUserRoles.isEmpty)
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "No roles found.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...allUserRoles.map((role) => _buildRoleCard(role)),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: logout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build single role card
  Widget _buildRoleCard(UserRole role) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role.roleName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Role ID: ${role.roleId}"),
            Text("Role Level: ${role.roleLevelName}"),
            Text("Vertical: ${role.verticalName ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
