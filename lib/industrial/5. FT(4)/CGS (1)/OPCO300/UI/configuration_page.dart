import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/5.%20FT(4)/CGS%20(1)/products.dart';
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
  final TextEditingController compressedAir = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController lubricationType = TextEditingController();
  final TextEditingController lubricationGrade = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();

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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Name of Conveyor System',conveyorSystem),
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
          'mm Millimeter',
        ]),
        CommonWidgets.buildTextField('Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute',  
          'Meter/Minute',
        ]),
        CommonWidgets.buildTextField('Indexing or Variable Speed Conditions',conveyorIndex),
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left',  
          'Left to Right',
        ]),
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',  
          'Caustic (i.e. Phosphate/E-Coat, etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic',
          'Food Grade',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',  
          'No',
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Unloaded',  
          'Loaded',
        ]),
        CommonWidgets.buildDropdownField('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?', [
          'Yes',  
          'No',
        ]),
        CommonWidgets.buildDropdownField('Is Conveyor Single or Double Strand?', [
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
        CommonWidgets.buildTextField('Enter Operating Voltage - Single Phase: (Volts/hz)',operatingVoltage),
        CommonWidgets.buildTextField('Enter Compressed Air Supply',compressedAir),
        CommonWidgets.buildDropdownField('Compressed Air Supply Unit', [
          'PSI',
          'KPI',
          'BAR',
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() { //leave alone for template B
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
        CommonWidgets.buildDropdownField('Roller Chains', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Bushings', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Outboard Wheels', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Current Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubrication Type',lubricationType),
        CommonWidgets.buildTextField('Enter Current Lubrication Viscosity/Grade',lubricationGrade),
        CommonWidgets.buildDropdownField('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Current Grease Type',greaseType),
        CommonWidgets.buildTextField('Enter Current Grease NLGI Grade',greaseGrade),
        CommonWidgets.buildDropdownField('Zerk Ftg Location [Left or Right: Facing Direction of Travel)', [
          'Left',
          'Right'
        ]),
        CommonWidgets.buildDropdownField('Zerk Ftg Location (Orientation)', [
          'Center',
          '12 O"Clock',
          '3 O"Clock',
          '6 O"Clock',
          '9 O"Clock'
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
        CommonWidgets.buildDropdownField('Controls Other Units (list)', [
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
        CommonWidgets.buildTextField('Other Information',otherInfo),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() { //leave alone for now - Coming back to do later
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
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}
