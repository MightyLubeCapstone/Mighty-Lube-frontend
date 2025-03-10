import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/8.%20IFTL%20(2)/CLS%20(2)/products.dart';
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
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController chainMaster = TextEditingController();
  final TextEditingController specialOP = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const IFTLProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'In Floor Towline: Measurements',buildMeasurements()),
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
          'Webb-Stiles',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Milimeter',
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
        CommonWidgets.buildDropdownField('Wheel: Open Race Style', [
          'Not Applicable',
          'Open Inside',
          'Open Outside '
        ]),
        CommonWidgets.buildDropdownField('Wheel: Sealed Style', [
          'Extended',
          'Flush',
          'Recessed'
        ]),
        CommonWidgets.buildDropdownField('Open Inside/ Shielded Outside', [
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
          'Not Applicable ',
          'Open Inside',
          'Open Outside'
        ]),
        CommonWidgets.buildDropdownField('Guide Rollers Sealed Styles', [
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
        CommonWidgets.buildDropdownField('Rail Lubrication', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildTextField('Enter Current Lubrication Equipment (Brand)',equipBrand),
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
        CommonWidgets.buildTextField('Enter ChainMaster Controller',chainMaster),
        CommonWidgets.buildDropdownField('Timer', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Electric On/Off', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Pneumatic On/Off', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('PLC Connection', [
          'Yes',
          'No'
        ]),
       
        CommonWidgets.buildTextField('Enter Other Details',optionalInfo),
        CommonWidgets.buildTextField('Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',specialOP),

        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() { //leave alone will come back and do later
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
