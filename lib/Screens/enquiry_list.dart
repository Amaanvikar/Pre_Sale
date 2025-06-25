import 'package:PreSale/Api/Helper/constant.dart';
import 'package:flutter/material.dart';

class EnquiryListScreen extends StatelessWidget {
  const EnquiryListScreen({super.key});

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
        'nextfollowupDate': '15/may/2025',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enquiry list:',
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
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Just show enquiry number directly
                  Text(
                    item['enquiryNo'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Status and Enquiry Date on same line
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
                      const Text('| ', style: TextStyle(color: Colors.grey)),
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
                  const SizedBox(height: 4),
                  Text('Next Followup Date: ${item['nextfollowupDate']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
