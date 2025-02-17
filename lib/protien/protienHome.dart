import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/protien/FGCO/UI/FGCO.dart';
import 'package:mighty_lube/protien/FGLM/UI/FGLM.dart';

import '../application/UI/applicationHome.dart';
import '../dashboard/UI/dashboard.dart';
import '../industrial/product_list.dart';


class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 100, // Adjust width for larger logo
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}

class ProteinHome extends StatefulWidget {
  const ProteinHome({super.key});

  @override
  State<ProteinHome> createState() => _ProteinHomeState();
}

class _ProteinHomeState extends State<ProteinHome> {
  String searchQuery = '';

  bool _filterCard(String title) {
    return title.toLowerCase().contains(searchQuery.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        link: ProfilePage(),
        customIcon: Icons.person,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          builder: (context) => const ApplicationPage()),
                    );
                  },
                  child: const Text(
                    'Protein',
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
            // Stacked vertical list of images with titles
            Expanded(
              child: ListView(
                children: (searchQuery == '')
                    ? _buildDefaultCards()
                    : _buildDynamicList(),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Reusable widget for image cards
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(
                    255, 87, 154, 246), 
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

  List<Widget> _buildDefaultCards() {
    return [
      _buildClickableImageCard(
        context: context,
        title: 'Food Grade Cleaner OP-8SS',
        imagePath: 'assets/FGCO.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FGCOPage()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Food Grade Lubrication and Monitor',
        imagePath: 'assets/FGLM.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FGLMPage()),
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
