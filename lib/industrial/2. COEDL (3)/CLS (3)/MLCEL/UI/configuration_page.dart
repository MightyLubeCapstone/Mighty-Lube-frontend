import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/2.%20COEDL%20(3)/CLS%20(3)/products.dart';
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
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController jBox = TextEditingController();
  final TextEditingController conductor12 = TextEditingController();
  int? conveyorChainSize = -1;
  int? conveyorChainManufacturer = -1;
  int? existingMonitoring = -1;
  int? wheelOpenRace = -1;
  int? wheelSealedStyle = -1;
  int? openInsideShielded = -1;
  int? openOutsideShielded = -1;
  int? railLubrication = -1;
  int? externalLubrication = -1;
  int? reservoirSize = -1;
  int? chainClean = -1;
  int? measurementUnits = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;
  int? conveyorDirection = -1;
  int? conveyorEnvironment = -1;
  int? conveyorTemperature = -1;
  int? conveyorStrand = -1;


  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'conveyorManufacturer': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'existingMonitoring': null
  };

  bool validForm() {
    validate.mapErrors(errors);
    validate.mapSections(sections);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async{
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');

    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(conveyorChainManufacturer, 'conveyorChainManufacturer');
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
    'General Information': [
      'conveyorSystem',
      'conveyorChainSize',
      'conveyorChainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
      'conveyorIndex',
      'conveyorDirection',
      'conveyorEnvironment',
      'conveyorTemperature',
      'conveyorStrand',
    ],
    'Customer Power Utilities': [
      'operatingVoltage',
    ],
    'New/Existing Monitoring System': [
      'existingMonitoring',
    ],
    'Conveyor Specifications': [
      'wheelOpenRace',
      'wheelSealedStyle',
      'openInsideShielded',
      'openOutsideShielded',
      'railLubrication',
      'externalLubrication',
      'equipBrand',
      'currentType',
      'currentGrade',
      'reservoirSize',
      'chainClean',
    ],
    'Controller': [
      'specialOptions',
    ],
    'Wire': [
      'measurementUnits',
      'conductor2',
      'conductor4',
      'conductor7',
      'conductor12',
      'jBox',
    ],
    'Chain on Edge Drag Line: Measurements': [
      'measurementUnits',
    ],
  };


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
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire(), isError: validate.sectionError('Wire')),
              CommonWidgets.buildGradientButton(context, 'Chain on Edge Drag Line: Measurements',buildMeasurements(), isError: validate.sectionError('Chain on Edge Drag Line: Measurements')),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addMLCEL(value);
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
        CommonWidgets.buildTextField('Name of Conveyor System',conveyorSystem, errorText: errors['conveyorSystem']),
        if (errors['conveyorName'] != null)
                buildErrorText(errors['conveyorName']!),
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
        ], conveyorChainManufacturer,
                (value) {
                  setState(() {
                    conveyorChainManufacturer = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorChainManufacturer, 'conveyorChainManufacturer');
                  });
                },
                errorText: errors['conveyorChainManufacturer'],
              ),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength, errorText: errors['conveyorLength']),
        CommonWidgets.buildDropdownFieldError('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter',
        ],conveyorLengthUnit, (value) {
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
        ], conveyorDirection, (value) {
          setState(() {
            conveyorDirection = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phospate/E-Coat, etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic','Food Grade', 'Other'
        ], conveyorEnvironment, (value) {
          setState(() {
            conveyorEnvironment = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No',
        ], conveyorTemperature, (value) {
          setState(() {
            conveyorTemperature = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Is Conveyor Single or Double Strand', [
          'Single',
          'Double',
        ], conveyorStrand, (value) {
          setState(() {
            conveyorStrand = value; // Update state properly
          });
        }),
        CommonWidgets.buildSectionDivider(),
        
      ],
    );
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
                  'Operating Voltage - Single Phase: (Volts/hz] *',
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
                },
                errorText: errors['existingMonitoring'],
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
        CommonWidgets.buildDropdownFieldError('Wheel: Open Race Style', [
          'Not Apolicable',
          'Open Inside',
          'Open Outside'
        ], wheelOpenRace, (value) {
          setState(() {
            wheelOpenRace = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Wheel Sealed Style', [
          'Extended',
          'Flush',
          'Recessed'
        ], wheelSealedStyle, (value) {
          setState(() {
            wheelSealedStyle = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Open Inside / Shielded Outside', [
          'Yes',
          'No'
        ], openInsideShielded, (value) {
          setState(() {
            openInsideShielded = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Open Inside / Shielded Outside', [
          'Yes',
          'No'
        ], openOutsideShielded, (value) {
          setState(() {
            openOutsideShielded = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Rail Lubrication', [
          'Yes',
          'No'
        ], railLubrication, (value) {
          setState(() {
            railLubrication = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('External Lubricaiton', [
          'Yes',
          'No'
        ], externalLubrication, (value) {
          setState(() {
            externalLubrication = value; // Update state properly
          });
        }),
        CommonWidgets.buildTextField('Current Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Current Lubricant Viscosity/Grade',currentGrade),

        CommonWidgets.buildDropdownFieldError('Reservior Size', [
          '10 Gallon',
          '65 Gallon'
        ], reservoirSize, (value) {
          setState(() {
            reservoirSize = value; // Update state properly
          });
        }),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ], chainClean, (value) {
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
        CommonWidgets.buildTextField('Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify) ',specialOptions),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ], measurementUnits,(value) {
          setState(() {
            measurementUnits = value; // Update state properly
          });
        }),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 12 Conductor Number Here',conductor12),
        CommonWidgets.buildTextField('Enter Junction Box Quantities',jBox),
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
        ], measurementUnits,(value) {
          setState(() {
            measurementUnits = value; // Update state properly
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addMLCEL(int numRequested) {
    if (validForm()) {
      dynamic mlcelData= {
        "conveyorChainSize": conveyorChainSize,
        "conveyorLength": conveyorLength.text,
        "conveyorSpeed": conveyorSpeed.text,
        "conveyorIndex": conveyorIndex.text,
        "operatingVoltage": operatingVoltage.text,
        "conductor4": conductor4.text,
        "conductor7": conductor7.text,
        "conductor2": conductor2.text,
        "equipBrand": equipBrand.text,
        "currentType": currentType.text,
        "currentGrade": currentGrade.text,
        "specialOptions": specialOptions.text,
        "jBox": jBox.text,
        "conductor12": conductor12.text,
        "conveyorChainManufacturer": conveyorChainManufacturer,
        "existingMonitoring": existingMonitoring,
        "conveyorSystem": conveyorSystem.text,
        "conveyorDirection": conveyorDirection,
        "conveyorEnvironment": conveyorEnvironment,
        "conveyorTemperature": conveyorTemperature,
        "conveyorStrand": conveyorStrand,
        "wheelOpenRace": wheelOpenRace,
        "wheelSealedStyle": wheelSealedStyle,
        "openInsideShielded": openInsideShielded,
        "openOutsideShielded": openOutsideShielded,
        "railLubrication": railLubrication,
        "externalLubrication": externalLubrication,
        "reservoirSize": reservoirSize,
        "chainClean": chainClean,
        "measurementUnits": measurementUnits,
        "conveyorLengthUnit": conveyorLengthUnit,
        "conveyorSpeedUnit": conveyorSpeedUnit,
      };
      //add a loader that shows a happy popup for this eventually :)
      status = FormAPI().addOrder("mlcel", mlcelData, numRequested);
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

