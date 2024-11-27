import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';


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
          width: 100, // Logo width
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: const Color(0xFF579AF6),
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            const HeaderLogo(), // Full header logo
            Positioned(
              top: 50, // Adjust position as needed
              right: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.account_circle,color: Colors.white),
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfilePage()),);
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
      ),
    ),
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const DashboardPage()),);
                  },
                  child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.blue, // Blue color for the icon
                    ),
                    const SizedBox(width: 4), // Space between icon and arrow
                  ],
                ),
                ),
                const Text(' > '),
                const Text(
                  'Application',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Vertical list of images with text
            Expanded(
            child: ListView(
              children: [
                _buildImageCard(
                  title: 'Industrial (77)',
                  imagePath: 'assets/Industrial.png',
                ),
                _buildImageCard(
                  title: 'Protein (2)',
                  imagePath: 'assets/Protein.png',
                ),
                _buildImageCard(
                  title: 'Technician (1)',
                  imagePath: 'assets/Technician.png',
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
  Widget _buildImageCard({required String title, required String imagePath}) {
  return Padding(
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
  );
}

}
