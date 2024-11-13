import 'package:flutter/material.dart';

class FGCOPage extends StatelessWidget {
  const FGCOPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Grade Cleaner OP-8SS : ',
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