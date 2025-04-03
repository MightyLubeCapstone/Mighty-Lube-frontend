import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderLogo extends StatelessWidget {
  final bool pressable;

  const HeaderLogo({super.key, required this.pressable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: TextButton(
          onPressed: pressable
              ? () {
                  Navigator.of(context).pushReplacementNamed("/dashboard");
                } // Disable button by setting onPressed to null
              : null,
          child: SvgPicture.asset(
            'assets/WhiteML_Logo-w-tag-vector.svg',
            width: 100, // Adjust width for larger logo
            height: 150,
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(255, 255, 255, 255), // White color
              BlendMode.srcIn, // Ensures proper color application
            ),
          ),
        ),
      ),
    );
  }
}
