import 'package:PreSale/Api/Helper/constant.dart';
import 'package:PreSale/Api/Helper/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:PreSale/Screens/InquiryForms/productInformationScreen.dart';

class EnquiryFromScreen extends StatefulWidget {
  const EnquiryFromScreen({super.key});

  @override
  State<EnquiryFromScreen> createState() => _EnquiryFromScreenState();
}

class _EnquiryFromScreenState extends State<EnquiryFromScreen> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = 'Individual';

  // Form field values
  String? vertical = 'Retail';
  String? enquiryNo;
  String? communicationMode = 'Retail';
  String? segment;
  String? subSegment;
  DateTime enquiryDate = DateTime.now();
  String? source;
  String? dealBy;
  String? customerType;
  String? category = 'Individual';

  // Dropdown Options
  final List<String> selectOptions = ['Select'];
  final List<String> categoryOptions = ['Individual', 'Corporate'];

  // Date picker
  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: enquiryDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(enquiryDate),
      );

      if (pickedTime != null) {
        setState(() {
          enquiryDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Enquiry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Enquiry Information:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              _buildTextField("Title", (val) => titleController.text = val!),
              _buildDropdown("Category", [
                'Individual',
                'Corporate',
              ], (val) => selectedCategory = val!),

              _buildDropdown("Vertical", ['Retail'], (val) => vertical = val),
              _buildTextField("Enquiry no", (val) => enquiryNo = val),
              _buildDropdown("Communication mode", [
                'Retail',
              ], (val) => communicationMode = val),
              _buildDropdown("Segment", selectOptions, (val) => segment = val),
              _buildDropdown(
                "Sub Segment",
                selectOptions,
                (val) => subSegment = val,
              ),
              _buildDateTimePicker("Enquiry Date"),
              _buildDropdown("Source", selectOptions, (val) => source = val),
              _buildDropdown("Deal By", selectOptions, (val) => dealBy = val),
              _buildDropdown(
                "Customer Type",
                selectOptions,
                (val) => customerType = val,
              ),
              _buildDropdown(
                "Category",
                categoryOptions,
                (val) => category = val,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnquiryFromScreen2(),
                        ),
                      );
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => EnquiryFromScreen2(),
                      //     ),
                      //   );
                      // }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: items.first,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onSaved: onSaved,
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDateTimePicker(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: _pickDateTime,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          child: Text(
            "${enquiryDate.day}/${enquiryDate.month}/${enquiryDate.year} ${enquiryDate.hour}:${enquiryDate.minute.toString().padLeft(2, '0')}",
          ),
        ),
      ),
    );
  }
}
