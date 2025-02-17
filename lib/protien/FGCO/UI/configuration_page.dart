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
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorVolts = TextEditingController();
  final TextEditingController conveyorOptions = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const ProteinHome()),
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
        CommonWidgets.buildConfiguratorWithCounter(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildTextField('Name of Conveyor System', conveyorSystem),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildDropdownField(
          'Conveyor Chain Size',
          [
            'X348 Chain (3”)',
            'X458 Chain (4”)',
            'OX678 Chain (6”)',
            '3/8" Log Chain'
                'Other'
          ],
        ),
        CommonWidgets.buildDropdownField(
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
        ),
        CommonWidgets.buildDropdownField(
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          ['Loaded', 'Unloaded'],
        ),
        CommonWidgets.buildDropdownField(
          'Is this a Drip Line?',
          ['Yes', 'No'],
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
            'Enter Operating Voltage - 3 Phase: (Volts/hz)', conveyorVolts),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildOPSS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
          'Confirm Installation Clearance of: Minimum of 2" (.61m) for Clearance fo Moter Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'],
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
        CommonWidgets.buildDropdownField(
          ' 3-Station Push Button Switch',
          ['Yes', 'No'],
        ),
        CommonWidgets.buildDropdownField(
          'Totally Enclosed Food-Grade Metal Shroud',
          ['Yes', 'No'],
        ),
        CommonWidgets.buildTextField(
            'Enter Other Information Here: ', conveyorOptions),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}
