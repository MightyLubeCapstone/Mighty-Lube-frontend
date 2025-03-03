import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:mighty_lube/LoginPage/UI/login_page.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/application_home.dart';
import 'package:mighty_lube/dashboard/UI/configurations.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../LoginPage/API/apicalls.dart';
import 'profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool loading = false;
  String name = "error";
  int totalQuantities = 0;

  void getOrders() async {
    setState(() {
      loading = true;
    });
    dynamic cart = await CartAPI().getOrders();
    for (var order in cart) {
      totalQuantities = order["quantity"] as int;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
    getOrders();
  }

  Future<void> logoutUser() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel deletion
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm deletion
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    if (confirmDelete != true) return; // Exit if user cancels

    bool status = await ApiState().logoutUser();
    if (!mounted) return;
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully logged out!')),
      );
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when logging out!')),
      );
    }
  }

  Future<String> getName() async {
    try {
      setState(() {
        loading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/users/userinfo");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.get("sessionID")}',
      };
      final response = await http.get(uri, headers: headers);
      setState(() {
        loading = false;
      });
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        name = data["username"];
      }

      return name;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'Error fetching name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Hello $name, ',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(not $name? )',
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  child: const Text(
                    '(Log out)',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onPressed: () {
                    logoutUser();
                  },
                ),
              ],
            ),
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
                          MaterialPageRoute(builder: (context) => ConfigurationsPage()),
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
                        if (kDebugMode) {
                          print('Navigate to billing address');
                        }
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
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
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
