import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/drawer.dart';

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
                          builder: (context) => const ApplicationPage()),
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
                children: [
                  if (_filterCard('CC5 Chain (2)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'CC5 Chain (2)',
                      imagePath:
                          'assets/industrial/CC5 Chain (2)/CC5 Chain (2).png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Chain On Edge Drag Line (3)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Chain On Edge Drag Line (3)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Enclosed Track Inverted Power Only and PF (8)'))
                    _buildClickableImageCard(
                      context: context,
                      title:
                          'Enclosed Track Inverted Power Only and PF (8)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Enclosed Track Overhead Power Only and P&F (10)'))
                    _buildClickableImageCard(
                      context: context,
                      title:
                          'Enclosed Track Overhead Power Only and P&F (10)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Flat Top (4)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Flat Top (4)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Free Carrier (2)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Free Carrier (2)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Free Rail Overhead Or Inverted (6)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Free Rail Overhead Or Inverted (6)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('In Floor Tow Line (2)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'In Floor Tow Line (2)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('In-Board Roller Chain (3)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'In-Board Roller Chain (3)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Over Head Power Rail L-Beam (20)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Over Head Power Rail L-Beam (20)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
                        );
                      },
                    ),
                  if (_filterCard('Power and Free Overhead or Inverted (17)'))
                    _buildClickableImageCard(
                      context: context,
                      title: 'Power and Free Overhead or Inverted (17)',
                      imagePath: 'assets/industrial/Title.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndustrialHome()),
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

  // Helper function to filter cards based on the search query
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
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.black12,
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
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
