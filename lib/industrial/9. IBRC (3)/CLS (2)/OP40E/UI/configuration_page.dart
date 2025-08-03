import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/9.%20IBRC%20(3)/CLS%20(2)/products.dart';
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
  int? operatingVoltage = -1;
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController chainMaster = TextEditingController();
  final TextEditingController specialOP = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();
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

  final GlobalKey<TemplateBWidgetState> templateBKey = GlobalKey();

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
    validate.validateDropdownField(conveyorChainManufacturer, 'conveyorChainManufacturer');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');

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
        CommonWidgets.buildBreadcrumbNavigation(
            context, '>', const ApplicationPage(), 'Products', const IBRCCLSProducts()),
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
              CommonWidgets.buildGradientButton(
                  context, 'New/Existing Monitoring System', buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller', buildController()),
              CommonWidgets.buildGradientButton(
                  context, 'In Board Roller Chain: Measurements', buildMeasurements()),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addOP40E(value);
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
              CommonWidgets.buildTextField('Enter Name of Conveyor System *', conveyorSystem,
                  errorText: errors['conveyorName']),
              if (errors['conveyorName'] != null) buildErrorText(errors['conveyorName']!),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
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
                    conveyorChainSize = value; // Update state properly
                    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
                  });
                },
                errorText: errors['conveyorChainSize'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Protein: Chain Manufacturer',
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
                errorText: errors['conveyorChainManufacturer'],
              ),
              CommonWidgets.buildTextField('Enter Conveyor Length', conveyorLength),
              CommonWidgets.buildDropdownField('Conveyor Length Unit', [
                'Feet',
                'Inches',
                'm Meter',
                'mm Milimeter',
              ]),
              CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max)', conveyorSpeed),
              CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
                'Feet/Minute',
                'Meters/Minute',
              ]),
              CommonWidgets.buildTextField(
                  'Enter Indexing or Variable Speed Conditions', conveyorIndex),
              CommonWidgets.buildDropdownField('Direction of Travel', [
                'Right to Left',
                'Left to Right',
              ]),
              CommonWidgets.buildDropdownField('Application Environment ', [
                'Ambient',
                'Caustic (i.e. Phosphate/E-Coast, etc.)',
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
                  'Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
                'Loaded',
                'Unloaded',
              ]),
              CommonWidgets.buildDropdownField(
                  'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side', [
                'Yes',
                'No',
              ]),
              CommonWidgets.buildDropdownField('Is Conveyor Single or Double Strand', [
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
        CommonWidgets.buildDropdownFieldError('Operating Voltage - 3 Phase: (Volts/hz)',
            ['Option 1', 'Option 2', 'Option 3'], operatingVoltage, (value) {
          setState(() {
            operatingVoltage = value;
          });
        }, errorText: errors['operatingVoltage']),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    // will probably need template B
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
            'Connecting to Existing Monitoring', ['Yes', 'No'], existingMonitoring, (value) {
          setState(() {
            existingMonitoring = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Add New Monitoring System', ['Yes', 'No'], newMonitoring, (value) {
          setState(() {
            newMonitoring = value;
          });
        }),
        CommonWidgets.buildSectionDivider(),
        if (existingMonitoring == 1) CommonWidgets.buildTemplateB(templateBKey, validate),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField(
            'Wheel: Open Race Style', ['Not Applicable', 'Open Inside', 'Open Outside ']),
        CommonWidgets.buildDropdownField('Wheel: Sealed Style', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField('Open Inside/ Shielded Outside', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Free Trolley Wheels', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Guide Rollers', ['Yes', 'No']),
        CommonWidgets.buildDropdownField(
            'Guide Rollers Open Race Style', ['Not Applicable ', 'Open Inside', 'Open Outside']),
        CommonWidgets.buildDropdownField(
            'Guide Rollers Sealed Styles', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField('Open Hole', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Dog Actuator', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Pivot Points', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('King Pin', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Outboard Wheels', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Rail Lubrication', ['Yes', 'No']),
        CommonWidgets.buildTextField('Enter Current Lubrication Equipment (Brand)', equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type', currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade', currentGrade),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Enter ChainMaster Controller', chainMaster),
        CommonWidgets.buildDropdownField('Timer', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Electric On/Off', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Pneumatic On/Off', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Mighty Lube Monitoring', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('PLC Connection', ['Yes', 'No']),
        CommonWidgets.buildTextField('Enter Other Details', optionalInfo),
        CommonWidgets.buildTextField(
            'Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
            specialOP),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    //leave alone will come back and do later
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

  VoidCallback? addOP40E(int numRequested) {
    if (validForm()) {
      dynamic opData = {
        'conveyorName': conveyorSystem.text,
        'chainSize': conveyorChainSize,
        'industrialChainManufacturer': conveyorChainManufacturer,
        'otherChainManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'measurementUnit': measurementUnits,
        'conveyorSpeed': conveyorSpeed.text,
        'speedUnit': null,
        'conveyorIndex': conveyorIndex.text,
        'travelDirection': null,
        'appEnviroment': null,
        'ovenStatus': null,
        'ovenTemp': null,
        'templateA': {
          'existingMonitor': existingMonitoring,
          'newMonitor': newMonitoring,
        },
        'surrondingTemp': null,
        'conveyorLoaded': conveyorLoaded,
        'conveyorSwing': null,
        'strandStatus': null,
        'plantLayout': null,
        'requiredPics': null,
        'operatingVoltage': operatingVoltage,
        'controlVoltage': null,
        'wheelOpenType': null,
        'wheelClosedType': null,
        'openStatus': null,
        'freeWheelStatus': null,
        'guideRollerStatus': null,
        'openRaceStyle': null,
        'closedRaceStyle': null,
        'holeStatus': null,
        'actuatorStatus': null,
        'pivotStatus': null,
        'kingPinStatus': null,
        'outboardStatus': null,
        'railLubeStatus': null,
        'lubeBrand': equipBrand.text,
        'lubeType': currentType.text,
        'lubeViscosity': currentGrade.text,
        'chainMaster': chainMaster.text,
        'timerStatus': null,
        'electricStatus': null,
        'pneumaticStatus': null,
        'mightyLubeMonitoring': null,
        'plcConnection': null,
        'otherControllerInfo': optionalInfo.text,
        'ibrUnitType': null,
        'ibrChainA1': null,
        'ibrChainB1': null,
        'ibrChainC1': null,
        'ibrChainD1': null,
        'ibrChainF1': null,
        'templateB': templateBKey.currentState?.getData(),
      };
      status = FormAPI().addOrder("IBR_OP4OE", opData, numRequested);
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
