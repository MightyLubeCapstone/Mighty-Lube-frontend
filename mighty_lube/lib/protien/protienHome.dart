import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/protien/FGCO/UI/FGCO.dart';
import 'package:mighty_lube/protien/FGLM/UI/FGLM.dart';

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


class ProteinHome extends StatelessWidget {
  const ProteinHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180), // Adjusted for larger header logo
        child: Column(
          children: [
            // Header with logo and icons
            Stack(
              children: [
                const HeaderLogo(),
                Positioned(
                  top: 60, // Adjust position for icons
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.account_circle, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfilePage()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          // Add Cart functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Protein Title
                  const Text(
                    'Protein',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 0),
                  // Breadcrumb navigation with home icon
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DashboardPage()),
                          );
                        },
                        child: const Icon(
                          Icons.home,
                          color: Colors.blue,
                        ),
                      ),
                      const Text(' > ', style: TextStyle(color: Colors.black54)),
                      const Text(
                        'Application',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const Text(' > ', style: TextStyle(color: Colors.black54)),
                      const Text(
                        'Protein',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stacked vertical list of images with titles
            Expanded(
              child: ListView(
                children: [
                  _buildClickableImageCard(
                    context: context,
                    title: 'Food Grade Cleaner OP-8SS',
                    imagePath: 'assets/FGCO.png',
                    onTap: () {
                      // Navigate to Industrial page
                      // Replace the placeholder with your navigation code
                       Navigator.push(context,MaterialPageRoute(builder: (context) => const FGCOPage()),);
                      print('Navigated to Industrial');
                    },
                  ),
                  _buildClickableImageCard(
                    context: context,
                    title: 'Food Grade Lubrication and Monitor',
                    imagePath: 'assets/FGLM.png',
                    onTap: () {
                      // Navigate to Protein page
                       Navigator.push(context,MaterialPageRoute(builder: (context) => const FGLMPage()),);
                      print('Navigated to Protein');
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
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.black12, // Fallback background color
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'Image not found',
                      style: const TextStyle(
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