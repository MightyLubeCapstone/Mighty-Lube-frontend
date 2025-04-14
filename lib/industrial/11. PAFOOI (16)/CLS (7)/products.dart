import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/drawer.dart';

import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/9000L/UI/9000L.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/9000LFCCCL/UI/9000LFCCCL.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/9000LTCL/UI/9000LTCL.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/CDL/UI/CDL.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/ES/UI/ES.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/OP139A/UI/OP139A.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/OP55/UI/OP55.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/subfolders.dart';






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

class CLSProducts extends StatefulWidget {
  const CLSProducts({super.key});

  @override
  State<CLSProducts> createState() => CLSProductsState();
}

class CLSProductsState extends State<CLSProducts> {
  String searchQuery = '';

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
                      MaterialPageRoute(
                          builder: (context) => const ApplicationPage()),
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
                      MaterialPageRoute(
                          builder: (context) => const PAFOOINav()),
                    );
                  },
                  child: const Text(
                    'Conveyor Lubrication Systems',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // Search Box
              ],
            ),

            // Vertical list of images with text, filtered by search query
            Expanded(
              child: ListView(
                children: [
                    _buildClickableImageCard(
                      context: context,
                      title: '9000L Series Central Overhead I -Beam Conveyor Lubricators',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/9000L.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Page9000L()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: '9000L Series Central System Power and Free C-Channel Conveyor Lubricators',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/9000LFCCCL.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Page9000LFCCCL()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: '9000L Series Central System Enclosed Track Conveyor Lubricators',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/9000LTCL.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Page9000LTCL()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'Caterpillar Drive Lubricators',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/CDL.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CDLPage()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'E-Series',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/ES.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ESPage()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'OP-55',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/OP55.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OP55Page()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'OP-139A',
                      imagePath:
                          'assets/industrial/PFOOI/CLS/OP139A.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OP139APage()),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
              border: Border.all(color: const Color.fromARGB(28, 50, 51, 52), width: 3.0), // More noticeable border
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(25, 54, 53, 53).withOpacity(0.3), // More prominent shadow
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


}