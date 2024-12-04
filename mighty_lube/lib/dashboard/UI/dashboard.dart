import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mighty_lube/LoginPage/UI/loginPage.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/dashboard/UI/configurations.dart';
import 'package:mighty_lube/dashboard/UI/drafts.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mighty_lube/LoginPage/API/apicalls.dart';
import 'profile.dart';

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
      appBar: const CustomAppBar(
        link: ApplicationPage(),
        customIcon: Icons.description ,
      ),
      drawer: const CustomDrawer(),
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
