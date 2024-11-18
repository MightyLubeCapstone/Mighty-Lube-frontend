import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_page.dart'; // Main home
import 'configuration_page.dart'; // Configuration section
import 'related_products_page.dart'; // Related products section
import 'image_page.dart';

class FGLMPage extends StatefulWidget {
  const FGLMPage({super.key});

  @override
  State<FGLMPage> createState() => _FGLMPageState();
}

class _FGLMPageState extends State<FGLMPage> {
  int _selectedIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = [
    const HomeSection(),
    const ImageSection(),
    const ConfigurationSection(),
    const RelatedProductsSection(),
  ];

  // Update the page on bottom navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          color: const Color(0xFF579AF6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Centered Logo
              Center(
                child: SvgPicture.asset(
                  'assets/WhiteML_Logo-w-tag-vector.svg',
                  width: 175, // Increased width for a larger logo
                  height: 175, // Adjust height proportionally
                  color: Colors.white,
                ),
              ),
              // Profile and Shopping Cart Icons
              Positioned(
                right: 16,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle,
                          color: Colors.white, size: 28),
                      onPressed: () {
                        // Navigate to profile page
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart,
                          color: Colors.white, size: 28),
                      onPressed: () {
                        // Navigate to shopping cart
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF3F4F6),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Configuration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Others',
          ),
        ],
      ),
    );
  }
}
