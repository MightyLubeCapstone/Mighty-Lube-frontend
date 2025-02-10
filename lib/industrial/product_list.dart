import 'package:mighty_lube/industrial/1.%20CC5C%20(2)/CLS%20(2)/MLCC5CL/UI/MLCC5CL.dart';
import 'package:mighty_lube/industrial/1.%20CC5C%20(2)/CLS%20(2)/OP40E/UI/OP40E.dart';
import 'package:mighty_lube/industrial/2.%20COEDL%20(3)/CLS%20(3)/CDL/UI/CDL.dart';
import 'package:mighty_lube/industrial/2.%20COEDL%20(3)/CLS%20(3)/MLCEL/UI/MLCEL.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CCS%20(2)/O8074/UI/O8074.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CCS%20(2)/OUN91/UI/OUN91.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/9000INVL/UI/9000INVL.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/OP41A/UI/OP41A.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CLS%20(3)/OP48E/UI/OP48E.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(8)/CMS%20(1)/MLAIO/UI/MLAIO.dart';

import 'package:flutter/material.dart';

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
  // 1. CC5
  'Mighty Lube CC5 Chain Lubricator': const Product(
    title: 'Mighty Lube CC5 Chain Lubricator',
    imagePath: 'assets/industrial/CC5 Chain (2)/CLS (2)/MLCCL.png',
    callback: MLCC5CLPage(),
  ),
  'OP-40E': const Product(
    title: 'OP-40E',
    imagePath: 'assets/industrial/CC5 Chain (2)/CLS (2)/OP-40E.png',
    callback: OP40EPage(),
  ),
  // 2. COEDL
  'Caterillar Drive Lubricators': const Product(
    title: 'Caterillar Drive Lubricators',
    imagePath:
        'assets/industrial/Chain On Edge Drag Line (3)/Conveyor Lub. Systems/CDL.png',
    callback: CDLPage(),
  ),
  'Mighty Lube Chain on Edge Lubricator': const Product(
    title: 'Mighty Lube Chain on Edge Lubricator',
    imagePath:
        'assets/industrial/Chain On Edge Drag Line (3)/Conveyor Lub. Systems/MLCEL.png',
    callback: MLCELPage(),
  ),
  // 3. ETIPO (8)
  'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91': const Product(
    title: 'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Cleaning Solutions (2)/UN91.png',
    callback: OUN91Page(),
  ),
  'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-':
      const Product(
    title: 'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Cleaning Solutions (2)/8074-B.png',
    callback: O8074Page(),
  ),
  '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators':
      const Product(
    title: '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/9000INVL.png',
    callback: Page900INVL(),
  ),
  'OP-41A Conveyor Lubricators': const Product(
    title: 'OP-41A Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-41A.png',
    callback: OP41APage(),
  ),
  'OP-48E': const Product(
    title: 'OP-48E',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-48E.png',
    callback: OP48EPage(),
  ),
  'Multi Line (Permanent) All IN ONE Monitoring + Lubrication': const Product(
    title: 'Multi Line (Permanent) All IN ONE Monitoring + Lubrication',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Monitor Systems (1)/Multi Line.png',
    callback: MLAIOPage(),
  ),
  // 4. ETOPO (10)
  // 5. FT(4)
  // 6. FC(2)
  // 7. FROOI (6)
  // 8. IFTL (2)
  // 9. IBRC (3)
  // 10. OHPRLB (20)
  // 11. PAFOOI (17)
};
