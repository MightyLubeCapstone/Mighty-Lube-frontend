import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/application_home.dart';
import 'package:mighty_lube/protien/protein_home.dart';
import 'package:mighty_lube/helper_widgets.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const ProteinHome()),
        const Padding(
          padding: EdgeInsets.fromLTRB(
              15.0, 30.0, 15.0, 20.0), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Food Grade Cleaner OP-8SS:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25), // Space between the title and description
              Text(
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
}
