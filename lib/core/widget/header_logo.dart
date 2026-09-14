import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderLogo extends StatelessWidget {
  final bool pressable;
  final double width;
  final double height;

  const HeaderLogo({
    super.key,
    required this.pressable,
    this.width = 100,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressable ? () {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: SvgPicture.asset('assets/WhiteML_Logo-w-tag-vector.svg',
        width: width,
        height: height,
        fit: BoxFit.contain,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}