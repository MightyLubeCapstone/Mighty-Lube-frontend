import 'package:flutter/material.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/industrial/industrialHome.dart';
import 'package:mighty_lube/product_list.dart';
import 'package:mighty_lube/protien/protein_home.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  String searchQuery = '';

  bool _filterCard(String title) {
    return title.toLowerCase().contains(searchQuery.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationPage(),
        customIcon: Icons.description,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb Navigation
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to Home
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardPage()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.blue, // Blue color for the icon
                      ),
                      SizedBox(width: 4), // Space between icon and arrow
                    ],
                  ),
                ),
                const Text(' > '),
                GestureDetector(
                  onTap: () {
                    // Navigate to the Application page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ApplicationPage()),
                    );
                  },
                  child: const Text(
                    'Application',
                    style: TextStyle(
                      color: Colors.blue, // Blue color for clickable text
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

            // Vertical list of images with text
            Expanded(
              child: ListView(
                children: (searchQuery == "") ? _buildDefaultCards() : _buildDynamicList(),
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
        title: 'Industrial (76)',
        imagePath: 'assets/Industrial.png',
        onTap: () {
          // Navigate to Industrial page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IndustrialHome()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Protein (2)',
        imagePath: 'assets/Protein.png',
        onTap: () {
          // Navigate to Protein page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProteinHome()),
          );
        },
      ),
      _buildClickableImageCard(
        context: context,
        title: 'Technician (1)',
        imagePath: 'assets/Technician.png',
        onTap: () {
          // Navigate to Technician page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IndustrialHome()),
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
                        .withValues(alpha: 0.3), // More prominent shadow
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
