import 'package:flutter/material.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 360, // Adjust width for better alignment
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                const Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    'Explore Related Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Buttons
                buildProductButton(context, 'Greaser Power Chain'),
                const SizedBox(height: 15),
                buildProductButton(context, 'OP-52/OP-53'),
                const SizedBox(height: 20),
                buildProductButton(
                  context,
                  'Multi Line (Permanent) All IN ONE Monitoring + Lubrication',
                ),
                const SizedBox(height: 20),
                buildProductButton(
                  context,
                  'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductButton(BuildContext context, String title) {
    return Container(
      width: 310, // Reduced width for better visual spacing
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF83C9F9), Color(0xFF5CA8F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Add navigation or functionality here
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



