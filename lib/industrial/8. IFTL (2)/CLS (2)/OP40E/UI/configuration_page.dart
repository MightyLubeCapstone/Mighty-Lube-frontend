import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/8.%20IFTL%20(2)/CLS%20(2)/products.dart';
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
  int? chainManufacturer = -1;
  int? installationClearance = -1;
  int? dripLine = -1;
  int? monitoringSystem = -1;
  int? newMonitoringSystem = -1;
  int? driveMotorAmp = -1;
  int? driveTakeUpAir = -1;
  int? takeUpDistance = -1;
  int? driveMotorTemp = -1;
  int? driveMotorVibration = -1;
  int? bentOrMissingTrolley = -1;
  int? lubricationFromSide = -1;
  int? lubricationFromTop = -1;
  int? conveyorChainClean = -1;
  int? measurementUnits = -1;
  int? pushButtonSwitch = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? strandStatus = -1;
  int? plantLayout = -1;
  int? requiredPics = -1;
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
  int? outboardStatus = -1;
  int? railLubrication = -1;
 

  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'conveyorIndex': null,
    'operatingVoltage': null,
    'conductor4': null,
    'conductor7': null,
    'conductor2': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'installationClearance': null,
    'dripLine': null,
  };

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
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(conductor4.text, 'conductor4');
    validate.validateTextField(conductor7.text, 'conductor7');
    validate.validateTextField(conductor2.text, 'conductor2');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(
        installationClearance, 'installationClearance');
    validate.validateDropdownField(dripLine, 'dripLine');

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
    conductor7.addListener(() {
      validate.onNum247Changed(conductor7.text, 'con7');
      setState(() {});
    });
    conductor4.addListener(() {
      validate.onNum247Changed(conductor4.text, 'con4');
      setState(() {});
    });
    conductor2.addListener(() {
      validate.onNum247Changed(conductor2.text, 'con2');
      setState(() {});
    });
  }

  @override
  void dispose() {
    conveyorSystem.removeListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorName');
      setState(() {});
    });
    conductor7.removeListener(() {
      validate.onNum247Changed(conductor7.text, 'con7');
      setState(() {});
    });
    conductor4.removeListener(() {
      validate.onNum247Changed(conductor4.text, 'con4');
      setState(() {});
    });
    conductor2.removeListener(() {
      validate.onNum247Changed(conductor2.text, 'con2');
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
    "General Information": [
      'conveyorSystem',
      'conveyorLength',
      'conveyorSpeed',
      'conveyorIndex',
      'conveyorChainSize',
      'chainManufacturer',
      'installationClearance',
      'dripLine',
    ],
    "Customer Power Utilities": [
      'operatingVoltage',
      'conductor4',
      'conductor7',
      'conductor2',
    ],
    "New/Existing Monitoring System": [
      'monitoringSystem',
      'newMonitoringSystem',
      'driveMotorAmp',
      'driveTakeUpAir',
      'takeUpDistance',
      'driveMotorTemp',
      'driveMotorVibration',
      'bentOrMissingTrolley',
    ],
    "Conveyor Specifications": [
      'lubricationFromSide',
      'lubricationFromTop',
      'conveyorChainClean',
    ],
    "Controller": [
      'measurementUnits',
      'conductor4',
      'conductor7',
      'conductor2',
    ],
    "Wire": [
      'measurementUnits',
      'conductor4',
      'conductor7',
      'conductor2',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const IFTLProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent(),
                  isError: validate.sectionError("General Information")),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent(),
                  isError: validate.sectionError("Customer Power Utilities")),
              CommonWidgets.buildGradientButton(context,
                  'New/Existing Monitoring System', buildNewMonitoringSystem(),
                  isError:
                      validate.sectionError("New/Existing Monitoring System")),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError("Conveyor Specifications")),
              CommonWidgets.buildGradientButton(
                  context, 'Controller', buildController()),
              CommonWidgets.buildGradientButton(context,
                  'In Floor Towline: Measurements', buildMeasurements()),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField(
            'Enter Name of Conveyor System', conveyorSystem),
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
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value; // Update state properly
              validate.validateDropdownField(
                  chainManufacturer, 'chainManufacturer');
            });
          },
          errorText: errors['chainManufacturer'],
        ),
        CommonWidgets.buildTextField('Enter Conveyor Length', conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Milimeter',
        ]),
        CommonWidgets.buildTextField(
            'Enter Conveyor Speed (Min/Max)', conveyorSpeed),
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
        CommonWidgets.buildDropdownField(
            'Is Conveyor Single or Double Strand', [
          'Single',
          'Double',
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
          'Operating Voltage - 3 Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
        ),
        if (errors['operatingVoltage'] != null)
          buildErrorText(errors['operatingVoltage']!),
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
        CommonWidgets.buildDropdownField('Wheel: Open Race Style',
            ['Not Applicable', 'Open Inside', 'Open Outside ']),
        CommonWidgets.buildDropdownField(
            'Wheel: Sealed Style', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField(
            'Open Inside/ Shielded Outside', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Free Trolley Wheels', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Guide Rollers', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Guide Rollers Open Race Style',
            ['Not Applicable ', 'Open Inside', 'Open Outside']),
        CommonWidgets.buildDropdownField(
            'Guide Rollers Sealed Styles', ['Extended', 'Flush', 'Recessed']),
        CommonWidgets.buildDropdownField('Open Hole', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Dog Actuator', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Pivot Points', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('King Pin', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Outboard Wheels', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Rail Lubrication', ['Yes', 'No']),
        CommonWidgets.buildTextField(
            'Enter Current Lubrication Equipment (Brand)', equipBrand),
        CommonWidgets.buildTextField(
            'Enter Current Lubricant Type', currentType),
        CommonWidgets.buildTextField(
            'Enter Current Lubricant Viscosity/Grade', currentGrade),
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
            'Enter ChainMaster Controller', chainMaster),
        CommonWidgets.buildDropdownField('Timer', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Electric On/Off', ['Yes', 'No']),
        CommonWidgets.buildDropdownField('Pneumatic On/Off', ['Yes', 'No']),
        CommonWidgets.buildDropdownField(
            'Mighty Lube Monitoring', ['Yes', 'No']),
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
      'industrialChainManufacturer': chainManufacturer,
      'otherChainManufacturer': null,
      'wheelManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'measurementUnit': measurementUnits,
      'conveyorSpeed': conveyorSpeed.text,
      'speedUnit': conveyorSpeedUnit,
      'conveyorIndex': conveyorIndex.text,
      'travelDirection': directionOfTravel,
      'appEnviroment': applicationEnvironment,
      'ovenStatus': null,
      'ovenTemp': null,
      'monitorData': {
        'existingMonitor': null,
        'newMonitor': null,
      },
      'surroundingTemp': null,
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': conveyorSwing,
      'strandStatus': null,
      'plantLayout': null,
      'requiredPics': null,
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
      'outboardStatus': null,
      'railLubeStatus': railLubrication,
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
      'iftUnitType': null,
      'iftPowerA': null,
      'iftPowerB': null,
      'iftPowerG': null,
      'iftPowerH': null,
      'iftPowerJ': null,
      'iftPowerS1': null,
      'iftPowerT1': null,
      'iftPowerU1': null,
      'iftPowerV1': null,
      'iftPowerW1': null,
      'iftPowerX1': null,
    };
    status = FormAPI().addOrder("IFT_OP4OE", opData, numRequested);
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
