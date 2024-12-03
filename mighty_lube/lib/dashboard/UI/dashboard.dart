import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:mighty_lube/LoginPage/UI/loginPage.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/configurations.dart';
import 'package:mighty_lube/dashboard/UI/drafts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mighty_lube/LoginPage/API/app_state.dart';
import 'profile.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 100, // Adjust width for larger logo
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<String> getUsername() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('currentUsername');

      if (username == null || username.isEmpty) {
        throw Exception('Username not found');
      }

      return username;
    } catch (e) {
      print(e);
      return 'Error fetching name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Larger AppBar
        child: AppBar(
          backgroundColor: const Color(0xFF579AF6),
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              const HeaderLogo(),
              Positioned(
                top: 50, // Adjust position
                right: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.description, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ApplicationPage()),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF579AF6),
              ),
              child: HeaderLogo(),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConfigurationsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drafts),
              title: const Text('Drafts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DraftsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account Details'),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await ApiState().logoutUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<String>(
                future: getUsername(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  } else if (snapshot.hasError) {
                    return const Text('Error fetching name');
                  } else {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hello ${snapshot.data}, ',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '(not ${snapshot.data}? ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                            text: '(Log out)',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to log out
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text.rich(
              TextSpan(
                text: 'From your account dashboard you can view your ',
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: 'recent configurations',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConfigurationsPage()),
                        );
                      },
                  ),
                  const TextSpan(
                    text: ', manage your ',
                  ),

                  // LEAVE THIS SPACING ALONE!!
                  // I FOUND A SPECIAL LEVEL UP PAGE THAT I'M NOT GONNA TOUCH RN
                  // ANTHONY DIDN"T SAY ANYTHING ABOUT THIS SO MAYBE IT'S NOT SUPPOSED TO BE HERE?
                  TextSpan(
                    text: 'billing address',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to billing address
                        print('Navigate to billing address');
                      },
                  ),

                  const TextSpan(
                    text: ', and ',
                  ),
                  TextSpan(
                    text: 'edit your password and account details.',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        // Navigate to account details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
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
