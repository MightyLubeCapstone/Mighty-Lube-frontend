import 'package:flutter/material.dart';

import '../protien/FGCO/UI/FGCO.dart';
import '../protien/FGLM/UI/FGLM.dart';

class Product {
  final String title;
  final String imagePath;
  final Widget callback;
  const Product({
    required this.title,
    required this.imagePath,
    required this.callback,
  });
}

final Map<String, Product> productList = {
  // protein
  'Food Grade Cleaner OP-8SS': const Product(
    title: 'Food Grade Cleaner OP-8SS',
    imagePath: 'assets/FGCO.png',
    callback: FGCOPage(),
  ),
  'Food Grade Lubrication and Monitor': const Product(
    title: 'Food Grade Lubrication and Monitor',
    imagePath: 'assets/FGLM.png',
    callback: FGLMPage(),
  ),
};
