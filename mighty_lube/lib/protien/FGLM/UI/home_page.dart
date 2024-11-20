import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
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
    );
  }
}
