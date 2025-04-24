import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/drawer.dart';

import 'package:mighty_lube/industrial/1.%20CC5C%20(2)/CLS%20(2)/CLS.dart';
import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/subfolders.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(17)/subfolders.dart';
import 'package:mighty_lube/industrial/2.%209125CD%20(3)/subfolder.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/subfolders.dart';
import 'package:mighty_lube/industrial/4.%20ETOPO%20(10)/subfolders.dart';
import 'package:mighty_lube/industrial/5.%20FT(4)/subfolders.dart';
import 'package:mighty_lube/industrial/6.%20FC%20(2)/products.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/subfolders.dart';
import 'package:mighty_lube/industrial/8.%20IFTL%20(2)/subfolder.dart';
import 'package:mighty_lube/industrial/9.%20IBRC%20(3)/subfolders.dart';
import 'package:mighty_lube/product_list.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 100,
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}

class IndustrialHome extends StatefulWidget {
  const IndustrialHome({super.key});

  @override
  State<IndustrialHome> createState() => _IndustrialHomeState();
}

class _IndustrialHomeState extends State<IndustrialHome> {
  // Helper function to filter cards based on the search query
  String searchQuery = '';

  bool _filterCard(String title) {
    return title.toLowerCase().contains(searchQuery.toLowerCase());
  }

  Widget _buildClickableImageCard({
    required BuildContext context,
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 87, 154, 246), // Same blue as breadcrumb nav
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(28, 50, 51, 52),
                    width: 3.0), // More noticeable border
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(25, 54, 53, 53)
                        .withOpacity(0.3), // More prominent shadow
                    blurRadius: 10.0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Image not found',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ProfilePage(),
        customIcon: Icons.person,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb Navigation with Search Box
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardPage()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                ),
                const Text(' > '),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ApplicationPage()),
                    );
                  },
                  child: const Text(
                    'Industrial',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Search Box
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      suffixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Vertical list of images with text, filtered by search query
            Expanded(
              child: ListView(
                children:
                    // if search hasn't been activated...
                    // else build dynamic list
                    (searchQuery == '') ? _buildDefaultCards() : _buildDynamicList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDefaultCards() {
    return [
      _buildClickableImageCard(
        context: context,
        title: 'CC5 Chain (2)',
        imagePath: 'assets/industrial/CC5 Chain (2)/CC5 Chain (2).png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CLSHome()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: '9125/9126 Caterpillar Drive (3)',
        imagePath: 'assets/industrial/Title.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const COEDLNav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Enclosed Track Inverted Power Only and PF (4)',
        imagePath: 'assets/industrial/Title.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ETIPONav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Enclosed Track Overhead Power Only and P&F (10)',
        imagePath: 'assets/industrial/Title.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ETOPONav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Flat Top (4)',
        imagePath: 'assets/industrial/Flat Top (4)/flat-top.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FTNav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Free Carrier (2)',
        imagePath: 'assets/industrial/Free Carrier (2)/Title.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FCProducts()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'C Channel Overhead Or Inverted (6)',
        imagePath: 'assets/industrial/FreeRail.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FROOINav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'In Floor Tow Line (2)',
        imagePath: 'assets/industrial/inFloor.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IFTLNav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'In-Board Roller Chain (3)',
        imagePath: 'assets/industrial/inBoard.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IBRCNav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Over Head Power Rail L-Beam (20)',
        imagePath: 'assets/industrial/OverHeadPower.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OHPRLBNav()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Power and Free Overhead or Inverted (17)',
        imagePath: 'assets/industrial/Title.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PAFOOINav()),
          );
        },
      ),
    ];
  }

  List<Widget> _buildDynamicList() {
    return productList.entries
        .where((entry) => _filterCard(entry.key))
        .map((entry) => _buildClickableImageCard(
              context: context,
              title: entry.value.title,
              imagePath: entry.value.imagePath,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => entry.value.callback),
                );
              },
            ))
        .toList();
  }
}
