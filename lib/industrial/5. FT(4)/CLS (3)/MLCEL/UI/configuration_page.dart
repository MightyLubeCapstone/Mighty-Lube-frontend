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
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController jBox = TextEditingController();
  final TextEditingController conductor12 = TextEditingController();
  final TextEditingController resSize = TextEditingController();
  final TextEditingController optionInfo = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire()),
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Name of Conveyor System',conveyorSystem),
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

  Widget buildNewMonitoringSystem() {//leave alone - coming back to add template B
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

  Widget buildConveyorSpecifications() { //need to come back and add template C
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownField('Wheel: Open Race Style', [
          'Not Apolicable',
          'Open Inside',
          'Open Outside'
        ]),
        CommonWidgets.buildDropdownField('Wheel Sealed Style', [
          'Extended',
          'Flush',
          'Recessed'
        ]),
        CommonWidgets.buildDropdownField('Open Inside / Shielded Outside', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Outboard Wheels', [
          'Yes',
          'No'
        ]),
        
        CommonWidgets.buildDropdownField('Rail Lubrication', [
          'Yes',
          'No'
        ]),
        //template C goes here
        
        CommonWidgets.buildDropdownField('External Lubricaiton', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Current Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Current Lubricant Viscosity/Grade',currentGrade),

        CommonWidgets.buildDropdownField('Reservior Size', [
          '10 Gallon',
          '65 Gallon'
        ]),
        CommonWidgets.buildTextField('Enter Reservior Size Quantity',resSize),
        CommonWidgets.buildDropdownField('Is the Conveyor Chain Clean?', [
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
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('CTR Controller', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('PLC Connection', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Monitoring Controller', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Other Information ',optionInfo),
        CommonWidgets.buildTextField('Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify) ',specialOptions),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {// leave this alone will come back and do
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

  Widget buildWire() {
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
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 12 Conductor Number Here',conductor12),
        CommonWidgets.buildTextField('Enter Junction Box Quantities',jBox),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

}
