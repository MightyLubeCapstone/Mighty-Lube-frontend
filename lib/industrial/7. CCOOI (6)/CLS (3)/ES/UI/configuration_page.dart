import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/CLS%20(3)/products.dart';
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
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController chainMaster = TextEditingController();
  final TextEditingController specialOP = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? wheelOpenRace = -1;
  int? wheelSealedStyle = -1;
  int? openInsideShielded = -1;
  int? freeTrolleyWheels = -1;
  int? guideRollers = -1;
  int? guideRollersOpenRace = -1;
  int? guideRollersSealedStyle = -1;
  int? openHole = -1;
  int? dogActuator = -1;
  int? pivotPoints = -1;
  int? kingPin = -1;
  int? outboardWheels = -1;
  int? railLubrication = -1;
  int? measurementUnits = -1;

  final Validators validate = Validators();
  Future<bool>? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'equipBrand': null,
    'currentType': null,
    'currentGrade': null,
  };

  // Sections map
  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'conveyorChainSize',
      'chainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
      'conveyorIndex',
      'directionOfTravel',
      'applicationEnvironment',
      'surroundingTemp',
      'conveyorLoaded',
      'conveyorSwing',
    ],
    'Customer Power Utilities': [
      'operatingVoltage',
    ],
    'New/Existing Monitoring System': [],
    'Conveyor Specifications': [
      'wheelOpenRace',
      'wheelSealedStyle',
      'openInsideShielded',
      'freeTrolleyWheels',
      'guideRollers',
      'guideRollersOpenRace',
      'guideRollersSealedStyle',
      'openHole',
      'dogActuator',
      'pivotPoints',
      'kingPin',
      'outboardWheels',
      'railLubrication',
      'equipBrand',
      'currentType',
      'currentGrade',
    ],
    'Controller': [
      'chainMaster',
      'specialOP',
      'optionalInfo',
    ],
    'Free Rail: Measurements': [
      'measurementUnits',
    ],
  };

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    operatingVoltage.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    chainMaster.dispose();
    specialOP.dispose();
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
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(currentType.text, 'currentType');
    validate.validateTextField(currentGrade.text, 'currentGrade');

    setState(() {});
  }

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
                  buildGeneralInformationContent(),
                  isError: validate.sectionError('General Information')),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent(),
                  isError: validate.sectionError('Customer Power Utilities')),
              CommonWidgets.buildGradientButton(context,
                  'New/Existing Monitoring System', buildNewMonitoringSystem(),
                  isError:
                      validate.sectionError('New/Existing Monitoring System')),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError('Conveyor Specifications')),
              CommonWidgets.buildGradientButton(
                  context, 'Controller', buildController(),
                  isError: validate.sectionError('Controller')),
              CommonWidgets.buildGradientButton(
                  context, 'Free Rail: Measurements', buildMeasurements(),
                  isError: validate.sectionError('Free Rail: Measurements')),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addESConfiguration(value);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
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
            'X678 Chain (6”)',
            '3/8" Log Chain',
            'Other'
          ],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value;
            });
          },
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
            'Other'
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Speed (Min/Max)',
          conveyorSpeed,
          errorText: errors['conveyorSpeed'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Speed Unit',
          ['Feet/Minute', 'Meters/Minute'],
          conveyorSpeedUnit,
          (value) {
            setState(() {
              conveyorSpeedUnit = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
            'Enter Indexing or Variable Speed Conditions', conveyorIndex),
        CommonWidgets.buildDropdownFieldError(
          'Direction of Travel',
          ['Right to Left', 'Left to Right'],
          directionOfTravel,
          (value) {
            setState(() {
              directionOfTravel = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Application Environment',
          [
            'Ambient',
            'Caustic (i.e. Phosphate/E-Coast, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other'
          ],
          applicationEnvironment,
          (value) {
            setState(() {
              applicationEnvironment = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          ['Yes', 'No'],
          surroundingTemp,
          (value) {
            setState(() {
              surroundingTemp = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          ['Loaded', 'Unloaded'],
          conveyorLoaded,
          (value) {
            setState(() {
              conveyorLoaded = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          ['Yes', 'No'],
          conveyorSwing,
          (value) {
            setState(() {
              conveyorSwing = value;
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
          'Operating Voltage - 3 Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
        ),
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
        CommonWidgets.buildDropdownFieldError(
          'Wheel: Open Race Style',
          ['Not Applicable', 'Open Inside', 'Open Outside '],
          wheelOpenRace,
          (value) {
            setState(() {
              wheelOpenRace = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Wheel: Sealed Style',
          ['Extended', 'Flush', 'Recessed'],
          wheelSealedStyle,
          (value) {
            setState(() {
              wheelSealedStyle = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Open Inside/ Shielded Outside',
          ['Yes', 'No'],
          openInsideShielded,
          (value) {
            setState(() {
              openInsideShielded = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Free Trolley Wheels',
          ['Yes', 'No'],
          freeTrolleyWheels,
          (value) {
            setState(() {
              freeTrolleyWheels = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Guide Rollers',
          ['Yes', 'No'],
          guideRollers,
          (value) {
            setState(() {
              guideRollers = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Guide Rollers Open Race Style',
          ['Not Applicable ', 'Open Inside', 'Open Outside'],
          guideRollersOpenRace,
          (value) {
            setState(() {
              guideRollersOpenRace = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Guide Rollers Sealed Styles',
          ['Extended', 'Flush', 'Recessed'],
          guideRollersSealedStyle,
          (value) {
            setState(() {
              guideRollersSealedStyle = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Open Hole',
          ['Yes', 'No'],
          openHole,
          (value) {
            setState(() {
              openHole = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Dog Actuator',
          ['Yes', 'No'],
          dogActuator,
          (value) {
            setState(() {
              dogActuator = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Pivot Points',
          ['Yes', 'No'],
          pivotPoints,
          (value) {
            setState(() {
              pivotPoints = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'King Pin',
          ['Yes', 'No'],
          kingPin,
          (value) {
            setState(() {
              kingPin = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Outboard Wheels',
          ['Yes', 'No'],
          outboardWheels,
          (value) {
            setState(() {
              outboardWheels = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Rail Lubrication',
          ['Yes', 'No'],
          railLubrication,
          (value) {
            setState(() {
              railLubrication = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubrication Equipment (Brand)',
          equipBrand,
          errorText: errors['equipBrand'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubricant Type',
          currentType,
          errorText: errors['currentType'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubricant Viscosity/Grade',
          currentGrade,
          errorText: errors['currentGrade'],
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Enter ChainMaster Controller',
          chainMaster,
        ),
        CommonWidgets.buildTextField(
          'Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          specialOP,
        ),
        CommonWidgets.buildTextField(
          'Enter Other Details',
          optionalInfo,
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Measurement Units',
          ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addESConfiguration(int numRequested) {
  if (validForm()) {
    dynamic configurationData = {
      'conveyorName': conveyorSystem.text,
      'chainSize': conveyorChainSize,
      'industrialChainManufacturer': chainManufacturer,
      'otherChainManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'conveyorLengthUnit': conveyorLengthUnit,
      'conveyorSpeed': conveyorSpeed.text,
      'conveyorSpeedUnit': conveyorSpeedUnit,
      'travelDirection': directionOfTravel,
      'appEnviroment': applicationEnvironment,
      'ovenStatus': null,
      'ovenTemp': null,
      'monitorData': {
        'existingMonitor': null,
        'newMonitor': null,
      },
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': conveyorSwing,
      'operatingVoltage': operatingVoltage.text,
      'controlVoltage': null,
      'wheelOpenType': wheelOpenRace,
      'wheelClosedType': wheelSealedStyle,
      'openStatus': openInsideShielded,
      'freeWheelStatus': freeTrolleyWheels,
      'guideRollerStatus': guideRollers,
      'openRaceStyle': guideRollersOpenRace,
      'closedRaceStyle': guideRollersSealedStyle,
      'holeStatus': openHole,
      'actuatorStatus': dogActuator,
      'pivotStatus': pivotPoints,
      'kingPinStatus': kingPin,
      'outboardWheels': outboardWheels,
      'railLubeStatus': railLubrication,
      'externalLubeStatus': null,
      'lubeBrand': equipBrand.text,
      'lubeType': currentType.text,
      'lubeViscosity': currentGrade.text,
      'sideLubeStatus': null,
      'topLubeStatus': null,
      'chainMaster': chainMaster.text,
      'timerStatus': null,
      'electricStatus': null,
      'pneumaticStatus': null,
      'mightyLubeMonitoring': null,
      'plcConnection': null,
      'otherControllerInfo': optionalInfo.text,
      'frUnitType': null,
      'frOverheadG': null,
      'frOverheadH': null,
      'frOverheadK': null,
      'frInvertedA': null,
      'frInvertedB': null,
      'frInvertedG': null,
      'frInvertedH': null,
      'frInvertedK': null,
      'frInvertedL': null,
    };
    status = FormAPI().addOrder("FRO_ES", configurationData, numRequested);
    return null;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill out all required fields.')),
    );
  }
  return null;
}

  buildErrorText(String message) {
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
