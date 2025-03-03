import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/industrial/2.%20COEDL%20(3)/CLS%20(3)/products.dart';
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
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? existingMonitoring = -1;
  int? outboardWheels = -1;
  int? highRollers = -1;
  int? lubricationSide = -1;
  int? lubricationTop = -1;
  int? chainMasterController = -1;
  int? timer = -1;
  int? electricOnOff = -1;
  int? pneumaticOnOff = -1;
  int? mightyLubeMonitoring = -1;
  int? plcConnection = -1;
  int? measurementUnits = -1;
  int? conveyorSpeedUnit = -1;
  int? conveyorLengthUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? temperatureOfSurroundingArea = -1;
  int? conveyorSingleDouble = -1;

  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
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

  Future<void> _validateForm() async{
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
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
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
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
    operatingVoltage.removeListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
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
      'chainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
      'conveyorIndex',
    ],
    "Customer Power Utilities": [
      'operatingVoltage',
    ],
    "New/Existing Monitoring System": [
      'existingMonitoring',
    ],
    "Conveyor Specifications": [
      'outboardWheels',
      'highRollers',
      'equipBrand',
      'currentType',
      'currentGrade',
      'lubricationSide',
      'lubricationTop',
    ],
    "Controller": [
      'chainMasterController',
      'timer',
      'electricOnOff',
      'pneumaticOnOff',
      'mightyLubeMonitoring',
      'plcConnection',
      'otherInfo',
      'specialOptions',
    ],
    "Chain on Edge Drag Line: Measurements": [
      'measurementUnits',
    ],
  };


  //currentGrade

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const ProductsCOEDL()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent(), isError: validate.sectionError('General Information')),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent(), isError: validate.sectionError('Customer Power Utilities')),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem(), isError: validate.sectionError('New/Existing Monitoring System')),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications(), isError: validate.sectionError('Conveyor Specifications')),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController(), isError: validate.sectionError('Controller')),
              CommonWidgets.buildGradientButton(context, 'Chain on Edge Drag Line: Measurements',buildMeasurements(), isError: validate.sectionError('Chain on Edge Drag Line: Measurements')),
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
              CommonWidgets.buildTextField(
                  'Name of Conveyor System *', conveyorSystem,
                  errorText: errors['conveyorName']),
              if (errors['conveyorName'] != null)
                buildErrorText(errors['conveyorName']!),
              CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildDropdownFieldError('Conveyor Chain Size', [
          'CC5 3”',
          'CC5 4”',
          'CC5 6”',
          'RC60', 'RC80', 'RC 2080', 'RC 2060',
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
        CommonWidgets.buildDropdownFieldError('Chain Manufacturer', [
          'Daifuku',
          'Frost',
          'NKC',
          'Pacline',
          'Rapid',
          'WEBB',
          'Webb-Stiles',
          'Wilkie Brothers',
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
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength, errorText: errors['conveyorLength']),
        CommonWidgets.buildDropdownFieldError('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter',
        ], conveyorLengthUnit, (value) {
          setState(() {
            conveyorLengthUnit = value; // Update state properly
          });
        }),
        CommonWidgets.buildTextField('Conveyor Speed (Min/Max)',conveyorSpeed, errorText: errors['conveyorSpeed']),
        CommonWidgets.buildDropdownFieldError('Conveyor Speed Unit', [
          'Feet/Minute',
          'Meters/Minute',
        ], conveyorSpeedUnit, (value) {
          setState(() {
            conveyorSpeedUnit = value; // Update state properly
          });
        }),
        CommonWidgets.buildTextField('Indexing or Variable Speed Conditions',conveyorIndex, errorText: errors['conveyorIndex']),
        CommonWidgets.buildDropdownFieldError('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ], directionOfTravel, (value) {
          setState(() {
            directionOfTravel = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phospate/E-Coat, etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic','Food Grade', 'Other'
        ], applicationEnvironment, (value) {
          setState(() {
            applicationEnvironment = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No',
        ], temperatureOfSurroundingArea, (value) {
          setState(() {
            temperatureOfSurroundingArea = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Is Conveyor Single or Double Strand', [
          'Single',
          'Double',
        ], conveyorSingleDouble, (value) {
          setState(() {
            conveyorSingleDouble = value; // Update state properly
          });
        }),
        CommonWidgets.buildSectionDivider(),
        
      
      ],
    );
  });
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: operatingVoltage,
        builder: (context, value, child) {
          validate.validatorDelay(value.text, 'operatingVoltage');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildTextField(
                  'Operating Voltage - 3 Phase: (Volts/hz] *',
                  operatingVoltage,
                  errorText: errors['operatingVoltage']),
              if (errors['operatingVoltage'] != null)
                buildErrorText(errors['operatingVoltage']!),
              CommonWidgets.buildSectionDivider(),
            ],
          );
        });
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ], existingMonitoring,
            (value) {
          setState(() {
            existingMonitoring = value; // Update state properly
            validate.validateDropdownField(
                existingMonitoring, 'existingMonitoring');
          });
        }, errorText: errors['existingMonitoring']),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Outboard Wheels', [
          'Yes',
          'No'
        ], outboardWheels,
            (value) {
          setState(() {
            outboardWheels = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('High Rollers', [
          'Yes',
          'No'
        ], highRollers,
            (value) {
          setState(() {
            highRollers = value; // Update state properly
          });
        }),
        
        CommonWidgets.buildTextField('Enter Rail Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade',currentGrade),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ], lubricationSide,
            (value) {
          setState(() {
            lubricationSide = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ], lubricationTop,
            (value) {
          setState(() {
            lubricationTop = value; // Update state properly
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
        CommonWidgets.buildDropdownFieldError('ChainMaster Contoller', [
          'Yes',
          'No'
        ], chainMasterController,
            (value) {
          setState(() {
            chainMasterController = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Timer', [
          'Not Required',
          '12 Hour', 
          '1000 Hour'
        ], timer,
            (value) {
          setState(() {
            timer = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Electric On/Off', [
          'On',
          'Off'
        ], electricOnOff,
            (value) {
          setState(() {
            electricOnOff = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Pneumatic On/Off', [
          'On',
          'Off'
        ], pneumaticOnOff,
            (value) {
          setState(() {
            pneumaticOnOff = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ], mightyLubeMonitoring,
            (value) {
          setState(() {
            mightyLubeMonitoring = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('PLC Connection', [
          'Yes',
          'No'
        ], plcConnection,
            (value) {
          setState(() {
            plcConnection = value; // Update state properly
          });
        }),
        CommonWidgets.buildTextField('Enter Other Information',otherInfo),
        CommonWidgets.buildTextField('Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify) ',specialOptions),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ], measurementUnits,
            (value) {
          setState(() {
            measurementUnits = value; // Update state properly
          });
        }),
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

VoidCallback? addOP40E(int numRequested) {
    if (validForm()) {
      dynamic opData = {
        'conveyorSystem': conveyorSystem.text,
        'conveyorChainSize': conveyorChainSize,
        'chainManufacturer': chainManufacturer,
        'conveyorLength': conveyorLength.text,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorIndex': conveyorIndex.text,
        'operatingVoltage': operatingVoltage.text,
        'existingMonitoring': existingMonitoring,
        'outboardWheels': outboardWheels,
        'highRollers': highRollers,
        'equipBrand': equipBrand.text,
        'currentType': currentType.text,
        'currentGrade': currentGrade.text,
        'lubricationSide': lubricationSide,
        'lubricationTop': lubricationTop,
        'chainMasterController': chainMasterController,
        'timer': timer,
        'electricOnOff': electricOnOff,
        'pneumaticOnOff': pneumaticOnOff,
        'mightyLubeMonitoring': mightyLubeMonitoring,
        'plcConnection': plcConnection,
        'otherInfo': otherInfo.text,
        'specialOptions': specialOptions.text,
        'measurementUnits': measurementUnits,
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

}
