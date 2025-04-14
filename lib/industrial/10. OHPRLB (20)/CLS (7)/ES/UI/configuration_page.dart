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
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController lubeEquipment = TextEditingController();
  final TextEditingController lubeType = TextEditingController();
  final TextEditingController lubeGrade = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController specs = TextEditingController();
  final TextEditingController other = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController aRail = TextEditingController();

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
                  'New/Existing Monitoring System', buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(
                  context, 'Controller', buildController()),
              CommonWidgets.buildGradientButton(
                  context, 'Overhead Power Rail: Measurements', buildMeasurements())
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
        CommonWidgets.buildTextField("Conveyor Speed (Min/Max)", conveyorSpeed),
        CommonWidgets.buildDropdownField(
            "Conveyor Speed Unit", ['Feet/minute', 'Meters/minute']),
        CommonWidgets.buildTextField(
            "Indexing or Variable Speed Conditions", conveyorIndex),
        CommonWidgets.buildDropdownField(
            "Direction of Travel", ["Right to Left", "Left to Right"]),
        CommonWidgets.buildDropdownField("Application Environment", [
          "Ambient",
          "Caustic (i.e. Phosphate/E-Coat, etc)",
          "Oven",
          "Washdown",
          "Intrinsic",
          "Food Grade",
          "Other"
        ]),
        CommonWidgets.buildDropdownField(
            "Does this require monitoring capabilities?", ["Yes", "No"]),
        CommonWidgets.buildDropdownField(
            'Is the Conveyor "__" at Planned Install Location',
            ['Loaded', 'Unloaded']),
        CommonWidgets.buildDropdownField(
            "Does conveyor swing, sway, surge, or move side-to-side?",
            ["Yes", "No"]),
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
            'Operating Voltage - Single Phase: (Volts/hz)', operatingVoltage),
        CommonWidgets.buildTextField(
            'Control Voltage - (Volts/hz)', controlVoltage),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
            'Connecting to Existing Monitoring', ['Yes', 'No']),
        CommonWidgets.buildDropdownField(
            'Add New Monitoring System', ['Yes', 'No']),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField("Wheel: Open Race Style",
            ["Not applicable", "Open Inside", "Open Outside"]),
        CommonWidgets.buildDropdownField(
            "Wheel: Sealed Style", ["Extended", "Flushed", "Recessed"]),
        CommonWidgets.buildDropdownField(
            "Open Inside / Shielded Outside", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Free Trolley Wheels", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Guide Rollers", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Guide Rollers Open Race Style",
            ["Not applicable", "Open Inside", "Open Outside"]),
        CommonWidgets.buildDropdownField(
            "Guide Rollers: Sealed Style", ["Extended", "Flushed", "Recessed"]),
        CommonWidgets.buildDropdownField("Open Hole", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Dog Actuator", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Pivot Points", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("King Pin", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Rail Lubrication", ["Yes", "No"]),
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
        CommonWidgets.buildDropdownField("Pneumatic (On/Off)", ["On", "Off"]),
        CommonWidgets.buildDropdownField(
            "Mighty Lube Monitoring", ["Yes", "No"]),
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

  Widget buildMeasurements() {
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
        
        // Image A
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain Drop (A)",
        hintText: "Rail to Center of Chain",
        imagePath: '', // there is no image on the site for this one
        controller: aRail,
        subHint: "(Rail to Center of Chain)",
      ),
        
        // Image B
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: '', // there is no image on the site for this one
        controller: bDiameter,
        subHint: "(Diameter)",
      ),

        // Image G
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Rail (G)",
        hintText: "Width",
        imagePath: '', // there is no image on the site for this one
        controller: gWidth,
        subHint: "(Width)",
      ),

        // Image H
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Rail (H)",
        hintText: "Height",
        imagePath: '', // there is no image on the site for this one
        controller: hHeight,
        subHint: "(Height)",
      ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

}
