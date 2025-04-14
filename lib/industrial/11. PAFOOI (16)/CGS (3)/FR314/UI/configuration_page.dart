import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/6.%20FC%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();
  final TextEditingController compAir = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController kCenter = TextEditingController();
  final TextEditingController tLead = TextEditingController();
  final TextEditingController uLoad = TextEditingController();
  final TextEditingController vLoad = TextEditingController();
  final TextEditingController wOutside = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController eBottom = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const FCProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Greaser Free Carrier: Measurements',buildMeasurements()),
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
        CommonWidgets.buildTextField('Enter Operating Voltage - 3 Phase: (Volts/hz)',operatingVoltage),
        CommonWidgets.buildTextField('Control Voltage (Volts/hz) ',controlVoltage),
        CommonWidgets.buildTextField('Enter Compressed Air Supply',compAir),
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
          'On',
          'Off'
        ]),
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Pre-Mounting Requirements', [
          'OPCO Track',
          'Customer Provided Track', 'Other'
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
      
      // Image B
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/11/CGS/314/B.png',
        controller: bDiameter,
        subHint: "(Diameter)",
      ),
      
      // Image E
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power adn Free Zerk Fitting Vertical Location (E)",
        hintText: "Bottom of Rail to Zerk Fitting",
        imagePath: 'assets/Measurements/11/CGS/314/E.png',
        controller: eBottom,
        subHint: "(Bottom of Rail to Zerk Fitting)",
      ),
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/11/CGS/314/G.png',
        controller: gWidth,
        subHint: "(Width)",
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/11/CGS/314/H.png',
        controller: hHeight,
        subHint: "(Height)",
      ),
      
      // Image K
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Trolley Wheel Pitch (K)",
        hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
        imagePath: 'assets/Measurements/11/CGS/314/K.png',
        controller: kCenter,
        subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
      ),
      
      // Image T
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail Carrier Trolley Pitch (T)",
        hintText: "Lead to Load",
        imagePath: 'assets/Measurements/11/CGS/314/T.png',
        controller: tLead,
        subHint: "(Lead to Load)",
        ),
      
      // Image U
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail Carrier Trolley Pitch (U)",
        hintText: "Load to Load",
        imagePath: 'assets/Measurements/11/CGS/314/U.png',
        controller: uLoad,
        subHint: "(Load to Load)",
      ),
      
      // Image V
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail Carrier Trolley Pitch (V)",
        hintText: "Load to Trailing",
        imagePath: 'assets/Measurements/11/CGS/314/V.png',
        controller: vLoad,
        subHint: "(Load to Trailing)",
      ),
    
      // Image W
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power adn Free Trolley Wheel Offset (W)",
        hintText: "Outside to Outside of Free Trolley Wheels",
        imagePath: 'assets/Measurements/11/CGS/314/W.png',
        controller: wOutside,
        subHint: "(Outside to Outside of Free Trolley Wheels)",
      ),
    
    ],
  );
}

}

