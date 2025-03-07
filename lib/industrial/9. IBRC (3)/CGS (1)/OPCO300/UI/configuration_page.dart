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
  final Validators validate = Validators();
  Future<bool>? status;
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  int? operatingVoltage = -1;
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
    validate.validateDropdownField(conveyorChainManufacturer, 'conveyorChainManufacturer');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
    
    setState(() {
    });
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
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const IBRCProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent(), isError: validate.sectionError("general"),),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent(), isError: validate.sectionError("custom"),),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildMonitoringFeatures()),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire()),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value){
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
        CommonWidgets.buildDropdownFieldError('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          'Other'
        ], conveyorChainSize,
                (value) {
                  setState(() {
                    conveyorChainSize = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorChainSize, 'conveyorChainSize');
                  });
                },
                errorText: errors['conveyorChainSize'],
              ),
        CommonWidgets.buildDropdownFieldError('Protein: Chain Manufacturer', [
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
        ], conveyorChainManufacturer,
                (value) {
                  setState(() {
                    conveyorChainManufacturer = value; // Update state properly
                  });
                }),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Environmental Details'),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor "__" at Planned Install Location',
            ['Loaded', 'Unloaded'], conveyorLoaded, (value) {
          setState(() {
            conveyorLoaded = value;
          });
          }),
        CommonWidgets.buildDropdownFieldError('Is this a Drip Line', ['Yes', 'No'], dripLine,
            (value) {
          setState(() {
            dripLine = value;
          });
        }),
      ],
    );
    
        });
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError('Operating Voltage - 3 Phase: (Volts/hz)',
            ['Option 1', 'Option 2', 'Option 3'], 
            operatingVoltage, (value) {
          setState(() {
            operatingVoltage = value;
          });
          }),
        CommonWidgets.buildDropdownFieldError(
          'Confirm Installation Clearance of: Minimum of 2\' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'], installationClearance, (value) {
          setState(() {
            installationClearance = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('3-Station Push Button Switch', ['Yes', 'No'],
            pushButtonSwitch, (value) {
          setState(() {
            pushButtonSwitch = value;
          });
          }),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildDropdownField('Add New Monitoring System', [
          'Yes',
          'No'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Drive Motor Amp', [
          'Yes',
          'No'
        ], driveMotorAmp, (value) {
          setState(() {
            driveMotorAmp = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Take-up-Air', [
          'Yes',
          'No'
        ], driveTakeUpAir, (value) {
          setState(() {
            driveTakeUpAir = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Take-Up Distance', [
          'Yes',
          'No'
        ], takeUpDistance, (value) {
          setState(() {
            takeUpDistance = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Temp', [
          'Yes',
          'No'
        ], driveMotorTemp, (value) {
          setState(() {
            driveMotorTemp = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Vibration', [
          'Yes',
          'No'
        ], driveMotorVibration, (value) {
          setState(() {
            driveMotorVibration = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Bent or Missing Trolley detect', [
          'Yes',
          'No'
        ], bentOrMissingTrolley, (value) {
          setState(() {
            bentOrMissingTrolley = value;
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ], lubricationSideChain, (value) {
          setState(() {
            lubricationSideChain = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ], lubricationTopChain, (value) {
          setState(() {
            lubricationTopChain = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ], chainClean, (value) {
          setState(() {
            chainClean = value;
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
  
  Widget buildController() {
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
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
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
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addOPCO300(int numRequested) {
    if (validForm()) {
      dynamic opData = {
        'conveyorSystem': conveyorSystem.text,
        'conveyorChainSize': conveyorChainSize,
        'conveyorChainManufacturer': conveyorChainManufacturer,
        'conveyorLength': conveyorLength.text,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorIndex': conveyorIndex.text,
        'operatingVoltage': operatingVoltage,
        'conductor4': conductor4.text,
        'conductor7': conductor7.text,
        'conductor2': conductor2.text,
        'conveyorLoaded': conveyorLoaded,
        'dripLine': dripLine,
        'installationClearance': installationClearance,
        'pushButtonSwitch': pushButtonSwitch,
        'existingMonitoring': existingMonitoring,
        'newMonitoring': newMonitoring,
        'driveMotorAmp': driveMotorAmp,
        'driveTakeUpAir': driveTakeUpAir,
        'takeUpDistance': takeUpDistance,
        'driveMotorTemp': driveMotorTemp,
        'driveMotorVibration': driveMotorVibration,
        'bentOrMissingTrolley': bentOrMissingTrolley,
        'lubricationSideChain': lubricationSideChain,
        'lubricationTopChain': lubricationTopChain,
        'chainClean': chainClean,
        'measurementUnits': measurementUnits,
      };
      status = FormAPI().addOrder('opco300', opData, numRequested);
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