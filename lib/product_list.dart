import 'package:flutter/material.dart';

import '../protien/FGCO/UI/FGCO.dart';
import '../protien/FGLM/UI/FGLM.dart';
import 'industrial/1. CC5C (2)/CLS (2)/MLCC5CL/UI/MLCC5CL.dart';
import 'industrial/1. CC5C (2)/CLS (2)/OP40E/UI/OP40E.dart';
import 'industrial/2. 9125CD (3)/CLS (3)/CDL/UI/CDL.dart';
import 'industrial/2. 9125CD (3)/CLS (3)/MLCEL/UI/MLCEL.dart';
import 'industrial/3. ETIPO (4)/CCS (2)/O8074/UI/O8074.dart';
import 'industrial/3. ETIPO (4)/CCS (2)/OUN91/UI/OUN91.dart';
import 'industrial/3. ETIPO (4)/CLS (2)/9000INVL/UI/9000INVL.dart';
import 'industrial/3. ETIPO (4)/CLS (2)/OP48E/UI/OP48E.dart';
import 'industrial/4. ETOPO (10)/CLS (4)/2100L/UI/2100L.dart';
import 'industrial/4. ETOPO (10)/CLS (4)/9000L/UI/9000L.dart';
import 'industrial/4. ETOPO (10)/CMS (2)/PMLMS/UI/PMLMS.dart';
import 'industrial/5. FT(4)/CGS (1)/OPCO300/UI/OPCO300.dart';
import 'industrial/6. FC (2)/FR314/UI/FR314.dart';
import 'industrial/6. FC (2)/FR317/UI/FR317.dart';
import 'industrial/7. CCOOI (6)/CLS (3)/ES/UI/ES.dart';
import 'industrial/7. CCOOI (6)/CLS (3)/OP139A/UI/OP139A.dart';
import 'industrial/8. IFTL (2)/CLS (2)/MLIFTL/UI/MLIFTL.dart';
import 'industrial/9. IBRC (3)/CLS (2)/MLRFC/UI/MLRFC.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/300I/UI/300I.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/LBCBS/UI/LBCBS.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/OEB/UI/OEB.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/OP13/UI/OP13.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/OP55/UI/OP55.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/OP8/UI/OP8.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/OP8NP/UI/OP8NP.dart';
import 'industrial/10. OHPRLB (20)/CCS (8)/YCB/UI/YCB.dart';
import 'industrial/10. OHPRLB (20)/CGS (1)/GPC/UI/GPC.dart';
import 'industrial/10. OHPRLB (20)/CLS (7)/2100L/UI/2100L.dart';
import 'industrial/10. OHPRLB (20)/CLS (7)/9000L/UI/9000L.dart';
import 'industrial/10. OHPRLB (20)/CLS (7)/OP4A/UI/OP4A.dart';
import 'industrial/10. OHPRLB (20)/CLS (7)/OP52/UI/OP52.dart';
import 'industrial/10. OHPRLB (20)/CMS (4)/PMMS/UI/PMMS.dart';
import 'industrial/10. OHPRLB (20)/CMS (4)/SLMLMS/UI/SLMLMS.dart';

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
  // 3. ETIPO (6)
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
  'OP-48E': const Product(
    title: 'OP-48E',
    imagePath:
        'assets/industrial/Enclosed Track Inverted Power Only and P&F (8)/Conveyor Lub. Systems (3)/OP-48E.png',
    callback: OP48EPage(),
  ),
  // 4. ETOPO (6)
  '2100L Series Self-Contained Conveyor Lubricators': const Product(
    title: '2100L Series Self-Contained Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Overhead Power Only and P&F (10)/Conveyor Lub. Systems (4)/2100L.png',
    callback: Page2100L(),
  ),
  '9000L Series Enclosed Track Conveyor Lubricators': const Product(
    title: '9000L Series Enclosed Track Conveyor Lubricators',
    imagePath:
        'assets/industrial/Enclosed Track Overhead Power Only and P&F (10)/Conveyor Lub. Systems (4)/9000L.png',
    callback: Page9000L(),
  ),
  'Portable (Multi-Line) Mighty Lube Monitoring System': const Product(
    title: 'Portable (Multi-Line) Mighty Lube Monitoring System',
    imagePath:
        'assets/industrial/Enclosed Track Overhead Power Only and P&F (10)/Conveyor Monitor Systems (2)/Portable Multi Line.png',
    callback: PMLMSPage(),
  ),
  // 5. FT(4)
  'OPCO 300 Series Automatic Sealed Wheel Lubricator': const Product(
    title: 'OPCO 300 Series Automatic Sealed Wheel Lubricator',
    imagePath:
        'assets/industrial/Flat Top (4)/Conveyor Greaser Systems (1)/OPCP 300.png',
    callback: OPCP300Page(),
  ),
  'Mighty Lube Flat Top Lubricator': const Product(
    title: 'Mighty Lube Flat Top Lubricator',
    imagePath:
        'assets/industrial/Chain On Edge Drag Line (3)/Conveyor Lub. Systems/MLCEL.png',
    callback: MLCELPage(),
  ),
  // 6. FC(2)
  'Free Rail 314 “Load” wheel Greaser': const Product(
    title: 'Free Rail 314 “Load” wheel Greaser',
    imagePath: 'assets/industrial/Free Carrier (2)/FR314.png',
    callback: FR314Page(),
  ),
  'Free Rail 317 “Guide” wheel Greaser': const Product(
    title: 'Free Rail 317 “Guide” wheel Greaser',
    imagePath: 'assets/industrial/Free Carrier (2)/FR317.png',
    callback: FR317Page(),
  ),
  // 7. FROOI (6)
  '9000L Series Central System Free Carrier Conveyor Lubricators':
      const Product(
    title: '9000L Series Central System Free Carrier Conveyor Lubricators',
    imagePath: 'assets/industrial/IBRC(3)/CGS.png',
    callback: Page9000L(),
  ),
  'E-Series': const Product(
    title: 'E-Series',
    imagePath: 'assets/industrial/IBRC(3)/CGS.png',
    callback: ESPage(),
  ),
  'OP-139A': const Product(
    title: 'OP-139A',
    imagePath: 'assets/industrial/IBRC(3)/CGS.png',
    callback: OP139APage(),
  ),
  // 8. IFTL (2)
  'Mighty Lube In Floor Tow Line': const Product(
    title: 'Mighty Lube In Floor Tow Line',
    imagePath: 'assets/industrial/Title.png',
    callback: MLIFTLPage(),
  ),
  // 9. IBRC (3)
  'Mighty Lube Roller Flight Conveyor': const Product(
    title: 'Mighty Lube Roller Flight Conveyor',
    imagePath: 'assets/industrial/IBRC(3)/MLRFC.png',
    callback: MLRFCPage(),
  ),
  // 10. OHPRLB (20)
  'Overhead Non-Powered Mighty Lube Brush Cleaners 300I 400I 600I':
      const Product(
    title: 'Overhead Non-Powered Mighty Lube Brush Cleaners 300I 400I 600I',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/300I.png',
    callback: Page300I(),
  ),
  'I-Beam Conveyor Beam Sweep': const Product(
    title: 'I-Beam Conveyor Beam Sweep',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/LBCBS.png',
    callback: LBCBSPage(),
  ),
  'Overspray Eliminator Brush': const Product(
    title: 'Overspray Eliminator Brush',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/OEB.png',
    callback: OEBPage(),
  ),
  'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner':
      const Product(
    title:
        'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/OP8.png',
    callback: OP8Page(),
  ),
  'OP-8NP Non-Power Brush Cleaning System I-Beam Conveyor Chain Cleaner':
      const Product(
    title:
        'OP-8NP Non-Power Brush Cleaning System I-Beam Conveyor Chain Cleaner',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/OP8NP.png',
    callback: OP8NPPage(),
  ),
  'OP-13 Sanitary Hook Cleaner': const Product(
    title: 'OP-13 Sanitary Hook Cleaner',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/OP13.png',
    callback: OP13Page(),
  ),
  'OP-55': const Product(
    title: 'OP-55',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/OP55.png',
    callback: OP55Page(),
  ),
  'Yoke Cleaning Brush': const Product(
    title: 'Yoke Cleaning Brush',
    imagePath: 'assets/industrial/OHPRLB(20)/CCS/YCB.png',
    callback: YCBPage(),
  ),
  'Greaser Power Chain': const Product(
    title: 'Greaser Power Chain',
    imagePath: 'assets/industrial/OHPRLB(20)/CGS/CGS.png',
    callback: GCPPage(),
  ),
  '2100L Series Self-Contained I-Beam Conveyor Lubricators': const Product(
    title: '2100L Series Self-Contained I-Beam Conveyor Lubricators',
    imagePath: 'assets/industrial/OHPRLB(20)/CLS/2100L.png',
    callback: Page2100LBeam(),
  ),
  '9000L Series Central System I-Beam Conveyor Lubricators': const Product(
    title: '9000L Series Central System I-Beam Conveyor Lubricators',
    imagePath: 'assets/industrial/OHPRLB(20)/CLS/9000L.png',
    callback: Page9000LBeam(),
  ),
  'OP-4A': const Product(
    title: 'OP-4A',
    imagePath: 'assets/industrial/OHPRLB(20)/CLS/OP4A.png',
    callback: OP4APage(),
  ),
  'OP-52/OP-53': const Product(
    title: 'OP-52/OP-53',
    imagePath: 'assets/industrial/OHPRLB(20)/CLS/OP52.png',
    callback: OP52Page(),
  ),
  'Paint Marker for Monitoring System (Optional)': const Product(
    title: 'Paint Marker for Monitoring System (Optional)',
    imagePath: 'assets/industrial/PFOOI(17)/CMS/PMMS.png',
    callback: PMMSPage(),
  ),
  'Single Line (Stationary) Mighty Lube® Monitoring System': const Product(
    title: 'Single Line (Stationary) Mighty Lube® Monitoring System',
    imagePath: 'assets/industrial/PFOOI(17)/CMS/SLMLMS.png',
    callback: SLMLMSPage(),
  ),
  

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

final Map<String, String> imageList = {
  // protein
  'FGCO': 'assets/FGCO.png',
  'FGLM': 'assets/FGLM.png',
};
