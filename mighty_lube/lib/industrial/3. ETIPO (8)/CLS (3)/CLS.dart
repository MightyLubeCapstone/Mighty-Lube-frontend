import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/9000INVL/UI/9000INVL.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/OP41A/UI/OP41A.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/OP48E/UI/OP48E.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/subfolders.dart';


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

class CLSETIPO extends StatefulWidget {
  const CLSETIPO({super.key});

  @override
  State<CLSETIPO> createState() => CLSETIPOState();
}

class CLSETIPOState extends State<CLSETIPO> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        link: ApplicationPage(),
        customIcon: Icons.description,
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
                          builder: (context) => const DashboardPage()),
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
                          builder: (context) => const ETIPONav()),
                    );
                  },
                  child: const Text(
                    'CLS',
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
            const SizedBox(height: 20),

            // Vertical list of images with text, filtered by search query
            Expanded(
              child: ListView(
                children: [
                    _buildClickableImageCard(
                      context: context,
                      title: '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators:',
                      imagePath:
                          'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/9000INVL.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const INVLPage()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'OP-41A Conveyor Lubricators:',
                      imagePath:
                          'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-41A.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OP41APage()),
                        );
                      },
                    ),
                    _buildClickableImageCard(
                      context: context,
                      title: 'OP-48E Conveyor Lubricators:',
                      imagePath:
                          'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-48E.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OP48EPage()),
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