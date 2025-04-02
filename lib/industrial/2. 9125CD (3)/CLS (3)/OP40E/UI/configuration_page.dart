import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/industrial/2.%209125CD%20(3)/CLS%20(3)/products.dart';

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

  final TextEditingController aTop = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController jWidth = TextEditingController();
  final TextEditingController xWidth = TextEditingController();
  final TextEditingController yThickness = TextEditingController();
  final TextEditingController zInside = TextEditingController();

  //currentGrade

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const ProductsCOEDL()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Chain on Edge Drag Line: Measurements',buildMeasurements()),
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
          'CC5 3”',
          'CC5 4”',
          'CC5 6”',
          'RC60', 'RC80', 'RC 2080', 'RC 2060',
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

  Widget buildNewMonitoringSystem() {
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

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownField('Outboard Wheels', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('High Rollers', [
          'Yes',
          'No'
        ]),
        
        CommonWidgets.buildTextField('Enter Rail Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade',currentGrade),
        CommonWidgets.buildDropdownField('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Lubrication from the Top of Chain', [
          'Yes',
          'No'
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
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
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
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Chain Drop (A)",
        hintText: "Top of Rail to Center of Chain",
        imagePath: 'assets/Measurements/2/A.png',
        controller: aTop,
        subHint: "(Top of Rail to Center of Chain)",
      ),
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Power Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/2/G.png',
        controller: gWidth,
        subHint: "(Width)",
      ),
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Power Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/2/H.png',
        controller: hHeight,
        subHint: "(Height)",
      ),
      // Image J
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Rail Offset (J)",
        hintText: "Inside of Rail Channel to Inside of Rail Channel",
        imagePath: 'assets/Measurements/2/J.png',
        controller: jWidth,
        subHint: "(Inside of Rail Channel to Inside of Rail Channel)",
      ),
      // Image X
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drain Line Wear Bar (X)",
        hintText: "Width",
        imagePath: 'assets/Measurements/2/X.png',
        controller: xWidth,
        subHint: "(Width)",
      ),
      // Image Y
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Wear Bar (Y)",
        hintText: "Thickness",
        imagePath: 'assets/Measurements/2/Y.png',
        controller:yThickness,
        subHint: "(Thickness)",
        ),
      // Image Z
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain on Edge Drag Line Wear Bar Offset (Z)",
        hintText: "Inside Edge of Rail to Inside Edge fo Wear Bar",
        imagePath: 'assets/Measurements/2/Z_OP40E.png',
        controller: zInside,
        subHint: "(Inside Edge of Rail to Inside Edge fo Wear Bar)",
        ),
      
    ],
  );
}

}
