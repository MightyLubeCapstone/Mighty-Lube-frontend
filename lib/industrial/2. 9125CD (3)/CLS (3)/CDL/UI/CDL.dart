import 'package:flutter/material.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/dashboard/UI/profile.dart';
import 'package:mighty_lube/drawer.dart';
import 'home_page.dart'; // Main home
import 'configuration_page.dart'; // Configuration section
import 'image_page.dart';

class CDLPage extends StatefulWidget {
  const CDLPage({super.key});

  @override
  State<CDLPage> createState() => CDLPageState();
}

class CDLPageState extends State<CDLPage> {
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
      appBar: CustomAppBar(
        link: const ProfilePage(),
        customIcon: Icons.description,
      ),
      drawer: const CustomDrawer(),
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
