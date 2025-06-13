// import 'package:PreSale/Screens/dashboard_screen.dart';
// import 'package:flutter/material.dart';

// class FollowUpFormScreen extends StatefulWidget {
//   const FollowUpFormScreen({super.key});

//   @override
//   State<FollowUpFormScreen> createState() => _FollowUpFormScreenState();
// }

// class _FollowUpFormScreenState extends State<FollowUpFormScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Simple text field controllers
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController modeController = TextEditingController();
//   final TextEditingController followUpByController = TextEditingController();
//   final TextEditingController statusController = TextEditingController();

//   void submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Add your save or next logic here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Follow-up Form',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const Text(
//                 'Follow-up Information:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//               const SizedBox(height: 16),

//               _buildTextField('Date', dateController),
//               _buildTextField('Mode', modeController),
//               _buildTextField('Follow-up done by', followUpByController),
//               _buildTextField('Status', statusController),

//               const SizedBox(height: 30),

//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => DashboardScreen()),
//                   );
//                 },
//                 // _submitForm,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFDC3545),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         validator:
//             (value) => value == null || value.isEmpty ? 'Required' : null,
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:PreSale/Api/Helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FollowUpFormScreen extends StatefulWidget {
  const FollowUpFormScreen({super.key});

  @override
  State<FollowUpFormScreen> createState() => _FollowUpFormScreenState();
}

class _FollowUpFormScreenState extends State<FollowUpFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController modeController = TextEditingController();
  final TextEditingController followUpByController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchAndStoreData() async {
    try {
      final response = await http.get(
        Uri.parse('https://mp44299944c38d3404c8.free.beeceptor.com'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await DBHelper().insertFollowUp({
          'id': 1,
          'date': data['date'] ?? '',
          'mode': data['mode'] ?? '',
          'followUpBy': data['followUpBy'] ?? '',
          'status': data['status'] ?? '',
        });
      }
    } catch (e) {}
    _loadFromLocal();
  }

  Future<void> _loadFromLocal() async {
    final data = await DBHelper().getFollowUp();
    if (data != null) {
      setState(() {
        dateController.text = data['date'] ?? '';
        modeController.text = data['mode'] ?? '';
        followUpByController.text = data['followUpBy'] ?? '';
        statusController.text = data['status'] ?? '';
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await DBHelper().insertFollowUp({
        'id': 1,
        'date': dateController.text,
        'mode': modeController.text,
        'followUpBy': followUpByController.text,
        'status': statusController.text,
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Form saved locally')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Follow-up Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Date', dateController),
              _buildTextField('Mode', modeController),
              _buildTextField('Follow-up by', followUpByController),
              _buildTextField('Status', statusController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
