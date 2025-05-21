import 'package:flutter/material.dart';
import 'package:pre_sale/Screens/Inquiry_form/inquiry_from2_.dart';

class InquiryFromScreen extends StatefulWidget {
  const InquiryFromScreen({super.key});

  @override
  State<InquiryFromScreen> createState() => _InquiryFromScreenState();
}

class _InquiryFromScreenState extends State<InquiryFromScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form field values
  String? vertical = 'Retail';
  String? inquiryNo;
  String? communicationMode = 'Retail';
  String? segment;
  String? subSegment;
  DateTime inquiryDate = DateTime.now();
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
      initialDate: inquiryDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(inquiryDate),
      );

      if (pickedTime != null) {
        setState(() {
          inquiryDate = DateTime(
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFDC3545),
          ),
        ),
        centerTitle: true,
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
              _buildDropdown("Vertical", ['Retail'], (val) => vertical = val),
              _buildTextField("Inquiry no", (val) => inquiryNo = val),
              _buildDropdown("Communication mode", [
                'Retail',
              ], (val) => communicationMode = val),
              _buildDropdown("Segment", selectOptions, (val) => segment = val),
              _buildDropdown(
                "Sub Segment",
                selectOptions,
                (val) => subSegment = val,
              ),
              _buildDateTimePicker("Inquiry Date"),
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InquiryFromScreen2(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC3545),
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
            "${inquiryDate.day}/${inquiryDate.month}/${inquiryDate.year} ${inquiryDate.hour}:${inquiryDate.minute.toString().padLeft(2, '0')}",
          ),
        ),
      ),
    );
  }
}
