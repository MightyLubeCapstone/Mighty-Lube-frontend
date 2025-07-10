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
  int existingMonitoring = -1;
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController controlVoltage = TextEditingController();
  final TextEditingController catDriveQuantity = TextEditingController();
  final TextEditingController lubeEquipment = TextEditingController();
  final TextEditingController lubeType = TextEditingController();
  final TextEditingController lubeGrade = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController conductor12 = TextEditingController();
  final TextEditingController junctBoxQuant = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();

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
              //CommonWidgets.buildGradientButton(context,'New/Existing Monitoring System', buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire()),
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
            "Surrounding temp below 30°F or above 120°F?", ["Yes", "No"]),
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

// this is broken because of the validation?
  /*Widget buildNewMonitoringSystem() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonWidgets.buildSectionDivider(),
      CommonWidgets.buildDropdownFieldError(
        'Connecting to Existing Monitoring',
        ['Yes', 'No'],
        existingMonitoring,
        (value) {
          setState(() {
            existingMonitoring = value;
            validate.validateDropdownField(
                existingMonitoring, 'existingMonitoring');
          });
        },
        errorText: errors['existingMonitoring'],
      ),
      CommonWidgets.buildSectionDivider(),

      if (existingMonitoring == 1)
        CommonWidgets.buildTemplateA(validate),
    ],
  );
}*/

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField("Wheel: Open Race Style",
            ["Not applicable", "Open Inside", "Open Outside"]),
        CommonWidgets.buildDropdownField(
            "Wheel: Sealed Style", ["Extended", "Flushed", "Recessed"]),
        CommonWidgets.buildDropdownField("Power Chain", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Chain Pins", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("Caterpillar Drive", ["Yes", "No"]),
        CommonWidgets.buildTextField(
            "Caterpillar Drive Quantity", catDriveQuantity),
        CommonWidgets.buildDropdownField("Rail Lubrication", ["Yes", "No"]),
        CommonWidgets.buildDropdownField("External Lubrication", ["Yes", "No"]),
        CommonWidgets.buildTextField(
            "Current Lubrication Equipment (Brand)", lubeEquipment),
        CommonWidgets.buildTextField("Current Lubrication Type", lubeType),
        CommonWidgets.buildTextField(
            "Current Lubrication Viscosity/Grade", lubeGrade),
        CommonWidgets.buildDropdownField(
            "Side Chain Lubrication", ["Yes", "No"]),
        CommonWidgets.buildDropdownField(
            "Top Chain Lubrication", ["Yes", "No"]),
        CommonWidgets.buildDropdownField(
            "Is the Conveyor Chain Clean?", ["Yes", "No"]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
            'Measurement Units', ['Feet', 'Inches', 'm Meter', 'mm Milimeter']),
        CommonWidgets.buildTextField(
            'Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildTextField(
            'Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField(
            'Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField(
            'Enter 12 Conductor Number Here', conductor12),
        CommonWidgets.buildTextField('Junction Box Quantity', junctBoxQuant),
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
