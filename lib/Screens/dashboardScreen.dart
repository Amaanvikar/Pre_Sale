import 'package:PreSale/Api/Helper/constant.dart';
import 'package:PreSale/Screens/followUpListScreen.dart';
import 'package:PreSale/widgets/appDrawer.dart';
import 'package:PreSale/widgets/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:PreSale/Screens/InquiryForms/enquiryInformationScreen.dart';
import 'package:PreSale/Screens/enquiryListScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.account_circle_rounded, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            // dashboardItems.map((item) {
            //   return _DashboardCard(
            //     imagePath: item['image'],
            //     label: item['labels'],
            //     onTap: () {
            //       if (item['screen'] != null) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: () => item['screen']),
            //         );
            //       }
            //     },
            //   );
            // }).toList(),
            _DashboardCard(
              imagePath: 'assets/images/Vector.png',
              label: 'Enquiry form',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnquiryFromScreen(),
                  ),
                );
              },
            ),
            _DashboardCard(
              imagePath: 'assets/images/fluent-color_list-bar-16.png',
              label: 'Enquiry List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnquiryListScreen()),
                );
              },
            ),
            _DashboardCard(
              imagePath: 'assets/images/material-icon-theme_terraform.png',
              label: 'Follow Up',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowUplist()),
                );
              },
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

final dashboardItems = [
  {
    'image': 'assets/images/Vector.png',
    'label': 'Enquiry form',
    'screen': const EnquiryFromScreen(),
  },
  {
    'image': 'assets/images/fluent-color_list-bar-16.png',
    'label': 'Enquiry List',
    'screen': EnquiryListScreen(),
  },
  {
    'image': 'assets/images/material-icon-theme_terraform.png',
    'label': 'Follow Up',
    'screen': FollowUplist(),
  },
  {
    'image': 'assets/images/fluent-color_people-sync-24.png',
    'label': 'Sync',
    'screen': null,
  },
];

class _DashboardCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _DashboardCard({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // side: BorderSide(color: kPrimaryColor),
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
                    color: kPrimaryColor,
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
