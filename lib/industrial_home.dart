import 'package:flutter/material.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/application_home.dart';
import 'package:mighty_lube/dashboard/UI/dashboard.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/drawer.dart';

class IndustrialHome extends StatefulWidget {
  const IndustrialHome({super.key});

  @override
  State<IndustrialHome> createState() => _IndustrialHomeState();
}

class _IndustrialHomeState extends State<IndustrialHome> {
  // Helper function to filter cards based on the search query
  String searchQuery = '';

  // bool _filterCard(String title) {
  //   return title.toLowerCase().contains(searchQuery.toLowerCase());
  // }

  // Widget _buildClickableImageCard({
  //   required BuildContext context,
  //   required String title,
  //   required String imagePath,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Title
  //           Container(
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
  //             decoration: const BoxDecoration(
  //               color: Color.fromARGB(
  //                   255, 87, 154, 246), // Same blue as breadcrumb nav
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(12.0),
  //                 topRight: Radius.circular(12.0),
  //               ),
  //             ),
  //             child: Text(
  //               title,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //           // Image
  //           Container(
  //             height: 250,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                   color: const Color.fromARGB(28, 50, 51, 52),
  //                   width: 3.0), // More noticeable border
  //               borderRadius: const BorderRadius.only(
  //                 bottomLeft: Radius.circular(12.0),
  //                 bottomRight: Radius.circular(12.0),
  //               ),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: const Color.fromARGB(25, 54, 53, 53)
  //                       .withOpacity(0.3), // More prominent shadow
  //                   blurRadius: 10.0,
  //                   offset: const Offset(0, 6),
  //                 ),
  //               ],
  //             ),
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.only(
  //                 bottomLeft: Radius.circular(12.0),
  //                 bottomRight: Radius.circular(12.0),
  //               ),
  //               child: Image.asset(
  //                 imagePath,
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return const Center(
  //                     child: Text(
  //                       'Image not found',
  //                       style: TextStyle(
  //                         color: Colors.black54,
  //                         fontSize: 14,
  //                         fontStyle: FontStyle.italic,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
          ],
        ),
      ),
    );
  }
}
