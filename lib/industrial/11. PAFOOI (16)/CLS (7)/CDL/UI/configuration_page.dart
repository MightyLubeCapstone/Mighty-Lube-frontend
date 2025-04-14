import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(16)/CLS%20(7)/products.dart';
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
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController conveyorLubeBrand = TextEditingController();
  final TextEditingController conveyorLubeType = TextEditingController();
  final TextEditingController conveyorLubeVisc = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildMonitoringFeatures()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire()),
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
        CommonWidgets.buildTextField('Name of Conveyor System',conveyorSystem),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'X678 Chain (6”)',
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
          'Webb-Stiles'
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),       
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Environmental Details'),
        CommonWidgets.buildDropdownField('Ambient Enviroment', [
          'Ambient',
          'Caustic (i.e. Phosphate/E-Coat,etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic',
          'Food Grade',
          'Other'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle('Customer Power Utilities'),
        CommonWidgets.buildTextField('Control Voltage (Volts/hz)', controlVoltage),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildTextField('Current Lubrication Equipment (Brand)', conveyorLubeBrand),
        CommonWidgets.buildTextField('Current Lubrication Lubricant Type', conveyorLubeType),
        CommonWidgets.buildTextField('Current Lubrication Viscosity/Grade', conveyorLubeVisc),
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

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Drive Motor Amp', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Drive Take-up-Air', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Take-Up Distance', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Drive Motor Temp', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Drive Motor Vibration', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Bent or Missing Trolley detect', [
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
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}
