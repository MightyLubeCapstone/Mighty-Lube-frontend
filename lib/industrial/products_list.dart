import 'package:flutter/material.dart';
import '1. CC5C (2)/CLS (2)/MLCC5CL/UI/MLCC5CL.dart';
import '1. CC5C (2)/CLS (2)/OP40E/UI/OP40E.dart';
import '2. COEDL (3)/CLS (3)/CDL/UI/CDL.dart';
import '2. COEDL (3)/CLS (3)/MLCEL/UI/MLCEL.dart';
import '3. ETIPO (8)/CCS (2)/OUN91/UI/OUN91.dart';
import '3. ETIPO (8)/CCS (2)/O8074/UI/O8074.dart';
import '3. ETIPO (8)/CLS (3)/9000INVL/UI/9000INVL.dart';
import '3. ETIPO (8)/CLS (3)/OP41A/UI/OP41A.dart';
import '3. ETIPO (8)/CLS (3)/OP48E/UI/OP48E.dart';
import '3. ETIPO (8)/CMS (1)/MLAIO/UI/MLAIO.dart';

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

const Map<String, Product> productList = {
  // 1. CC5
  'Mighty Lube CC5 Chain Lubricator': Product(
    title: 'Mighty Lube CC5 Chain Lubricator',
    imagePath: 'assets/industrial/CC5 Chain (2)/CLS (2)/MLCCL.png',
    callback: MLCC5CLPage(),
  ),
  'OP-40E': Product(
    title: 'OP-40E',
    imagePath: 'assets/industrial/CC5 Chain (2)/CLS (2)/OP-40E.png',
    callback: OP40EPage(),
  ),
  // 2. COEDL
  'Caterillar Drive Lubricators': Product(
    title: 'Caterillar Drive Lubricators',
    imagePath:
        'assets/industrial/Chain On Edge Drag Line (3)/Conveyor Lub. Systems/CDL.png',
    callback: CDLPage(),
  ),
  'Mighty Lube Chain on Edge Lubricator': Product(
    title: 'Mighty Lube Chain on Edge Lubricator',
    imagePath:
        'assets/industrial/Chain On Edge Drag Line (3)/Conveyor Lub. Systems/MLCEL.png',
    callback: MLCELPage(),
  ),
  // 3. ETIPO (8)
  'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91': Product(
    title: 'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Cleaning Solutions (2)/UN91.png',
    callback: OUN91Page(),
  ),
  'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-': Product(
    title: 'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Cleaning Solutions (2)/8074-B.png',
    callback: O8074Page(),
  ),
  '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators': Product(
    title: '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/9000INVL.png',
    callback: Page900INVL(),
  ),
  'OP-41A Conveyor Lubricators': Product(
    title: 'OP-41A Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-41A.png',
    callback: OP41APage(),
  ),
  'OP-48E': Product(
    title: 'OP-48E',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-48E.png',
    callback: OP48EPage(),
  ),
  'Multi Line (Permanent) All IN ONE Monitoring + Lubrication': Product(
    title: 'Multi Line (Permanent) All IN ONE Monitoring + Lubrication',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Monitor Systems (1)/Multi Line.png',
    callback: MLAIOPage(),
  ),
  // 4. ETOPO (10)
  // 5. FT(40)
  // 6. FC(2)
  // 7. FROOI (6)
  // 8. IFTL (2)
  // 9. IBRC (3)
  // 10. OHPRLB (20)
  // 11. PAFOOI (17)
};
