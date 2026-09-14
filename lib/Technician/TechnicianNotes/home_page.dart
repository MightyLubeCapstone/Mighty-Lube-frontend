// import 'package:flutter/material.dart';
// import 'package:mighty_lube/Technician/Technician_home.dart';
// import 'package:mighty_lube/application/UI/applicationHome.dart';
// import 'package:mighty_lube/core/widget/helper_widgets.dart';
//
// import '../../industrial/10. OHPRLB (20)/CCS (8)/products.dart';
//
//
// class HomeSection extends StatelessWidget {
//   const HomeSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Technician',const TechnicianHome()),
//         const Padding(
//           padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 20.0), // Adjusted top padding
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Technician Notes',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 25), // Space between the title and description
//               Text(
//                 'Please enter any relevant technical notes into the configurator to ensure the accuracy and specificity of your configuration.'
//                     'This information is crucial for tailoring the system to meet your exact needs and requirements.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
