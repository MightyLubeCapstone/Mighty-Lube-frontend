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

class IndustrialHome extends StatelessWidget {
  const IndustrialHome({super.key});

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
            // Breadcrumb Navigation
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to Home
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
                      MaterialPageRoute(
                          builder: (context) => const ApplicationPage()),
                    );
                  },
                  child: const Text(
                    'Industrial',
                    style: TextStyle(
                      color: Colors.blue, // Blue color for clickable text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Vertical list of images with text
            Expanded(
              child: ListView(
                children: [
                  _buildClickableImageCard( //CC5 Chain (2)
                    context: context,
                    title: 'CC5 Chain (2)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/CC5/CC5.png',
                    onTap: () {
                      // Navigate to Industrial page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()), 
                      );
                    },
                  ),
                  _buildClickableImageCard( //Chain On Edge Drag Line (3)
                    context: context,
                    title: 'Chain On Edge Drag Line (3)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Enclosed Track Inverted Power Only and PF (8)
                    context: context,
                    title: 'Enclosed Track Inverted Power Only and PF (8)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Enclosed Track Overhead Power Only and P&F (10)
                    context: context,
                    title: 'Enclosed Track Overhead Power Only and P&F (10)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Flat Top (4)
                    context: context,
                    title: 'Flat Top (4)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Free Carrier (2)
                    context: context,
                    title: 'Free Carrier (2)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Free Carrier (2)/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Free Rail Overhead Or Inverted (6)
                    context: context,
                    title: 'Free Rail Overhead Or Inverted (6)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //In Floor Tow Line (2)'
                    context: context,
                    title: 'In Floor Tow Line (2)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Free Carrier (2)/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //In-Board Roller Chain (3)
                    context: context,
                    title: 'In-Board Roller Chain (3)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Free Carrier (2)/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Over Head Power Rail L-Beam (20)
                    context: context,
                    title: 'Over Head Power Rail L-Beam (20)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndustrialHome()),
                      );
                    },
                  ),
                  _buildClickableImageCard( //Power and Free Overhead or Inverted (17)
                    context: context,
                    title: 'Power and Free Overhead or Inverted (17)',
                    imagePath: '/Users/addison/Mighty-Lube-frontend/mighty_lube/assets/industrial/Title.png',
                    onTap: () {
                      //Will need to be changed later
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
