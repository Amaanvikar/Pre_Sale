import 'package:PreSale/Screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class FollowUpFormScreen extends StatefulWidget {
  const FollowUpFormScreen({super.key});

  @override
  State<FollowUpFormScreen> createState() => _FollowUpFormScreenState();
}

class _FollowUpFormScreenState extends State<FollowUpFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Simple text field controllers
  final TextEditingController dateController = TextEditingController();
  final TextEditingController modeController = TextEditingController();
  final TextEditingController followUpByController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add your save or next logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Follow-up Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Follow-up Information:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 16),

              _buildTextField('Date', dateController),
              _buildTextField('Mode', modeController),
              _buildTextField('Follow-up done by', followUpByController),
              _buildTextField('Status', statusController),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                // _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDC3545),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
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
