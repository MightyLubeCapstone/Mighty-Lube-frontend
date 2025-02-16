import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protienHome.dart';
import 'package:mighty_lube/helper_widgets.dart';

import '../API/fgco_api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  Future<bool>? status;

  final TextEditingController conveyorSystemName = TextEditingController();
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? conveyorLoaded = -1;
  int? dripLine = -1;
  final TextEditingController operatingVoltage = TextEditingController();
  int? installationClearance = -1;
  int? pushButton = -1;
  int? enclosedShroud = -1;
  final TextEditingController additionalOtherInfo = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'OP-SS', buildOPSS()),
              CommonWidgets.buildGradientButton(
                  context, 'Additional Options Avaliable', buildAdditional()),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addFGCOinfo(value);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

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
          [
            'X348 Chain (3”)',
            'X458 Chain (4”)',
            'OX678 Chain (6”)',
            '3/8" Log Chain'
                'Other'
          ],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = (value); // Update state properly
            });
          },
        ),
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
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          ['Loaded', 'Unloaded'],
          conveyorLoaded,
          (value) {
            setState(() {
              conveyorLoaded = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Is this a Drip Line?',
          ['Yes', 'No'],
          dripLine,
          (value) {
            setState(() {
              dripLine = (value); // Update state properly
            });
          },
        ),
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
            'Enter Operating Voltage - 3 Phase: (Volts/hz)', operatingVoltage),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildOPSS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
          'Confirm Installation Clearance of: Minimum of 2" (.61m) for Clearance fo Moter Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'],
          installationClearance,
          (value) {
            setState(() {
              installationClearance = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildAdditional() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
          ' 3-Station Push Button Switch',
          ['Yes', 'No'],
          pushButton,
          (value) {
            setState(() {
              pushButton = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Totally Enclosed Food-Grade Metal Shroud',
          ['Yes', 'No'],
          enclosedShroud,
          (value) {
            setState(() {
              enclosedShroud = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildTextField(
            'Enter Other Information Here: ', additionalOtherInfo),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addFGCOinfo(int numRequested) {
    dynamic fgcoData = {
      "conveyorSystemName": conveyorSystemName.text,
      "conveyorChainSize": conveyorChainSize,
      "chainManufacturer": chainManufacturer,
      "conveyorLoaded": conveyorLoaded,
      "dripLine": dripLine,
      "operatingVoltTriple": (operatingVoltage.text != "")
          ? int.parse(operatingVoltage.text)
          : -1, // remove this once validation is here
      "installationClearance": installationClearance,
      "pushButton": pushButton,
      "enclosedShroud": enclosedShroud,
      "additionalOtherInfo": additionalOtherInfo.text
    };
    status = FormAPI().addFGCO(fgcoData, numRequested);
    return null;
  }
}

Widget buildBreadcrumbNavigation(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.home,
            color: Color(0xFF579AF6),
          ),
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
