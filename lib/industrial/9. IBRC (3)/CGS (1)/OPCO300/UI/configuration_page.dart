import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/9.%20IBRC%20(3)/CGS%20(1)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';

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
  final TextEditingController compressedAir = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController lubricationType = TextEditingController();
  final TextEditingController lubricationGrade = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();
  final Validators validate = Validators();
  Future<bool>? status;
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  int? conveyorChainSize = -1;
  int? conveyorChainManufacturer = -1;
  int? conveyorLoaded = -1;
  int? dripLine = -1;
  int? installationClearance = -1;
  int? pushButtonSwitch = -1;
  int? existingMonitoring = -1;
  int? newMonitoring = -1;
  int? driveMotorAmp = -1;
  int? driveTakeUpAir = -1;
  int? takeUpDistance = -1;
  int? driveMotorTemp = -1;
  int? driveMotorVibration = -1;
  int? bentOrMissingTrolley = -1;
  int? lubricationSideChain = -1;
  int? lubricationTopChain = -1;
  int? chainClean = -1;
  int? measurementUnits = -1;

  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'conveyorChainManufacturer': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'conveyorIndex': null,
    'operatingVoltage': null,
  };

  bool validForm() {
    validate.mapErrors(errors);
    validate.mapSections(sections);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(
        conveyorChainManufacturer, 'conveyorChainManufacturer');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    conveyorSystem.addListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorName');
      setState(() {});
    });
    conveyorLength.addListener(() {
      validate.onNameOpChanged(conveyorLength.text, 'conveyorLength');
      setState(() {});
    });
    conveyorSpeed.addListener(() {
      validate.onNameOpChanged(conveyorSpeed.text, 'conveyorSpeed');
      setState(() {});
    });
    conveyorIndex.addListener(() {
      validate.onNameOpChanged(conveyorIndex.text, 'conveyorIndex');
      setState(() {});
    });
  }

  @override
  void dispose() {
    conveyorSystem.removeListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorName');
      setState(() {});
    });
    conveyorLength.removeListener(() {
      validate.onNameOpChanged(conveyorLength.text, 'conveyorLength');
      setState(() {});
    });
    conveyorSpeed.removeListener(() {
      validate.onNameOpChanged(conveyorSpeed.text, 'conveyorSpeed');
      setState(() {});
    });
    conveyorIndex.removeListener(() {
      validate.onNameOpChanged(conveyorIndex.text, 'conveyorIndex');
      setState(() {});
    });

    validate.delay?.cancel();
    super.dispose();
  }

  final Map<String, List<String>> sections = {
    "general": [
      'conveyorName',
      'conveyorChainSize',
      'chainManufacturer',
      'chainPinType',
      'metalType',
      'conveyorStyle',
      'trolleyColor',
      'trolleyType',
      'conveyorLoaded',
      'conveyorSwing'
    ],
    "monitor": ['motorAmp', 'takeUpAir', 'takeUpDist', 'detectFaultyTrolley'],
    "custom": ['operatingVoltage'],
    "conveyor": ['sideLube', 'topLube'],
    "wire": ['con2', 'con4', 'con7'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const IBRCProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                context,
                'General Information',
                buildGeneralInformationContent(),
                isError: validate.sectionError("general"),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Customer Power Utilities',
                buildCustomerPowerUtilitiesContent(),
                isError: validate.sectionError("custom"),
              ),
              CommonWidgets.buildGradientButton(context,
                  'New/Existing Monitoring System', buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(
                  context, 'Controller', buildController()),
              CommonWidgets.buildGradientButton(context,
                  'In Board Roller Chain: Measurements', buildMeasurements()),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addOPCO300(value);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

//actual buttons w/ the questions :)
  Widget buildGeneralInformationContent() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: conveyorSystem,
        builder: (context, value, child) {
          validate.validatorDelay(value.text, 'conveyorName');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildTextField(
                  'Name of Conveyor System *', conveyorSystem,
                  errorText: errors['conveyorName']),
              if (errors['conveyorName'] != null)
                buildErrorText(errors['conveyorName']!),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Chain Size',
                [
                  'CC5 3”',
                  'CC5 4”',
                  'CC5 6”',
                  'RC60',
                  'RC80',
                  'RC 2080',
                  'RC 2060',
                  'Other'
                ],
                conveyorChainSize,
                (value) {
                  setState(() {
                    conveyorChainSize = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorChainSize, 'conveyorChainSize');
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
                  'Other'
                ],
                conveyorChainManufacturer,
                (value) {
                  setState(() {
                    conveyorChainManufacturer = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorChainManufacturer, 'conveyorChainManufacturer');
                  });
                },
              ),
              CommonWidgets.buildDropdownField('Wheel Manufacturer', [
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
              ]),
              CommonWidgets.buildTextField(
                  'Enter Conveyor Length', conveyorLength),
              CommonWidgets.buildDropdownField('Conveyor Length Unit', [
                'Feet',
                'Inches',
                'm Meter',
                'mm Millimeter',
              ]),
              CommonWidgets.buildTextField(
                  'Conveyor Speed (Min/Max)', conveyorSpeed),
              CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
                'Feet/Minute',
                'Meter/Minute',
              ]),
              CommonWidgets.buildTextField(
                  'Indexing or Variable Speed Conditions', conveyorIndex),
              CommonWidgets.buildDropdownField('Direction of Travel', [
                'Right to Left',
                'Left to Right',
              ]),
              CommonWidgets.buildDropdownField('Application Environment', [
                'Ambient',
                'Caustic (i.e. Phosphate/E-Coat, etc.)',
                'Oven',
                'Wash Down',
                'Intrinsic',
                'Food Grade',
                'Other'
              ]),
              CommonWidgets.buildDropdownField(
                  'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
                  [
                    'Yes',
                    'No',
                  ]),
              CommonWidgets.buildDropdownField(
                  'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
                  [
                    'Unloaded',
                    'Loaded',
                  ]),
              CommonWidgets.buildDropdownField(
                  'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?', [
                'Yes',
                'No',
              ]),
              CommonWidgets.buildDropdownField(
                  'Is Conveyor Single or Double Strand?', [
                'Single',
                'Double',
              ]),
              CommonWidgets.buildSectionDivider(),
            ],
          );
        });
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Operating Voltage - Single Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
        ),
        if (errors['operatingVoltage'] != null)
          buildErrorText(errors['operatingVoltage']!),
        CommonWidgets.buildTextField(
            'Enter Compressed Air Supply', compressedAir),
        CommonWidgets.buildDropdownField('Compressed Air Supply Unit', [
          'PSI',
          'KPI',
          'BAR',
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    //leave alone for template B
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
              existingMonitoring = value; // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Add New Monitoring System',
          ['Yes', 'No'],
          newMonitoring,
          (value) {
            setState(() {
              newMonitoring = value; // Update state properly
            });
          },
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
        CommonWidgets.buildDropdownField('Wheel: Open Race Style',
            ['Not Applicable', 'Open Inside', 'Open Outside']),
        CommonWidgets.buildDropdownField(
            'Wheel: Sealed Style', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField(
            'Open Inside / Shielded Outside', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Free Trolley Wheels', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Guide Rollers', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Guide Rollers Open Race Style',
            ['Not Applicable', 'Open Inside', 'Open Outside']),
        CommonWidgets.buildDropdownField(
            'Guide Rollers Sealed Style', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField('Open Hole', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Roller Chains', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Bushings', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Outboard Wheels', ['Yes', 'No']),
        CommonWidgets.buildTextField(
            'Enter Current Lubrication Equipment (Brand)', equipBrand),
        CommonWidgets.buildTextField(
            'Enter Current Lubrication Type', lubricationType),
        CommonWidgets.buildTextField(
            'Enter Current Lubrication Viscosity/Grade', lubricationGrade),
        CommonWidgets.buildDropdownField(
            'Is the Conveyor Chain Clean?', ['Yes', 'No']),
        CommonWidgets.buildTextField('Enter Current Grease Type', greaseType),
        CommonWidgets.buildTextField(
            'Enter Current Grease NLGI Grade', greaseGrade),
        CommonWidgets.buildDropdownField(
            'Zerk Ftg Location [Left or Right: Facing Direction of Travel)',
            ['Left', 'Right']),
        CommonWidgets.buildDropdownField('Zerk Ftg Location (Orientation)',
            ['Center', '12 O"Clock', '3 O"Clock', '6 O"Clock', '9 O"Clock']),
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
            'ChainMaster Controller', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Remote', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Mounted on Greaser', ['Yes', 'No']),
        CommonWidgets.buildDropdownField(
            'Controls Other Units (list)', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Timer', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Electric On/Off', ['Yes', 'No']),
        CommonWidgets.buildDropdownField(
            'Mighty Lube Monitoring', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Pre-Mounting Requirements',
            ['OPCO Track', 'Customer Provided Track', 'Other']),
        CommonWidgets.buildDropdownField('PLC Connection', ['Yes', 'No']),
        CommonWidgets.buildTextField('Other Information', otherInfo),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    //leave alone for now - Coming back to do later
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
            'Measurement Units', ['Feet', 'Inches', 'm Meter', 'mm Milimeter']),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addOPCO300(int numRequested) {
  if (validForm()) {
    dynamic opData = {
      'conveyorName': conveyorSystem.text,
      'chainSize': conveyorChainSize,
      'industrialChainManufacturer': conveyorChainManufacturer,
      'otherChainManufacturer': null,
      'wheelManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'measurementUnit': measurementUnits,
      'conveyorSpeed': conveyorSpeed.text,
      'speedUnit': null,
      'conveyorIndex': conveyorIndex.text,
      'travelDirection': null,
      'appEnviroment': null,
      'ovenStatus': null,
      'ovenTemp': null,
      'monitorData': {
        'existingMonitor': existingMonitoring,
        'newMonitor': newMonitoring,
      },
      'surrondingTemp': null,
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': null,
      'strandStatus': null,
      'plantLayout': null,
      'requiredPics': null,
      'operatingVoltage': operatingVoltage.text,
      'controlVoltage': null,
      'compressedAir': null,
      'airSupplyType': null,
      'wheelOpenType': null,
      'wheelClosedType': null,
      'openStatus': null,
      'freeWheelStatus': null,
      'guideRollerStatus': null,
      'openRaceStyle': null,
      'closedRaceStyle': null,
      'holeStatus': null,
      'rollerChainStatus': null,
      'brushStatus': null,
      'outboardStatus': null,
      'lubeBrand': equipBrand.text,
      'lubeType': lubricationType.text,
      'lubeViscosity': lubricationGrade.text,
      'currentGreaseGrade': greaseGrade.text,
      'zerkDirection': null,
      'zerkLocationType': null,
      'chainMaster': null,
      'remoteStatus': null,
      'mountStatus': null,
      'otherUnitStatus': null,
      'timerStatus': null,
      'electricStatus': null,
      'mightyLubeMonitoring': null,
      'preMountType': null,
      'plcConnection': null,
      'otherControllerInfo': otherInfo.text,
      'ibrUnitType': null,
      'ibrChainA1': null,
      'ibrChainB1': null,
      'ibrChainC1': null,
      'ibrChainD1': null,
      'ibrChainE1': null,
      'ibrChainF1': null,
      'ibrChainG1': null,
    };
    status = FormAPI().addOrder("IBR_OPCO300", opData, numRequested);
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
