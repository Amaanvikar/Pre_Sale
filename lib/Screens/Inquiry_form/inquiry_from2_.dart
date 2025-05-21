import 'package:flutter/material.dart';
import 'package:pre_sale/Screens/Inquiry_form/inquiry_from3.dart';

class InquiryFromScreen2 extends StatefulWidget {
  const InquiryFromScreen2({super.key});

  @override
  State<InquiryFromScreen2> createState() => _InquiryFromScreen2State();
}

class _InquiryFromScreen2State extends State<InquiryFromScreen2> {
  final _formKey = GlobalKey<FormState>();

  // Form field values
  String? kva = '';
  String? ratingType;
  String? engine = '';
  String? phase;
  String? panel;
  String? quantity;
  String? typeOfOwnership;

  // Dropdown Options
  final List<String> selectOptions = ['Select'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Product Information:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              _buildDropdown("KVA", selectOptions, (val) => kva = val),
              _buildDropdown(
                "Rating Type",
                selectOptions,
                (val) => ratingType = val,
              ),
              _buildDropdown("Engine", selectOptions, (val) => engine = val),
              _buildDropdown("Phase", selectOptions, (val) => phase = val),
              _buildDropdown("Panel", selectOptions, (val) => panel = val),
              _buildTextField("Quanity", (val) => quantity = val),
              _buildDropdown(
                "Type of Ownership",
                selectOptions,
                (val) => typeOfOwnership = val,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to previous form
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC3545),
                      shape: RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      "Previous",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InquiryFromScreen3(),
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
}
