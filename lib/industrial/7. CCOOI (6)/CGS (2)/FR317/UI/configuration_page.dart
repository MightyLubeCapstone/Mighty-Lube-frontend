import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/7.%20CCOOI%20(6)/CGS%20(2)/products.dart';
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
  final TextEditingController optionalInfo = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();

  final TextEditingController aInverted = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController eBottom = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController sInverted = TextEditingController();  
  
  // Dropdown values
  int? wheelManufacturer = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorType = -1;
  int? compressedAirUnit = -1;
  int? freeTrolleyWheels = -1;
  int? dogActuator = -1;
  int? pivotPoints = -1;
  int? kingPin = -1;
  int? zerkLocationSide = -1;
  int? zerkLocationOrientation = -1;
  int? remote = -1;
  int? mountedOnGreaser = -1;
  int? controlsOtherUnits = -1;
  int? timer = -1;
  int? electricOnOff = -1;
  int? pneumaticOnOff = -1;
  int? mightyLubeMonitoring = -1;
  int? plcConnection = -1;
  int? measurementUnits = -1;

  final Validators validate = Validators();
  Future<bool>? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'equipBrand': null,
    'currentType': null,
    'currentGrade': null,
    'greaseType': null,
    'greaseGrade': null,
  };

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
    'Customer Power Utilities': [
      'operatingVoltage',
    ],
    'New/Existing Monitoring System': [],
    'Conveyor Specifications': [
      'freeTrolleyWheels',
      'dogActuator',
      'pivotPoints',
      'kingPin',
      'equipBrand',
      'currentType',
      'currentGrade',
      'greaseType',
      'greaseGrade',
      'zerkLocationSide',
      'zerkLocationOrientation',
    ],
    'Controller': [
      'chainMaster',
      'remote',
      'mountedOnGreaser',
      'controlsOtherUnits',
      'timer',
      'electricOnOff',
      'pneumaticOnOff',
      'mightyLubeMonitoring',
      'plcConnection',
      'optionalInfo',
    ],
    'Inverted P&F: Measurements': [
      'measurementUnits','sInverted','hHeight','gWidth','eBottom','bDiameter','aInverted'
    ],
  };

  @override
  void initState() {
    super.initState();
    conveyorSystem.addListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorSystem');
      setState(() {});
    });
    conveyorSpeed.addListener(() {
      validate.onNameOpChanged(conveyorSpeed.text, 'conveyorSpeed');
      setState(() {});
    });
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
  }

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorSpeed.dispose();
    operatingVoltage.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    chainMaster.dispose();
    optionalInfo.dispose();
    greaseType.dispose();
    greaseGrade.dispose();
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
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(currentType.text, 'currentType');
    validate.validateTextField(currentGrade.text, 'currentGrade');
    validate.validateTextField(greaseType.text, 'greaseType');
    validate.validateTextField(greaseGrade.text, 'greaseGrade');

    validate.validateTextField(sInverted.text, 'sInverted');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(eBottom.text, 'eBottom');
    validate.validateTextField(bDiameter.text, 'bDiameter');
    validate.validateTextField(aInverted.text, 'aInverted');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');
  
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
          context,
          '>',
          const ApplicationPage(),
          'Products',
          const CGSProducts(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                context,
                'General Information',
                buildGeneralInformationContent(),
                isError: validate.sectionError('General Information'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Customer Power Utilities',
                buildCustomerPowerUtilitiesContent(),
                isError: validate.sectionError('Customer Power Utilities'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'New/Existing Monitoring System',
                buildNewMonitoringSystem(),
                isError:
                    validate.sectionError('New/Existing Monitoring System'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Conveyor Specifications',
                buildConveyorSpecifications(),
                isError: validate.sectionError('Conveyor Specifications'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Controller',
                buildController(),
                isError: validate.sectionError('Controller'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Inverted P&F: Measurements',
                buildMeasurements(),
                isError: validate.sectionError('Inverted P&F: Measurements'),
              ),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addFR317Configuration(value);
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
        CommonWidgets.buildTextField(
          'Enter Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Wheel Manufacturer',
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
            'Other',
          ],
          wheelManufacturer,
          (value) {
            setState(() {
              wheelManufacturer = value;
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
            'Other',
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
          'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          ['Overhead', 'Inverted', 'Inverted/Inverted'],
          conveyorType,
          (value) {
            setState(() {
              conveyorType = value;
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
        CommonWidgets.buildDropdownFieldError(
          'Compressed Air Supply Unit',
          ['PSI', 'KPI', 'Bar'],
          compressedAirUnit,
          (value) {
            setState(() {
              compressedAirUnit = value;
            });
          },
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
          'Connecting to Existing Monitoring',
          ['Yes', 'No'],
        ),
        CommonWidgets.buildDropdownField(
          'Add New Monitoring System',
          ['Yes', 'No'],
        ),
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
        CommonWidgets.buildTextField(
          'Enter Current Grease Type',
          greaseType,
          errorText: errors['greaseType'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Grease NLGI Grade',
          greaseGrade,
          errorText: errors['greaseGrade'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Zerk Ftg Location [Left or Right: Facing Direction of Travel]',
          ['Left', 'Right'],
          zerkLocationSide,
          (value) {
            setState(() {
              zerkLocationSide = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Zerk Ftg Location (Orientation)',
          ['Center', '12 O-Clock', '3 O-Clock', '6 O-Clock', '9 O-Clock'],
          zerkLocationOrientation,
          (value) {
            setState(() {
              zerkLocationOrientation = value;
            });
          },
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
        CommonWidgets.buildDropdownFieldError(
          'Remote',
          ['Yes', 'No'],
          remote,
          (value) {
            setState(() {
              remote = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Mounted on Greaser',
          ['Yes', 'No'],
          mountedOnGreaser,
          (value) {
            setState(() {
              mountedOnGreaser = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Controls other units (list):',
          ['Yes', 'No'],
          controlsOtherUnits,
          (value) {
            setState(() {
              controlsOtherUnits = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Timer',
          ['Yes', 'No'],
          timer,
          (value) {
            setState(() {
              timer = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Electric On/Off',
          ['Yes', 'No'],
          electricOnOff,
          (value) {
            setState(() {
              electricOnOff = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Pneumatic On/Off',
          ['Yes', 'No'],
          pneumaticOnOff,
          (value) {
            setState(() {
              pneumaticOnOff = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Mighty Lube Monitoring',
          ['Yes', 'No'],
          mightyLubeMonitoring,
          (value) {
            setState(() {
              mightyLubeMonitoring = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'PLC Connection',
          ['Yes', 'No'],
          plcConnection,
          (value) {
            setState(() {
              plcConnection = value;
            });
          },
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
        title: "Inverted Power and Free Chain Drop (A)",
        hintText: "Center of Chain to Opposite Edge of Rail",
        imagePath: 'assets/Measurements/7/CGS/317/A.png',
        controller: aInverted,
        subHint: "(Center of Chain to Opposide Edge of Rail)",
        errorText: errors['aInverted'],
      ),

      // Image B
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: 'assets/Measurements/7/CGS/317/B.png',
        controller: bDiameter,
        subHint: "(Diameter)",
        errorText: errors['bDiameter'],
      ),
      
      // Image E
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Zerk Fitting Vertical Location (E)",
        hintText: "Bottom of Rail to Zerk Fitting",
        imagePath: 'assets/Measurements/7/CGS/317/E.png',
        controller: eBottom,
        subHint: "(Bottom of Rail to Zerk Fitting)",
        errorText: errors['eBottom'],
      ),
      
      // Image G
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/7/CGS/317/G.png',
        controller: gWidth,
        subHint: "(Width)",
        errorText: errors['gWidth'],
      ),
      
      // Image H
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/7/CGS/317/H.png',
        controller: hHeight,
        subHint: "(Height)",
        errorText: errors['hHeight'],
      ),
      
      // Image S
      CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Trolley Pitch [Spacing] Minimum - For Variables pitch chain, Provide the Minimum Pitch Dimensions (S)",
        hintText: "Center of Power Wheel to Center of Power Wheel",
        imagePath: 'assets/Measurements/7/CGS/317/S.png',
        controller: sInverted,
        subHint: "(Center of Power Wheel to Center of Power Wheel)",
        errorText: errors['sInverted'],
      ),  
    ],
  );
}

  VoidCallback? addFR317Configuration(int numRequested) {
  if (validForm()) {
    dynamic fr317Data = {
      'conveyorName': conveyorSystem.text,
      'wheelManufacturer': wheelManufacturer,
      'otherWheelManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'conveyorLengthUnit': null,
      'conveyorSpeed': conveyorSpeed.text,
      'conveyorSpeedUnit': conveyorSpeedUnit,
      'travelDirection': directionOfTravel,
      'appEnviroment': applicationEnvironment,
      'ovenStatus': null,
      'ovenTemp': null,
      'surroundingTemp': surroundingTemp,
      'conveyorSwing': null,
      'orientation': conveyorType,
      'operatingVoltage': operatingVoltage.text,
      'controlVoltage': null,
      'compressedAir': null,
      'airSupply': compressedAirUnit,
      'templateB': {
        'existingMonitor': null,
        'newMonitor': null,
      },
      'freeWheelStatus': freeTrolleyWheels,
      'guideRollerStatus': null,
      'openRaceStyle': null,
      'closedRaceStyle': null,
      'openStatus': null,
      'lubeBrand': equipBrand.text,
      'lubeType': currentType.text,
      'lubeViscosity': currentGrade.text,
      'currentGrease': greaseType.text,
      'currentGreaseGrade': greaseGrade.text,
      'zerkDirection': zerkLocationOrientation,
      'zerkLocation': zerkLocationSide,
      'chainMaster': chainMaster.text,
      'remoteStatus': remote,
      'mountStatus': mountedOnGreaser,
      'otherUnitStatus': controlsOtherUnits,
      'timerStatus': timer,
      'electricStatus': electricOnOff,
      'pneumaticStatus': pneumaticOnOff,
      'mightyLubeMonitoring': mightyLubeMonitoring,
      'preMountType': null,
      'plcConnection': plcConnection,
      'otherControllerInfo': optionalInfo.text,
      'frUnitType': null,
      'frInvertedA': null,
      'frInvertedB': null,
      'frInvertedE': null,
      'frInvertedG': gWidth.text,
      'frInvertedH': hHeight.text,
      'frInvertedS': null,
    };
    status = FormAPI().addOrder("FRO_317", fr317Data, numRequested);
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
