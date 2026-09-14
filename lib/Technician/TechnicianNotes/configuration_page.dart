// import 'package:flutter/material.dart';
// import 'package:mighty_lube/Technician/TechnicianNotes/TechnicianNote.dart';
// import 'package:mighty_lube/application/UI/applicationHome.dart';
// import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/CCS%20(8)/products.dart';
// import 'package:mighty_lube/core/widget/helper_widgets.dart';
//
//
// class ConfigurationSection extends StatefulWidget {
//   const ConfigurationSection({super.key});
//
//   @override
//   State<ConfigurationSection> createState() => _ConfigurationSectionState();
// }
//
// class _ConfigurationSectionState extends State<ConfigurationSection> {
//   int itemCount = 1; // Default count
//   final TextEditingController techniciannote = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Technician',const TechnicianNote()),
//         Expanded(
//           child: ListView(
//             padding: const EdgeInsets.all(20.0),
//             children: [
//               CommonWidgets.buildGradientButton(context, 'Technician Note', buildTechnicianNoteContent()),
//             ],
//           ),
//         ),
//
//         CommonWidgets.buildConfiguratorWithCounter(),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//
//
//   Widget buildTechnicianNoteContent() {
//     return ValueListenableBuilder<TextEditingValue>(
//         valueListenable: techniciannote,
//         builder: (context, value, child) {
//           // validate.validatorDelay(value.text, 'operatingVoltage');
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonWidgets.buildSectionDivider(),
//               CommonWidgets.buildTextField('Technician note*', techniciannote, errorText: "", linenum: 5),
//               CommonWidgets.buildSectionDivider(),
//             ],
//           );
//         });
//   }
//
//
// }