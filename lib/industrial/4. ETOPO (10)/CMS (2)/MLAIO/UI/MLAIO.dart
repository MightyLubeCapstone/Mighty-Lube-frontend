import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'home_page.dart'; // Main home
import 'configuration_page.dart'; // Configuration section
import 'image_page.dart';

class MLAIOPage extends StatefulWidget {
  const MLAIOPage({super.key});

  @override
  State<MLAIOPage> createState() => MLAIOPageState();
}

class MLAIOPageState extends State<MLAIOPage> {
  int _selectedIndex = 0;

  // Pages for bottom navigation
  final List<Widget> _pages = [
    const HomeSection(),
    const ImageSection(),
    const ConfigurationSection(),
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
                  width: 100, // Increased width for a larger logo
                  height: 150, // Adjust height proportionally
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
              ),
              // Profile and Shopping Cart Icons
              Positioned(
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0), // Add padding to the top and bottom
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(202, 215, 217, 223),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: const Color.fromARGB(255, 68, 66, 66),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Configuration',
            ),
          ],
        ),
      ),
    );
  }
}
