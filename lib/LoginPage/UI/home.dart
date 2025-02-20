import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../env.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool valid = false;

  @override
  void initState() {
    super.initState();
    _validate();
  }

  void _validate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/sessions");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}"
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // Navigate to dashboard if session is valid
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Navigate to login if session is invalid
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (error) {
      print(error);
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
