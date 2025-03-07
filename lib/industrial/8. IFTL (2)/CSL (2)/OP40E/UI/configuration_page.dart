import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/8.%20IFTL%20(2)/CSL%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


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
  int? operatingVoltage = -1;
  int? pushButtonSwitch = -1;

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
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
    validate.validateTextField(conductor4.text, 'conductor4');
    validate.validateTextField(conductor7.text, 'conductor7');
    validate.validateTextField(conductor2.text, 'conductor2');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(installationClearance, 'installationClearance');
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
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const IFTLProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent(), isError: validate.sectionError("General Information")),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent(), isError: validate.sectionError("Customer Power Utilities")),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildMonitoringFeatures(), isError: validate.sectionError("New/Existing Monitoring System")),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications(), isError: validate.sectionError("Conveyor Specifications")),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController()),
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire()),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value){
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
        ], chainManufacturer,
                (value) {
                  setState(() {
                    chainManufacturer = value; // Update state properly
                    validate.validateDropdownField(
                        chainManufacturer, 'chainManufacturer');
                  });
                },
                errorText: errors['chainManufacturer'],
              ),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Environmental Details'),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor "__" at Planned Install Location',
            ['Loaded', 'Unloaded'], installationClearance,
                (value) {
                  setState(() {
                    installationClearance = value; // Update state properly
                    validate.validateDropdownField(
                        installationClearance, 'installationClearance');
                  });
                },
                errorText: errors['installationClearance'],
              ),
        CommonWidgets.buildDropdownFieldError('Is this a Drip Line', ['Yes', 'No'], dripLine, (value) {
            setState(() {
              dripLine = (value); // Update state properly
            });
          },),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError('Operating Voltage - 3 Phase: (Volts/hz)',
            ['Option 1', 'Option 2', 'Option 3'], operatingVoltage, 
            (value) {
              setState(() {
                operatingVoltage = (value);
                validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
              });
          },
          errorText: errors['operatingVoltage'],),
        CommonWidgets.buildDropdownFieldError(
          'Confirm Installation Clearance of: Minimum of 2\' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'], installationClearance, (value) {
            setState(() {
              installationClearance = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('3-Station Push Button Switch', ['Yes', 'No'], pushButtonSwitch, (value) {
            setState(() {
              pushButtonSwitch = (value); // Update state properly
            });
          },
        ),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ], monitoringSystem, (value) {
            setState(() {
              monitoringSystem = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Add New Monitoring System', [
          'Yes',
          'No'
        ], newMonitoringSystem, (value) {
            setState(() {
              newMonitoringSystem = (value); // Update state properly
            });
          },
        ),
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
              driveMotorAmp = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Drive Take-up-Air', [
          'Yes',
          'No'
        ], driveTakeUpAir, (value) {
            setState(() {
              driveTakeUpAir = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Take-Up Distance', [
          'Yes',
          'No'
        ], takeUpDistance, (value) {
            setState(() {
              takeUpDistance = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Drive Motor Temp', [
          'Yes',
          'No'
        ], driveMotorTemp, (value) {
            setState(() {
              driveMotorTemp = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Drive Motor Vibration', [
          'Yes',
          'No'
        ], driveMotorVibration, (value) {
            setState(() {
              driveMotorVibration = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Bent or Missing Trolley detect', [
          'Yes',
          'No'
        ], bentOrMissingTrolley, (value) {
            setState(() {
              bentOrMissingTrolley = (value); // Update state properly
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
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ], lubricationFromSide, (value) {
            setState(() {
              lubricationFromSide = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ], lubricationFromTop, (value) {
            setState(() {
              lubricationFromTop = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ], conveyorChainClean, (value) {
            setState(() {
              conveyorChainClean = (value); // Update state properly
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

  VoidCallback? addOP40E(int numRequested) {
    if (validForm()) {
      dynamic opData = {
        'conveyorSystem': conveyorSystem.text,
        'conveyorLength': conveyorLength.text,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorIndex': conveyorIndex.text,
        'conveyorChainSize': conveyorChainSize,
        'chainManufacturer': chainManufacturer,
        'installationClearance': installationClearance,
        'dripLine': dripLine,
        'operatingVoltage': operatingVoltage,
        'conductor4': conductor4.text,
        'conductor7': conductor7.text,
        'conductor2': conductor2.text,
        'monitoringSystem': monitoringSystem,
        'newMonitoringSystem': newMonitoringSystem,
        'driveMotorAmp': driveMotorAmp,
        'driveTakeUpAir': driveTakeUpAir,
        'takeUpDistance': takeUpDistance,
        'driveMotorTemp': driveMotorTemp,
        'driveMotorVibration': driveMotorVibration,
        'bentOrMissingTrolley': bentOrMissingTrolley,
        'lubricationFromSide': lubricationFromSide,
        'lubricationFromTop': lubricationFromTop,
        'conveyorChainClean': conveyorChainClean,
        'measurementUnits': measurementUnits,
        'pushButtonSwitch': pushButtonSwitch,
      };
      status = FormAPI().addOrder("op40e", opData, numRequested);
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
