import 'package:flutter/material.dart';
import 'package:presale/Api/Helper/appDatabase.dart';
import 'package:presale/Api/Helper/constant.dart';
import 'package:presale/Screens/InquiryForms/productInformationScreen.dart';

// import 'package:presale/Database/customerTypeDbHelper.dart';
// import 'package:presale/Database/dealByDbHelper.dart';
// import 'package:presale/Database/segmentDbHelper.dart';
// import 'package:presale/Database/verticalDbHelper.dart';

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

  List<String> verticalOptions = [];
  List<String> segmentOptions = [];
  List<String> dealByOptions = [];
  List<String> customerTypeOptions = [];
  List<String> sourceOptions = [];
  List<String> communicationModeOptions = [];

  final List<String> selectOptions = ['Select'];
  final List<String> categoryOptions = ['Individual', 'Corporate'];

  // Form field values
  String? vertical;
  String? enquiryNo;
  String? segment;
  String? communicationMode;
  String? subSegment;
  DateTime enquiryDate = DateTime.now();
  String? source;
  String? dealBy;
  String? customerType;
  String? category = 'Individual';

  final db = AppDatabase(); // centralized DB helper

  Map<String, int> segmentNameToIdMap = {};
  List<String> subSegmentOptions = [];

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
  void initState() {
    super.initState();
    _loadVerticals();
    _loadSegments();
    _loadDealBy();
    _loadCustomerTypes();
    _loadSource();
    _loadCommunicationModes();
  }

  Future<void> _loadVerticals() async {
    final verticalList = await db.getAllVerticals();
    setState(() {
      verticalOptions = verticalList.map((v) => v.verticalName).toList();
      vertical = verticalOptions.isNotEmpty ? verticalOptions.first : null;
    });
  }

  Future<void> _loadSegments() async {
    final segmentList = await db.getAllSegments();
    setState(() {
      segmentOptions = segmentList.map((e) => e.segmentName).toList();
      segmentNameToIdMap = {
        for (var e in segmentList) e.segmentName: e.segmentID,
      };
      segment = segmentOptions.isNotEmpty ? segmentOptions.first : null;
      if (segment != null) {
        _loadSubSegmentsForSegment(segment!);
      }
    });
  }

  Future<void> _loadSubSegmentsForSegment(String selectedSegment) async {
    final segmentId = segmentNameToIdMap[selectedSegment];
    if (segmentId == null) {
      print(" Segment ID not found for $selectedSegment");
      return;
    }

    print("🔍 Fetching SubSegments from DB for Segment ID: $segmentId");

    final subSegmentList = await db.getSubSegmentsBySegmentId(segmentId);

    setState(() {
      subSegmentOptions = subSegmentList.map((e) => e.subSegmentName).toList();
      subSegment =
          subSegmentOptions.isNotEmpty ? subSegmentOptions.first : null;
    });

    print("Loaded ${subSegmentOptions.length} sub-segments from local DB.");
  }

  Future<void> _loadDealBy() async {
    final dealByList = await db.getAllDealBy();
    setState(() {
      dealByOptions = dealByList.map((e) => e.employeeName).toList();
      dealBy = dealByOptions.isNotEmpty ? dealByOptions.first : null;
    });
  }

  Future<void> _loadCustomerTypes() async {
    final customerTypeList = await db.getAllCustomerTypes();
    setState(() {
      customerTypeOptions =
          customerTypeList.map((e) => e.customerTypeName).toList();
      customerType =
          customerTypeOptions.isNotEmpty ? customerTypeOptions.first : null;
    });
  }

  Future<void> _loadSource() async {
    final sourceList = await db.getAllSources();
    setState(() {
      sourceOptions = sourceList.map((e) => e.sourceName).toList();
      source = sourceOptions.isNotEmpty ? sourceOptions.first : null;
    });
  }

  Future<void> _loadCommunicationModes() async {
    final communicationModeList = await db.getAllCommunicationModes();
    setState(() {
      communicationModeOptions =
          communicationModeList.map((e) => e.modeName).toList();
      communicationMode =
          communicationModeOptions.isNotEmpty
              ? communicationModeOptions.first
              : null;
    });
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
              _buildDropdown(
                "Vertical",
                verticalOptions,
                vertical,
                (val) => setState(() => vertical = val),
              ),
              // _buildTextField("Title", (val) => titleController.text = val!),
              // _buildDropdown(
              //   "Category",
              //   ['Individual', 'Corporate'],
              //   selectedCategory,
              //   (val) => setState(() => selectedCategory = val!),
              // ),
              _buildTextField(
                "Enquiry no",
                (val) => setState(() => enquiryNo = val),
              ),
              _buildDropdown(
                "Communication mode",
                communicationModeOptions,
                communicationMode,
                (val) => setState(() => communicationMode = val),
              ),
              _buildDropdown(
                "Segment",
                segmentOptions,
                segment,
                (val) => setState(() => segment = val),
              ),
              _buildDropdown(
                "Sub Segment",
                subSegmentOptions,
                subSegment,
                (val) => subSegment = val,
              ),
              _buildDateTimePicker("Enquiry Date"),
              _buildDropdown(
                "Source",
                sourceOptions,
                source,
                (val) => setState(() => source = val),
              ),
              _buildDropdown(
                "Deal By",
                dealByOptions,
                dealBy,
                (val) => setState(() => dealBy = val),
              ),
              _buildDropdown(
                "Customer Type",
                customerTypeOptions,
                customerType,
                (val) => setState(() => customerType = val),
              ),
              _buildDropdown(
                "Category",
                categoryOptions,
                category,
                (val) => setState(() => category = val),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigation without validation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnquiryFromScreen2(),
                        ),
                      );
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
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    final hasItems = items.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: hasItems && items.contains(selectedValue) ? selectedValue : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items:
            hasItems
                ? items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList()
                : [],
        onChanged: hasItems ? onChanged : null,
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
