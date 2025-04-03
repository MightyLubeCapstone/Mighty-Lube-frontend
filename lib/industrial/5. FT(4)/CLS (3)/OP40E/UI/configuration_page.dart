import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/5.%20FT(4)/CLS%20(3)/products.dart';
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
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();

  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController a1Diameter = TextEditingController();
  final TextEditingController b1Width = TextEditingController();
  final TextEditingController h1Width = TextEditingController();
  final TextEditingController j1Thickness = TextEditingController();
  final TextEditingController l1Flat = TextEditingController();
  final TextEditingController m1Inside = TextEditingController();
  final TextEditingController n1Width = TextEditingController();
  final TextEditingController p1Outside = TextEditingController();
  final TextEditingController r1Center = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CLSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Flat Top: Measurements',buildMeasurements()),
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
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3")',
          'X458 Chain (4")',
          'X678 Chain (6")',
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
          'Webb-Stiles',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter',
        ]),
        CommonWidgets.buildTextField('Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute',
          'Meters/Minute',
        ]),
        CommonWidgets.buildTextField('Indexing or Variable Speed Conditions',conveyorIndex),
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ]),
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phospate/E-Coat, etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic','Food Grade', 'Other'
        ]),
        CommonWidgets.buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No',
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Loaded',
          'Unloaded',
        ]),
        CommonWidgets.buildDropdownField('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side', [
          'Yes',
          'No',
        ]),
        CommonWidgets.buildDropdownField('Is Conveyor Single or Double Strand', [
          'Single',
          'Double',
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
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {// come back adn add template B here
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() { // will need to come back and add template C
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownField('Wheel: Open Race Style', [
          'Not Applicable',
          'Open Inside',
          'Open Outside'
        ]),
        CommonWidgets.buildDropdownField('Wheel: Sealed Style', [
          'Extended',
          'Flush',
          'Recessed'
        ]),
        CommonWidgets.buildDropdownField('Open Inside / Shielded Outside', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Free Trolley Wheels', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Guide Rollers', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Guide Rollers Open Race Style', [
          'Not Applicable',
          'Open Inside',
          'Open Outside'
        ]),
        CommonWidgets.buildDropdownField('Guide Rollers Sealed Style', [
          'Extended',
          'Flush',
          'Recessed'
        ]),
        CommonWidgets.buildDropdownField('Open Hole', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Dog Actuator', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Pivot Points', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('King Pin', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Outboard Wheels', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Rail Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade',currentGrade),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
  
  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('ChainMaster Contoller', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Timer', [
          'Not Required',
          '12 Hour', 
          '1000 Hour'
        ]),
        CommonWidgets.buildDropdownField('Electric On/Off', [
          'On',
          'Off'
        ]),
        CommonWidgets.buildDropdownField('Pneumatic On/Off', [
          'On',
          'Off'
        ]),
        CommonWidgets.buildDropdownField('PLC Connection', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Other Information',otherInfo),
        CommonWidgets.buildTextField('Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify) ',specialOptions),
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
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Power Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/5/CGS/G.png',
        controller: gWidth,
        subHint: "(Height)",
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Power Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/5/CGS/H.png',
        controller: hHeight,
        subHint: "(Height)",
      ),
      
      // Image A1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Roller Wheel (A1)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/5/CGS/A1.png',
        controller: a1Diameter,
        subHint: "(Diameter)",
      ),
      
      // Image B1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Roller Wheel (B1)",
        hintText: "Width",
        imagePath: 'assets/Measurements/5/CGS/B1.png',
        controller: b1Width,
        subHint: "(Width)",
      ),
      
      // Image H1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Roller Sleeve (H1)",
        hintText: "Width",
        imagePath: 'assets/Measurements/5/CGS/H1.png',
        controller: h1Width,
        subHint: "(Width)",
        ),
      
      // Image J1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Rail (J1)",
        hintText: "Thickness",
        imagePath: 'assets/Measurements/5/CGS/J1.png',
        controller: j1Thickness,
        subHint: "(Thickness)",
      ),
      
      // Image L1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Double Chain Pitch (L1)",
        hintText: "Center of Chain to Center of Chain",
        imagePath: 'assets/Measurements/5/CGS/L1.png',
        controller: l1Flat,
        subHint: "(Center of Chain to Center of Chain)",
      ),

      // Image M1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Roller Wheel Pitch (M1)",
        hintText: "Inside of Left Roller of Inside of Right Roller",
        imagePath: 'assets/Measurements/5/CGS/M1.png',
        controller: m1Inside,
        subHint: "(Inside of Left Roller of Inside of Right Roller)",
      ),

      // Image N1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Mounting Plate (N1)",
        hintText: "Width",
        imagePath: 'assets/Measurements/5/CGS/N1.png',
        controller: n1Width,
        subHint: "(Width)",
      ),

      // Image P1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Rail Pitch (P1)",
        hintText: "Outside of Left Rail to Outside fo Right Rail",
        imagePath: 'assets/Measurements/5/CGS/P1.png',
        controller: p1Outside,
        subHint: "(Outside of Left Rail to Outside fo Right Rail)",
      ),
      
      // Image R1
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Flat Top Double Strand Pitch (R1)",
        hintText: "Center of Strand to Center of Strand",
        imagePath: 'assets/Measurements/5/CGS/R1.png',
        controller: r1Center,
        subHint: "(Center of Strand to Center of Strand)",
      ),
    ],
  );
}

}
