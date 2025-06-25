import 'package:PreSale/Api/Helper/constant.dart';
import 'package:PreSale/Screens/follow_up_form.dart';
import 'package:flutter/material.dart';

class FollowUplist extends StatefulWidget {
  const FollowUplist({super.key});

  @override
  State<FollowUplist> createState() => _FollowUplistState();
}

class _FollowUplistState extends State<FollowUplist> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> enquiries = [
      {
        'enquiryNo': 'E2501KAE00001',
        'status': 'open',
        'enquiryDate': '15/may/2025 01:20PM',
        'customerName': 'A.P.Kadam',
        'mobileNo': '9999999999',
        'followupDate': '15/may/2025',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Follow-up List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: enquiries.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final item = enquiries[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: kPrimaryColor),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enquiry Number
                      Text(
                        item['enquiryNo'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Status and Enquiry Date
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            item['status'] ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '| ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['enquiryDate'] ?? '',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('Customer name: ${item['customerName']}'),
                      const SizedBox(height: 6),
                      Text('Mob no: ${item['mobileNo']}'),
                      const SizedBox(height: 4),
                      Text('Followup Date: ${item['followupDate']}'),
                    ],
                  ),
                ),
                // Edit icon in top-right
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FollowUpFormScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
