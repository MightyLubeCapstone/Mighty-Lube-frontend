import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/CCS%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CCSProducts()),
        const Padding(
          padding: EdgeInsets.fromLTRB(
              15.0, 30.0, 15.0, 20.0), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-B:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25), // Space between the title and description
              Text(
                'This is a place holder. There is nothing on the site for this one.'
                'The Aluminum and Stainless Steel OP-8SS Powered Brush assembly cleans the chains and trolley for conveyors in food industry plants. '
                'The OP-8SS powered brush assembly cleans conveyor chains, trolley wheels and trolley brackets. It fits every size of overhead monorail or power & free conveyor.',
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
