import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color.fromARGB(255, 87, 154, 246),
                /*funny color color: const Color.fromARGB(255, 66,6,159),*/
                child: SvgPicture.asset(
                  'assets/WhiteML_Logo-w-tag-vector.svg',
                  width: 220,
                  height: 220,
                  color: Color.fromARGB(255, 249, 249, 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
