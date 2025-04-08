import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/CCS%20(1)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();

  final TextEditingController aTop = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController lCenter = TextEditingController();
  final TextEditingController aCenter = TextEditingController();
  final TextEditingController bDiameter2 = TextEditingController();
  final TextEditingController gWidth2 = TextEditingController();
  final TextEditingController hHeight2 = TextEditingController();
  final TextEditingController kCenter = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CCSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Free Rail: Measurements',buildMeasurements()),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(),
        const SizedBox(height: 20),
      ],
    );
  }

//actual buttons w/ the questions :) 

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField('Enter Name of Conveyor System',conveyorSystem),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Chain Manufacturer', [
          'Daifuku',
          'Frost',
          'NKC',
          'Pacline',
          'Rapid',
          'WEBB',
          'Webb-Stiles',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter'
        ]),
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phosphate / E-Coat, etc.)',
          'Oven',
          'Wash Down', 'Intrinsic','Food Grade',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildSectionDivider(),
        ],
    );
  }
  
  Widget buildMeasurements() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonWidgets.buildDropdownField('Measurement Unit', [
          'Feet',
          'Inches', 'm Meter', 'mm Millimeter '
        ]),
      
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Chain Drop (A)",
        hintText: "Top of Rail to Center of Chain",
        imagePath: 'assets/Measurements/7/CCS/A.png',
        controller: aTop,
        subHint: "(Top of Rail to Center of Chain)",
      ),

      // Image B
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/7/CCS/B.png',
        controller: bDiameter,
        subHint: "Diameter",
      ),
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/7/CCS/G.png',
        controller: gWidth,
        subHint: "(Width)",
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/7/CCS/H.png',
        controller: hHeight,
        subHint: "(Height)",
      ),
      
      // Image L
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Free Trolley Wheel Position (Vertical - L)",
        hintText: "Center of Free Trolley Wheel to Bottom of Rail",
        imagePath: 'assets/Measurements/7/CCS/L.png',
        controller: lCenter,
        subHint: "(Center of Free Tolley Wheel to Bottom of Rail)",
      ),
      
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Chain Drop (A)",
        hintText: "Center of Chain to Opposite Edge of Rail",
        imagePath: 'assets/Measurements/7/CCS/A_Color.png',
        controller: aCenter,
        subHint: "(Center of Chain to Opposite Edge of Rail)",
      ),
      
      // Image B2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/7/CCS/B2.png',
        controller: bDiameter2,
        subHint: "(Diameter)",
      ),
      
      // Image G2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/7/CCS/G2.png',
        controller: gWidth2,
        subHint: "(Width)",
      ),
      
      // Image H2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/7/CCS/H2.png',
        controller: hHeight2,
        subHint: "(Height)",
      ),
      
      // Image K
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Trolley Wheel Pitch (K)",
        hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
        imagePath: 'assets/Measurements/7/CCS/K.png',
        controller: kCenter,
        subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
      ),
      
    ],
  );
}

}
