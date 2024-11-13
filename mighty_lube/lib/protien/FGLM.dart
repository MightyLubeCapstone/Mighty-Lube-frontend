import 'package:flutter/material.dart';

class FGLMPage extends StatelessWidget {
  const FGLMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Grade Lubrication and Monitor: ',
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