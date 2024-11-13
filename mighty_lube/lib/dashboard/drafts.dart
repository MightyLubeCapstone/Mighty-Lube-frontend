import 'package:flutter/material.dart';

class DraftsPage extends StatelessWidget {
  const DraftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drafts: ',
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
