import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InquiryFromScreen3 extends StatefulWidget {
  @override
  State<InquiryFromScreen3> createState() => _InquiryFromScreen3State();
}

class _InquiryFromScreen3State extends State<InquiryFromScreen3> {
  final _formKey = GlobalKey<FormState>();

  // Current selected values
  String? customerName = 'Retail';
  String? contactPersonName;
  String? mobileNo;
  String? emailID;
  String? address;
  String? country = 'India';
  String? state;
  String? district;
  String? tehsil;
  String? city;
  String? pinCode;

  // List of previous values from local DB
  List<String> mobileOptions = ['Select'];
  List<String> emailOptions = ['Select'];
  List<String> addressOptions = ['Select'];
  List<String> stateOptions = ['Select'];
  List<String> districtOptions = ['Select'];
  List<String> tehsilOptions = ['Select'];
  List<String> cityOptions = ['Select'];
  List<String> pinCodeOptions = ['Select'];

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      mobileOptions = prefs.getStringList('mobileOptions') ?? ['Select'];
      emailOptions = prefs.getStringList('emailOptions') ?? ['Select'];
      addressOptions = prefs.getStringList('addressOptions') ?? ['Select'];
      stateOptions = prefs.getStringList('stateOptions') ?? ['Select'];
      districtOptions = prefs.getStringList('districtOptions') ?? ['Select'];
      tehsilOptions = prefs.getStringList('tehsilOptions') ?? ['Select'];
      cityOptions = prefs.getStringList('cityOptions') ?? ['Select'];
      pinCodeOptions = prefs.getStringList('pinCodeOptions') ?? ['Select'];

      // Optional: auto-select first valid value
      mobileNo = mobileOptions.firstWhere(
        (e) => e != 'Select',
        orElse: () => '',
      );
      emailID = emailOptions.firstWhere((e) => e != 'Select', orElse: () => '');
      address = addressOptions.firstWhere(
        (e) => e != 'Select',
        orElse: () => '',
      );
      state = stateOptions.firstWhere((e) => e != 'Select', orElse: () => '');
      district = districtOptions.firstWhere(
        (e) => e != 'Select',
        orElse: () => '',
      );
      tehsil = tehsilOptions.firstWhere((e) => e != 'Select', orElse: () => '');
      city = cityOptions.firstWhere((e) => e != 'Select', orElse: () => '');
      pinCode = pinCodeOptions.firstWhere(
        (e) => e != 'Select',
        orElse: () => '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Customer Information:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),

              _buildDropdown(
                "Customer Name",
                ['Retail'],
                (val) => customerName = val,
                customerName,
              ),
              _buildTextField(
                "Contact Person Name",
                (val) => contactPersonName = val,
              ),

              _buildDropdown(
                "Mobile No",
                mobileOptions,
                (val) => mobileNo = val,
                mobileNo,
              ),
              _buildDropdown(
                "Email ID",
                emailOptions,
                (val) => emailID = val,
                emailID,
              ),
              _buildDropdown(
                "Address",
                addressOptions,
                (val) => address = val,
                address,
              ),
              _buildDropdown(
                "Country",
                ['India'],
                (val) => country = val,
                country,
              ),
              _buildDropdown(
                "State",
                stateOptions,
                (val) => state = val,
                state,
              ),
              _buildDropdown(
                "District",
                districtOptions,
                (val) => district = val,
                district,
              ),
              _buildDropdown(
                "Tehsil",
                tehsilOptions,
                (val) => tehsil = val,
                tehsil,
              ),
              _buildDropdown("City", cityOptions, (val) => city = val, city),
              _buildDropdown(
                "Pin Code",
                pinCodeOptions,
                (val) => pinCode = val,
                pinCode,
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC3545),
                      shape: RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      "Previous",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Form Submitted")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC3545),
                      shape: RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      "Submit",

                      style: TextStyle(color: Colors.white),
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
    String? selectedValue,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value:
            selectedValue != null && items.contains(selectedValue)
                ? selectedValue
                : (items.contains('Select') ? 'Select' : items.first),
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
            (value) =>
                value == null || value == 'Select' || value.isEmpty
                    ? 'Required'
                    : null,
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
