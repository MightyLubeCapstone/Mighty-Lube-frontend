import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/industrial/2. 9125CD (3)/CLS (3)/products.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final Validators validate = Validators();
  bool? status;

  // Text Controllers
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController conductorNumber4 = TextEditingController();
  final TextEditingController conductorNumber7 = TextEditingController();
  final TextEditingController conductorNumber2 = TextEditingController();
  final TextEditingController wireConductorNumber4 = TextEditingController();
  final TextEditingController wireConductorNumber7 = TextEditingController();
  final TextEditingController wireConductorNumber2 = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

  // Dropdown Values
  int? operatingVoltage = -1;
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
    'operatingVoltage': null,
    'existingMonitoring': null,
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
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
    validate.validateDropdownField(existingMonitoring, 'existingMonitoring');

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
    super.dispose();
  }

  final Map<String, List<String>> sections = {
    "General Information": [
      'conveyorSystem',
      'conveyorChainSize',
      'conveyorChainManufacturer',
      'conveyorLength',
      'conveyorSpeed'
    ],
    "Customer Power Utilities": ['operatingVoltage'],
    "New/Existing Monitoring System": ['existingMonitoring'],
    "Conveyor Specifications": ['conveyorLoaded', 'dripLine'],
    "Controller": ['pushButtonSwitch'],
    "Wire": ['conductorNumber4', 'conductorNumber7', 'conductorNumber2'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
            context, '>', const ApplicationPage(), 'Products', const ProductsCOEDL()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                  context, 'General Information', buildGeneralInformationContent(),
                  isError: validate.sectionError('General Information')),
              CommonWidgets.buildGradientButton(
                  context, 'Customer Power Utilities', buildCustomerPowerUtilitiesContent(),
                  isError: validate.sectionError('Customer Power Utilities')),
              CommonWidgets.buildGradientButton(
                  context, 'New/Existing Monitoring System', buildMonitoringFeatures(),
                  isError: validate.sectionError('New/Existing Monitoring System')),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError('Conveyor Specifications')),
              CommonWidgets.buildGradientButton(context, 'Controller', buildController(),
                  isError: validate.sectionError('Controller')),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire(),
                  isError: validate.sectionError('Wire')),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addCDL(value);
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
              CommonWidgets.buildTextField('Name of Conveyor System *', conveyorSystem,
                  errorText: errors['conveyorName']),
              if (errors['conveyorName'] != null) buildErrorText(errors['conveyorName']!),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Chain Size',
                ['X348 Chain (3”)', 'X458 Chain (4”)', 'OX678 Chain (6”)', 'Other'],
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
                'Chain Manufacturer',
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
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Environmental Details'),
              CommonWidgets.buildDropdownFieldError(
                  'Is the Conveyor "__" at Planned Install Location',
                  ['Loaded', 'Unloaded'],
                  conveyorLoaded, (value) {
                setState(() {
                  conveyorLoaded = value; // Update state properly
                  validate.validateDropdownField(conveyorLoaded, 'conveyorLoaded');
                });
              }, errorText: errors['conveyorLoaded']),
              CommonWidgets.buildDropdownFieldError('Is this a Drip Line', ['Yes', 'No'], dripLine,
                  (value) {
                setState(() {
                  dripLine = value; // Update state properly
                  validate.validateDropdownField(dripLine, 'dripLine');
                });
              }, errorText: errors['dripLine']),
            ],
          );
        });
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError('Operating Voltage - 3 Phase: (Volts/hz)',
            ['Option 1', 'Option 2', 'Option 3'], operatingVoltage, (value) {
          setState(() {
            operatingVoltage = value; // Update state properly
            validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
          });
        }, errorText: errors['operatingVoltage']),
        CommonWidgets.buildDropdownFieldError(
          'Confirm Installation Clearance of: Minimum of 2\' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'],
          installationClearance,
          (value) {
            setState(() {
              installationClearance = value; // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
            '3-Station Push Button Switch', ['Yes', 'No'], pushButtonSwitch, (value) {
          setState(() {
            pushButtonSwitch = value; // Update state properly
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
        CommonWidgets.buildDropdownFieldError(
            'Connecting to Existing Monitoring', ['Yes', 'No'], existingMonitoring, (value) {
          setState(() {
            existingMonitoring = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Add New Monitoring System', ['Yes', 'No'], newMonitoring, (value) {
          setState(() {
            newMonitoring = value; // Update state properly
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Drive Motor Amp', ['Yes', 'No'], driveMotorAmp,
            (value) {
          setState(() {
            driveMotorAmp = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Take-up-Air', ['Yes', 'No'], driveTakeUpAir,
            (value) {
          setState(() {
            driveTakeUpAir = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Take-Up Distance', ['Yes', 'No'], takeUpDistance,
            (value) {
          setState(() {
            takeUpDistance = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Temp', ['Yes', 'No'], driveMotorTemp,
            (value) {
          setState(() {
            driveMotorTemp = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Drive Motor Vibration', ['Yes', 'No'], driveMotorVibration, (value) {
          setState(() {
            driveMotorVibration = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Bent or Missing Trolley detect', ['Yes', 'No'], bentOrMissingTrolley, (value) {
          setState(() {
            bentOrMissingTrolley = value; // Update state properly
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
            'Lubrication from the Side of Chain', ['Yes', 'No'], lubricationSideChain, (value) {
          setState(() {
            lubricationSideChain = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Lubrication from the Top of Chain', ['Yes', 'No'], lubricationTopChain, (value) {
          setState(() {
            lubricationTopChain = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Is the Conveyor Chain Clean?', ['Yes', 'No'], chainClean, (value) {
          setState(() {
            chainClean = value; // Update state properly
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
        CommonWidgets.buildDropdownField(
            'Measurement Units', ['Feet', 'Inches', 'm Meter', 'mm Milimeter']),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here', conductor2),
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
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
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

  Future<VoidCallback?> addCDL(int numRequested) async {
    if (validForm()) {
      dynamic cdlData = {
        'conveyorName': conveyorSystem.text,
        'chainSize': conveyorChainSize,
        'ovenStatus': null,
        'ovenTemp': null,
        'controlVoltSingle': operatingVoltage,
      };
      status = await FormAPI().addOrder("COE_CDL", cdlData, numRequested);
      if (!mounted) {
        return Future(
          () {
            return null;
          },
        );
      }
      if (status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully added to configurator!')),
        );
        // To add the line below, we would have to update 2-3 files in about 6 places so leaving it for now.
        // widget.updateCartItemCount(numRequested);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding to configurator!')),
        );
      }
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
    }
    return null;
  }
}
