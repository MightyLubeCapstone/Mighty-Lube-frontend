import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/CGS%20(1)/products.dart';
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
  final TextEditingController systemName = TextEditingController();
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController compAir = TextEditingController();
  
  final TextEditingController aTop = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController cOutside = TextEditingController();
  final TextEditingController dInside = TextEditingController();
  final TextEditingController eBottom = TextEditingController();
  final TextEditingController fOutside = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController sCenter = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CGSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Greaser - Power Chain: Measurements',buildMeasurements()),
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
        CommonWidgets.buildDropdownField('Wheel Manufacturer', [
          'Green Line',
          'Frost',
          'M&M',
          'Stork',
          'Meyn',
          'Linco',
          'DC',
          'Merel',
          'D&F'
          'Other'
        ]),
        
        
        CommonWidgets.buildTextField('Enter Conveyor Length', conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Milimeter'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet /minute',
          'Meters /minute'
        ]),
        CommonWidgets.buildTextField('Enter Indexing or Variable Speed Conditions',conveyorIndex),
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left',
          'Left to Right'
        ]),
        
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phosphate/ E-Coat, etc.)',
          'Oven',
          'Wash Down', 'Intrinsic','Food Grade', 'Other'
        ]),
        CommonWidgets.buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System is below 30F or above 120F', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Loaded',
          'Unloaded'
        ]),
        CommonWidgets.buildDropdownField('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side', [
          'Yes',
          'No'
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
        CommonWidgets.buildTextField('Enter Operating Voltage - Single Phase: (Volts/hz]',operatingVoltage),
        CommonWidgets.buildTextField('Enter Control Voltage (Volts/hz)',controlVoltage),
        CommonWidgets.buildTextField('Enter Compressed Air Supply',compAir),
        CommonWidgets.buildDropdownField('Compressed Air Supply Unit', [
          'PSI',
          'KPI','Bar'
        ]),
        CommonWidgets.buildSectionDivider(),
        
      ],
    );
  }

  Widget buildNewMonitoringSystem() { //will have to come back and add a template - maybe b
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Add New Monitoring System', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildSectionDivider(),
        
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildTextField('Enter Current Grease Type',greaseType),
        CommonWidgets.buildTextField('Current Grease NLGI Grade',greaseGrade),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
  
  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('ChainMaster Controller', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Remote', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Mounted on Greaser', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Controls other units (list):', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Timer', [
          'Not Required',
          '12 Hour', '1000 Hour'
        ]),
        CommonWidgets.buildDropdownField('Electric On/Off', [
          'On',
          'Off'
        ]),
        CommonWidgets.buildDropdownField('Pneumatic On/Off', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Pre-Mounting Requirements', [
          'OPCO Track',
          'Customer Provided Track', 'Other'
        ]),
        CommonWidgets.buildTextField('Enter Other Details',optionalInfo),
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
        title: "Greaser - Power Chain Chain Drop (A)",
        hintText: "Top of Rail to Center of Chain",
        imagePath: 'assets/Measurements/10/CGS/GPC/A.png', 
        controller: aTop,
        subHint: "(Top of Rail to Center of Chain)",
      ),
        
        // Image B
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/10/CGS/GPC/B.png', 
        controller: bDiameter,
        subHint: "(Diameter)",
      ),

        // Image C
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Trolley Wheel Bracket Width @ Trolley Wheel (C)",
        hintText: "Outside of Left Bracket to Outside of Right Bracket",
        imagePath: 'assets/Measurements/10/CGS/GPC/C.png', 
        controller: cOutside,
        subHint: "(Outside of Left Bracket to Outside of Right Bracket)",
      ),

        // Image D
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Trolley Wheel Spacer (D)",
        hintText: "Inside of Left Wheel to Inside of Right Wheel",
        imagePath: 'assets/Measurements/10/CGS/GPC/D.png', 
        controller: dInside,
        subHint: "(Inside of Left Wheel to Inside of Right Whee)",
      ),

        // Image E
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Zerk Fitting Vertical Location (E)",
        hintText: "Bottom of Rail to Center of Zerk Fitting",
        imagePath: 'assets/Measurements/10/CGS/GPC/E.png', 
        controller: eBottom,
        subHint: "(Bottom of Rail to Center of Zerk Fitting)",
      ),

        // Image F
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Zerk Fitting Horizontal Location (F)",
        hintText: "Outside of Left Zerk ftg. to Outside of Right Zerk ftg.",
        imagePath: 'assets/Measurements/10/CGS/GPC/F.png', 
        controller: fOutside,
        subHint: "(Outside of Left Zerk ftg. to Outside of Right Zerk ftg)",
      ),
        
        // Image G
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/10/CGS/GPC/G.png', 
        controller: gWidth,
        subHint: "(Greaser - Power Chain Rail (G))",
      ),

        // Image H
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/10/CGS/GPC/H.png', 
        controller: hHeight,
        subHint: "(Height)",
      ),

        // Image S
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Greaser - Power Chain Trolley Pitch (Minimum - For variable pitch chain,Provide the Minimum Pitch Dimension) (S)",
        hintText: "Center of Power Wheel to Center of Power Wheel",
        imagePath: 'assets/Measurements/10/CGS/GPC/S.png', 
        controller: sCenter,
        subHint: "(Center of Power Wheel to Center of Power Wheel)",
      ),

        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}