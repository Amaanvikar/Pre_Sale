import 'package:flutter/material.dart';
import 'package:pre_sale/Screens/inquiry_from_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Presale',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFDC3545),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _DashboardCard(
              imagePath: 'assets/images/Vector.png',
              label: 'Inquiry form',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InquiryFromScreen()),
                );
              },
            ),
            _DashboardCard(
              imagePath: 'assets/images/fluent-color_list-bar-16.png',
              label: 'Inquiry List',
              onTap: () {},
            ),
            _DashboardCard(
              imagePath: 'assets/images/material-icon-theme_terraform.png',
              label: 'Follow Up',
              onTap: () {},
            ),
            _DashboardCard(
              imagePath: 'assets/images/fluent-color_people-sync-24.png',
              label: 'Sync',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // side: BorderSide(color: Color(0xFFDC3545)),
        ),
        elevation: 4,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFDC3545),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
