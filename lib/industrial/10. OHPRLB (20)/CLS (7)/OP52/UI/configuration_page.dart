import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/CLS%20(7)/products.dart';
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
  final TextEditingController lubeEquipment = TextEditingController();
  final TextEditingController lubeType = TextEditingController();
  final TextEditingController lubeGrade = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController other = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController specs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const CLSProducts()),
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
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(
                  context, 'Controller', buildController()),
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
        CommonWidgets.buildTextField("Name of Conveyor System", conveyorSystem),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'X678 Chain (6”)',
          '3/8" Log Chain',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Protein: Chain Manufacturer', [
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
        CommonWidgets.buildTextField("Conveyor Length", conveyorLength),
        CommonWidgets.buildDropdownField("Conveyor Length Unit",
            ['Feet', 'Inches', 'm Meter', 'mm Millimeter']),
        CommonWidgets.buildDropdownField("Application Environment", [
          "Ambient",
          "Caustic (i.e. Phosphate/E-Coat, etc)",
          "Oven",
          "Washdown",
          "Intrinsic",
          "Food Grade",
          "Other"
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
        CommonWidgets.buildTextField(
            'Control Voltage - (Volts/hz)', controlVoltage),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
            "Current Lubrication Equipment (Brand)", lubeEquipment),
        CommonWidgets.buildTextField("Current Lubrication Type", lubeType),
        CommonWidgets.buildTextField(
            "Current Lubrication Viscosity/Grade", lubeGrade),
        CommonWidgets.buildDropdownField(
            "Side Chain Lubrication", ["Yes", "No"]),
        CommonWidgets.buildDropdownField(
            "Top Chain Lubrication", ["Yes", "No"]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
            "ChainMaster Controller", ["Yes", "No"]),
        CommonWidgets.buildDropdownField(
            "Timer", ["Not Required", "12 Hour", "1000 Hour"]),
        CommonWidgets.buildDropdownField("Electric (On/Off)", ["On", "Off"]),
        CommonWidgets.buildDropdownField("PLC Connection", ["Yes", "No"]),
        CommonWidgets.buildTextField("Other describe", other),
        CommonWidgets.buildTextField(
            "Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)",
            specialOptions),
        CommonWidgets.buildTextField("Please Specify", specs),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}
