import 'package:flutter/material.dart';

class InquiryListScreen extends StatelessWidget {
  const InquiryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> inquiries = [
      {
        'inquiryNo': 'E2501KAE00001',
        'status': 'open',
        'inquiryDate': '15/may/2025 01:20PM',
        'customerName': 'A.P.Kadam',
        'mobileNo': '9999999999',
        'followupDate': '15/may/2025',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inquiry list:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: inquiries.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final item = inquiries[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFFDC3545)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'inquiry No: ',
                          style: TextStyle(
                            color: Color(0xFFDC3545),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: item['inquiryNo']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Status: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: item['status']!,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('inquiry Date: ${item['inquiryDate']}'),
                  const SizedBox(height: 6),
                  Text('Customer name: ${item['customerName']}'),
                  const SizedBox(height: 6),
                  Text('Mob no: ${item['mobileNo']}'),
                  const SizedBox(height: 4),
                  Text('Followup Date: ${item['followupDate']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
