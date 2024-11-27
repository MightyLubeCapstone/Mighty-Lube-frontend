import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Increased height for a larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 100, // Increased width for a larger logo
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}


class ConfigurationsPage extends StatelessWidget {
  const ConfigurationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(100), // Increased height for the AppBar
        child: AppBar(
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
                      icon: const Icon(Icons.description, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ApplicationPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
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
      body: Column(
          children: [
          // Header Section
          //const HeaderLogo(),

          // Dashboard Content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No configurations have been made yet.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ApplicationPage()),
                        );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF579AF6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Browse Products',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
}
