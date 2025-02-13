import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protienHome.dart';
import 'package:mighty_lube/helper_widgets.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  // Gen Info
  final TextEditingController conveyorSystemName = TextEditingController();
  int? conveyorChainSize;
  int? chainManufacturer;
  int? chainPinType;
  final TextEditingController conveyorLength = TextEditingController();
  int? conveyorLengthUnit;
  final TextEditingController conveyorSpeed = TextEditingController();
  int? conveyorSpeedUnit;
  final TextEditingController conveyorIndex = TextEditingController();
  int? directionOfTravel;
  int? metalType;
  int? conveyorStyle;
  int? trolleyColor;
  int? trolleyType;
  bool? surroundingTemp;
  bool? conveyorLoaded;
  bool? conveyorSwing;
  bool? plantLayout;
  bool? requiredPics;
  // CPU
  final TextEditingController operatingVoltage = TextEditingController();
  // MonSys
  bool? existingMonitor;
  bool? newMonitor;
  // MonFeatures
  bool? motorAmp;
  bool? takeUpAir;
  bool? takeUpDist;
  bool? motorTemp;
  bool? motorVib;
  bool? detectFaultyTrolley;
  // ConveyorSpecs
  bool? sideLube;
  bool? topLube;
  bool? cleanChain;
  // Wire
  int? measureUnits;
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildBreadcrumbNavigation(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(
                  context,
                  'New/Adding to Existing Monitoring System',
                  buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context,
                  'Monitoring Features Requested', buildMonitoringFeatures()),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire()),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(),
        const SizedBox(height: 20),
      ],
    );
  }

//buttons

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildTextField(
            'Name of Conveyor System', conveyorSystemName),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildDropdownFieldProtein(
            'Conveyor Chain Size',
            ['X348 Chain (3”)', 'X458 Chain (4”)', 'OX678 Chain (6”)', 'Other'],
            conveyorChainSize),
        CommonWidgets.buildDropdownFieldProtein(
            'Protein: Chain Manufacturer',
            [
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
            ],
            chainManufacturer),
        CommonWidgets.buildDropdownFieldProtein(
            'Chain Pin Type',
            [
              'Bolts',
              'Pin',
              'Log',
            ],
            chainPinType),
        CommonWidgets.buildTextField('Enter Number Here', conveyorLength),
        CommonWidgets.buildDropdownFieldProtein('Conveyor Length Unit',
            ['Feet', 'Inches', 'm Meter', 'mm Milimeter'], conveyorLengthUnit),
        CommonWidgets.buildTextField(
            'Enter Conveyor Speed (Min/Max)', conveyorSpeed),
        CommonWidgets.buildDropdownFieldProtein(
            'Conveyor Speed Unit',
            [
              'Feet/Minute',
              'Meter/Minute',
            ],
            conveyorSpeedUnit),
        CommonWidgets.buildTextField(
            'Indexing or Variable Speed Conditions', conveyorIndex),
        CommonWidgets.buildDropdownFieldProtein(
            'Direction of Travel',
            [
              'Right to Left',
              'Left to Right',
            ],
            directionOfTravel),
        CommonWidgets.buildDropdownFieldProtein('What Type of Metal',
            ['Stainless Steel', 'Zinc', 'Mild Steel', 'Other'], metalType),
        CommonWidgets.buildDropdownFieldProtein('Style of Conveyor',
            ['I-Beam', 'Meyn', 'Sani Track', 'T Rail', 'Other'], conveyorStyle),
        CommonWidgets.buildDropdownFieldProtein('Color of Trolley',
            ['Blue', 'Green', 'Grey', 'Other'], trolleyColor),
        CommonWidgets.buildDropdownFieldProtein(
            'Type of Trolly',
            [
              'Meyn Trolley Halve Green Wheel Bolt Version',
              'Meyn Plastic Click Version',
              'Meyn Stainless Steel Halve w/ Green Wheel',
              'Meyn Stainless Stell Halve Gray Wheel',
              'Stork Halve Bolt Version Blue Wheel',
              'Linco Plastic Halve Blue Wheel'
            ],
            trolleyType),
        CommonWidgets.buildDropdownFieldProtein(
            'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
            ['Yes', 'No'],
            surroundingTemp),
        CommonWidgets.buildDropdownFieldProtein(
            'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
            ['Loaded', 'Unloaded'],
            conveyorLoaded),
        CommonWidgets.buildDropdownFieldProtein(
            'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
            ['Yes', 'No'],
            conveyorSwing),
        CommonWidgets.buildDropdownFieldProtein(
            'I Have A Plant Layout To Attach',
            ['Yes - Will Attach', 'No - Do Not Have'],
            plantLayout),
        CommonWidgets.buildDropdownFieldProtein(
            'I Have The Required Pictures Of Each Chain To Attach',
            ['Yes - Will Attach', 'No - Do Not Have'],
            requiredPics),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
            'Operating Voltage - Single Phase: (Volts/hz] *', operatingVoltage),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
            'Connecting to Existing Monitoring',
            ['Yes', 'No'],
            existingMonitor),
        CommonWidgets.buildDropdownFieldProtein(
            'Add New Monitoring System', ['Yes', 'No'], newMonitor),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
            'Drive Motor Amp', ['Yes', 'No'], motorAmp),
        CommonWidgets.buildDropdownFieldProtein(
            'Drive Take-up-Air', ['Yes', 'No'], takeUpAir),
        CommonWidgets.buildDropdownFieldProtein(
            'Take-Up Distance', ['Yes', 'No'], takeUpDist),
        CommonWidgets.buildDropdownFieldProtein(
            'Drive Motor Temp', ['Yes', 'No'], motorTemp),
        CommonWidgets.buildDropdownFieldProtein(
            'Drive Motor Vibration', ['Yes', 'No'], motorVib),
        CommonWidgets.buildDropdownFieldProtein(
            'Bent or Missing Trolley detect',
            ['Yes', 'No'],
            detectFaultyTrolley),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
            'Lubrication from the Side of Chain', ['Yes', 'No'], sideLube),
        CommonWidgets.buildDropdownFieldProtein(
            'Lubrication from the Top of Chain', ['Yes', 'No'], topLube),
        CommonWidgets.buildDropdownFieldProtein(
            'Is the Conveyor Chain Clean?', ['Yes', 'No'], cleanChain),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein('Measurement Units',
            ['Feet', 'Inches', 'm Meter', 'mm Milimeter'], measureUnits),
        CommonWidgets.buildTextField(
            'Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField(
            'Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField(
            'Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}

Widget buildBreadcrumbNavigation(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.blue),
          onPressed: () {
            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ApplicationPage()),
            );
          },
        ),
        const Text(' > '),
        GestureDetector(
          onTap: () {
            // Navigate to the Protein page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProteinHome()),
            ); // Replace with navigation to your Protein page
          },
          child: const Text(
            'Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
  );
}
