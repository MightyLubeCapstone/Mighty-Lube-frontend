import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(17)/CGS%20(3)/products.dart';
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
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController compAir = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();

  final TextEditingController aCenter = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController eBottom = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController sCenter = TextEditingController();


  

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
              CommonWidgets.buildGradientButton(context, 'Inverted P&F: Measurements',buildMeasurements()),
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
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField('Enter Name of Conveyor System',conveyorSystem),
        CommonWidgets.buildDropdownField('Wheel Manufacturer', [
          'Green Line',
          'Frost',
          'M&M',
          'Stork',
          'Meyn',
          'Linco',
          'DC',
          'Merel',
          'D&F',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter '
        ]),
        
        CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute',
          'Meters/Minute',
        ]),
       
        CommonWidgets.buildTextField('Enter Indexing or Variable Speed Conditions',conveyorIndex),
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ]),
        
        CommonWidgets.buildDropdownField('Application Environment ', [
          'Ambient',
          'Caustic (i.e. Phosphate/E-Coast, etc.)',
          'Oven',
          'Wash Down', 'Intrinsic', 'Food Grade', 'Other'
        ]),
        CommonWidgets.buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No',
        ]),
        CommonWidgets.buildDropdownField('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side ', [
          'Yes',
          'No'
        ]),
        
        CommonWidgets.buildDropdownField('Is the Conveyor Overhead, Inverted, or Inverted/Inverted? ', [
          'Overhead',
          'Inverted',
          'Inverted/Inverted'
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
        CommonWidgets.buildTextField('Control Voltage (Volts/hz)',controlVoltage),
        CommonWidgets.buildTextField('Compressed Air Supply',compAir),
        CommonWidgets.buildDropdownField('Compresses Air Supply Unit', [
          'PSI',
          'KPI','Bar'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() { // will probably need template B
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
          'Open Inside', 'Open Outside'
        ]),
        CommonWidgets.buildDropdownField('Guide Rollers Sealed Style', [
          'Extended',
          'Flush', 'Recessed'
        ]),
        CommonWidgets.buildDropdownField('Open Hole', [
          'Yes',
          'No'
        ]),

        CommonWidgets.buildTextField('Enter Current Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade',currentGrade),

        CommonWidgets.buildTextField('Enter Current Grease Type',greaseType),
        CommonWidgets.buildTextField('Enter Current Grease NLGI Grade',greaseGrade),
        CommonWidgets.buildDropdownField('Zerk Ftg Location [Left or Right: Facing Direction of Travel)', [
          'Left',
          'Right'
        ]),
        CommonWidgets.buildDropdownField('Zerk Ftg Location (Orientation)', [
          'Center',
          '12 O-Clock',
          '3 O-Clock',
          '6 O-Clock',
          '9 O-Clock'

        ]),
        

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
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Electric On/Off', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Pre-Mounting Requirements', [
          'OPCO Track',
          'Customer Provided Track',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('PLC Connection', [
          'Yes',
          'No'
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
      CommonWidgets.buildDropdownField('Measurement Unit', [
          'Feet',
          'Inches', 'm Meter', 'mm Millimeter '
        ]),
      
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Chain Drop (A)",
        hintText: "Center of Chain to Opposite Edge of Rail",
        imagePath: 'assets/Measurements/11/CGS/317/A.png',
        controller: aCenter,
        subHint: "(Center OF Free Trolley Wheel to Zerk Fitting)",
      ),

      // Image B
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/11/CGS/317/B.png',
        controller: bDiameter,
        subHint: "(Diameter)",
      ),
      
      // Image E
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Zerk Fitting Vertical Location (E)",
        hintText: "Bottom of Rail to Zerk Fitting)",
        imagePath: 'assets/Measurements/11/CGS/317/E.png',
        controller: eBottom,
        subHint: "(Bottom of Rail to Zerk Fitting))",
      ),
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/11/CGS/317/G.png',
        controller: gWidth,
        subHint: "(Width)",
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/11/CGS/317/H.png',
        controller: hHeight,
        subHint: "(Height)",
      ),
      
      // Image S
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)",
        hintText: "Center of Power Wheel to Center of Power Wheel",
        imagePath: 'assets/Measurements/11/CGS/317/S.png',
        controller: sCenter,
        subHint: "(Center of Power Wheel to Center of Power Wheel)",
      ),
      

    ],
  );
}
}
