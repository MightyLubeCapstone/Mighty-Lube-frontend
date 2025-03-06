import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/CLS%20(2)/products.dart';
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
  final TextEditingController conductor12 = TextEditingController();


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
              CommonWidgets.buildGradientButton(context, 'Enclosed Track Inverted: Measurements',buildMeasurements()),
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
        CommonWidgets.buildTextField('Enter Name of Conveyor System', conveyorSystem),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Protein: Chain Manufacturer', [
          'Daifuku', 'Frost', 'NKC', 'Pacline', 'Rapid', 'WEBB', 'Webb-Stiles', 'Wilkie Brothers', 'Others']),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet', 'Inches', 'm Meter', 'mm Millimeters'
        ]),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute', 'Meters/Minute'
        ]),
        CommonWidgets.buildTextField('Enter Indexing or Variable Speed Conditions', conveyorIndex),
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left', 'Left to Right'
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

  Widget buildConveyorSpecifications() { // will need template A and C
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownField('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ]),
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
        CommonWidgets.buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
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
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() { //leave this alone will come back and do later
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }


}
