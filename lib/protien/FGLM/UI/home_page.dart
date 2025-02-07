import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protienHome.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBreadcrumbNavigation(context),
        const Padding(
          padding: EdgeInsets.fromLTRB(
              15.0, 30.0, 15.0, 20.0), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Food Grade Lubrication and Monitor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25), // Space between the title and description
              Text(
                'Mighty Lube has created conveyor maintenance equipment and lubricants to meet the specific needs of food industry manufacturers including poultry plants. '
                'Our food processing conveyor lubricators, monitoring systems and H1 lubricants have been tested and proven to provide significant cost savings in food industry conveyor operations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBreadcrumbNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.blue),
            onPressed: () {
              // Navigate to the home page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ApplicationPage()),
              );
            },
          ),
          const Text(
            ' > ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the Protein page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProteinHome()),
              ); // Replace with navigation to your Protein page
            },
            child: const Text(
              'Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
