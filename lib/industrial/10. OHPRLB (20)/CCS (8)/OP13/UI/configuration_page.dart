import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/CCS%20(8)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController systemName = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController controlVoltage = TextEditingController();

  final TextEditingController aTop = TextEditingController();
  final TextEditingController cOutside = TextEditingController();
  final TextEditingController a2Center = TextEditingController();
  final TextEditingController b2Height = TextEditingController();
  final TextEditingController c2Outside = TextEditingController();

  final TextEditingController d2Center = TextEditingController();
  final TextEditingController e2Thickness = TextEditingController();
  final TextEditingController f2Diameter = TextEditingController();
  final TextEditingController g2Width = TextEditingController();
  final TextEditingController h2Height = TextEditingController();
  final TextEditingController j2Hook = TextEditingController();
  final TextEditingController l2Width = TextEditingController();
  final TextEditingController m2Height = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilites',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'Overhead Power Rail: Measurements',buildMeasurements()),
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Enter Name of Conveyor System Here',systemName),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          '3/8" Log Chain',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Chain Manufacturer', [
          'Daifuku',
          'Frost',
          'NKC',
          'Pacline',
          'Rapid',
          'WEBB',
          'Webb-Stilies',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phosphate/ E-Coat, etc.)',
          'Oven',
          'Wash Down', 'Intrinsic','Food Grade', 'Other'
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Loaded',
          'Unloaded'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Operating Voltage - 3 Phase: (Volts/hz)',operatingVoltage),
        CommonWidgets.buildTextField('Enter Control Voltage (Volts/hz)',controlVoltage),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        
        // Image A
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Chain Drop (A)",
        hintText: "Top of Rail to Center of Chain",
        imagePath: 'assets/Measurements/10/CCS/OP13/A.png', 
        controller: aTop,
        subHint: "(Top of Rail to Center of Chain)",
      ),
        
        // Image C
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Trolley Wheel Bracket Width @ Trolley Wheel (C)",
        hintText: "Outside of Left Bracket to Outside of Right Bracket",
        imagePath: 'assets/Measurements/10/CCS/OP13/C.png', 
        controller: cOutside,
        subHint: "(Outside of Left Bracket to Outside of Right Bracket)",
      ),

        // Image A2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary C-Hook Drop (A2)",
        hintText: "Center of Chain to Top of C-Hook",
        imagePath: 'assets/Measurements/10/CCS/OP13/A2.png', 
        controller: a2Center,
        subHint: "(Center of Chain to Top of C-Hook)",
      ),

        // Image B2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary C-Hook (B2)",
        hintText: "Height",
        imagePath: 'assets/Measurements/10/CCS/OP13/B2.png', 
        controller: b2Height,
        subHint: "(Height)",
      ),

        // Image C2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Trolley Wheel Bracket Max. Width (C2)",
        hintText: "Outside of Left Bracket to Outside of Right Bracket)",
        imagePath: 'assets/Measurements/10/CCS/OP13/C2.png', 
        controller: c2Outside,
        subHint: "(Outside of Left Bracket to Outside of Right Bracket))",
      ),

        // Image D2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary C-Hook Offset (D2)",
        hintText: "Center of Conveyor to Outside Edge of C-Hook",
        imagePath: 'assets/Measurements/10/CCS/OP13/D2.png', 
        controller: d2Center,
        subHint: "(Center of Conveyor to Outside Edge of C-Hook)",
      ),
        
        // Image E2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary C-Hook Drop (E2)",
        hintText: "Thickness",
        imagePath: 'assets/Measurements/10/CCS/OP13/C.png', 
        controller: e2Thickness,
        subHint: "(Thickness)",
      ),

        // Image F2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary C-Hook Support Pin (F2)",
        hintText: "Diameter / Thickness",
        imagePath: 'assets/Measurements/10/CCS/OP13/F2.png', 
        controller: f2Diameter,
        subHint: "(Diameter / Thickness)",
      ),

        // Image G2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Carrier Support Bracket (G2)",
        hintText: "Width",
        imagePath: 'assets/Measurements/10/CCS/OP13/G2.png', 
        controller: g2Width,
        subHint: "(Width)",
      ),

        // Image H2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Carrier Support Bracket (H2)",
        hintText: "Height",
        imagePath: 'assets/Measurements/10/CCS/OP13/H2.png', 
        controller: h2Height,
        subHint: "(Height)",
      ),

        // Image J2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Carrier Support Bracket (J2)",
        hintText: "C-Hook to Bottom of Carrier Support Bracket",
        imagePath: 'assets/Measurements/10/CCS/OP13/J2.png', 
        controller: j2Hook,
        subHint: "(C-Hook to Bottom of Carrier Support Bracket))",
      ),
        
        // Image L2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Free Rail (L2)",
        hintText: "Width",
        imagePath: 'assets/Measurements/10/CCS/OP13/L2.png', 
        controller: l2Width,
        subHint: "(Width)",
      ),

        // Image M2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Sanitary Free Rail (M2)",
        hintText: "Height",
        imagePath: 'assets/Measurements/10/CCS/OP13/M2.png', 
        controller: m2Height,
        subHint: "(Height)",
      ),

        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}