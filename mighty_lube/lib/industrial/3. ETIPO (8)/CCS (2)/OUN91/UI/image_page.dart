import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CCS%20(2)/products.dart';


class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBreadcrumbNavigation(context),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Image Card Section
        Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 350,
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Cleaning Solutions (2)/UN91.png', // Path to your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                MaterialPageRoute(builder: (context) => const CCSProducts()),
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
