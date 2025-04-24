import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/CCS%20(1)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count

  // Text controllers
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();

  final TextEditingController aTop = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController lCenter = TextEditingController();
  final TextEditingController aCenter = TextEditingController();
  final TextEditingController bDiameter2 = TextEditingController();
  final TextEditingController gWidth2 = TextEditingController();
  final TextEditingController hHeight2 = TextEditingController();
  final TextEditingController kCenter = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? conveyorLengthUnit = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? measurementUnits = -1;

  final Validators validate = Validators();
  Future<bool>? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'aTop': null,
    'bDiameter': null,
    'gWidth': null,
    'hHeight': null,
    'lCenter': null,
    'aCenter': null,
    'bDiameter2': null,
    'gWidth2': null,
    'hHeight2': null,
    'kCenter': null,
    'measurementUnits': null,
  };

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    aTop.dispose();
    bDiameter.dispose();
    gWidth.dispose();
    hHeight.dispose();
    lCenter.dispose();
    aCenter.dispose();
    bDiameter2.dispose();
    gWidth2.dispose();
    hHeight2.dispose();
    kCenter.dispose();
    super.dispose();
  }

  bool validForm() {
    validate.mapErrors(errors);
    validate.mapSections(sections); 
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');

    validate.validateTextField(aTop.text, 'aTop');
    validate.validateTextField(bDiameter.text, 'bDiameter');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(lCenter.text, 'lCenter');
    validate.validateTextField(aCenter.text, 'aCenter');
    validate.validateTextField(bDiameter2.text, 'bDiameter2');
    validate.validateTextField(gWidth2.text, 'gWidth2');
    validate.validateTextField(hHeight2.text, 'hHeight2');
    validate.validateTextField(kCenter.text, 'kCenter');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');

    setState(() {});
  }

  // Sections map
  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'wheelManufacturer',
      'conveyorSpeed',
      'conveyorSpeedUnit',
      'directionOfTravel',
      'applicationEnvironment',
      'surroundingTemp',
      'conveyorType',
    ],
    'Measurements': [
      'measurementUnits',
      'aTop',
      'bDiameter',
      'gWidth',
      'hHeight',
      'lCenter','aCenter','bDiameter2','gWidth2','hHeight2','kCenter'
    ],
  };


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const CCSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent(),
                  isError: validate.sectionError("General Information")),
              CommonWidgets.buildGradientButton(
                  context, 'Free Rail: Measurements', buildMeasurements(),
                  isError: validate.sectionError("Measurements")),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addOEBConfiguration(value);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField(
          'Enter Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          [
            'X348 Chain (3”)',
            'X458 Chain (4”)',
            'OX678 Chain (6”)',
            'Other',
          ],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value;
              validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
            });
          },
          errorText: errors['conveyorChainSize'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Chain Manufacturer',
          [
            'Daifuku',
            'Frost',
            'NKC',
            'Pacline',
            'Rapid',
            'WEBB',
            'Webb-Stiles',
            'Wilkie Brothers',
            'Other',
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
              validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
            });
          },
          errorText: errors['chainManufacturer'],
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        CommonWidgets.buildDropdownField(
          'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
        ),
        CommonWidgets.buildDropdownField(
          'Application Environment',
          [
            'Ambient',
            'Caustic (i.e. Phosphate / E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),
        CommonWidgets.buildDropdownField(
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          ['Yes', 'No'],
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
  
  Widget buildMeasurements() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonWidgets.buildDropdownFieldError(
          'Measurement Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
              validate.validateDropdownField(measurementUnits, 'measurementUnits');
            });
          },
          errorText: errors['measurementUnits'], 
        ),
      
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Chain Drop (A)",
        hintText: "Top of Rail to Center of Chain",
        imagePath: 'assets/Measurements/7/CCS/A.png',
        controller: aTop,
        subHint: "(Top of Rail to Center of Chain)",
        errorText: errors['aTop'],
      ),

      // Image B
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/7/CCS/B.png',
        controller: bDiameter,
        subHint: "Diameter",
        errorText: errors['bDiameter'],
      ),
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/7/CCS/G.png',
        controller: gWidth,
        subHint: "(Width)",
        errorText: errors['gWidth'],
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/7/CCS/H.png',
        controller: hHeight,
        subHint: "(Height)",
        errorText: errors['hHeight'],
      ),
      
      // Image L
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Free Trolley Wheel Position (Vertical - L)",
        hintText: "Center of Free Trolley Wheel to Bottom of Rail",
        imagePath: 'assets/Measurements/7/CCS/L.png',
        controller: lCenter,
        subHint: "(Center of Free Tolley Wheel to Bottom of Rail)",
        errorText: errors['lCenter'],
      ),
      
      // Image A
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Chain Drop (A)",
        hintText: "Center of Chain to Opposite Edge of Rail",
        imagePath: 'assets/Measurements/7/CCS/A_Color.png',
        controller: aCenter,
        subHint: "(Center of Chain to Opposite Edge of Rail)",
        errorText: errors['aCenter'],
      ),
      
      // Image B2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/7/CCS/B2.png',
        controller: bDiameter2,
        subHint: "(Diameter)",
        errorText: errors['bDiameter2'],
      ),
      
      // Image G2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/7/CCS/G2.png',
        controller: gWidth2,
        subHint: "(Width)",
        errorText: errors['gWidth2'],
      ),
      
      // Image H2
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/7/CCS/H2.png',
        controller: hHeight2,
        subHint: "(Height)",
        errorText: errors['hHeight2'],
      ),
      
      // Image K
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Trolley Wheel Pitch (K)",
        hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
        imagePath: 'assets/Measurements/7/CCS/K.png',
        controller: kCenter,
        subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
        errorText: errors['kCenter'],
      ),
      
    ],
  );
}

  VoidCallback? addOEBConfiguration(int numRequested) {
  if (validForm()) {
    dynamic oebData = {
      'conveyorName': conveyorSystem.text,
      'chainSize': conveyorChainSize,
      'otherChainSize': null,
      'industrialChainManufacturer': chainManufacturer,
      'otherChainManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'conveyorLengthUnit': conveyorLengthUnit,
      'appEnviroment': applicationEnvironment,
      'ovenStatus': null,
      'ovenTemp': null,
      'surroundingTemp': surroundingTemp,
      'frUnitType': null,
      'frOverheadA': aTop.text,
      'frOverheadB': bDiameter.text,
      'frOverheadG': gWidth.text,
      'frOverheadH': hHeight.text,
      'frOverheadL': lCenter.text,
      'frInvertedA': aCenter.text,
      'frInvertedB': bDiameter2.text,
      'frInvertedG': gWidth2.text,
      'frInvertedH': hHeight2.text,
      'frInvertedK': kCenter.text,
    };
    status = FormAPI().addOrder("FRO_OEB", oebData, numRequested);
    return null;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill out all required fields.')),
    );
  }
  return null;
}

  Widget buildErrorText(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4, bottom: 8),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}