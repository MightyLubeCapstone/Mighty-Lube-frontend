import 'package:flutter/material.dart';

class ConfigurationsPage extends StatelessWidget {
  const ConfigurationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurations: ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Consistent with the LoginPage header
          ),
        ),
        backgroundColor: const Color(0xFF579AF6),
      ),
    );
  }
}
