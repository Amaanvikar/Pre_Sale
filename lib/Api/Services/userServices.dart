import 'dart:convert';
import 'package:PreSale/Api/ApiEndPoints/apiEndPoints.dart';
import 'package:PreSale/Api/Helper/dbHelper.dart';
import 'package:http/http.dart' as http;
import 'package:PreSale/Api/Model/getUserRoleModel.dart';

class UserService {
  static Future<List<UserRole>> fetchUserRoles(String loginId) async {
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

          print("✅ ${roles.length} user roles saved to local DB.");
          return roles;
        } else {
          print("API call succeeded but returned unexpected format.");
        }
      } else {
        print("API Error: Status ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchUserRoles: $e");
    }

    return [];
  }
}
