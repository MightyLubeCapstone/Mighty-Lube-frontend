import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/1.%20CC5C%20(2)/CLS%20(2)/products.dart';
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
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  final TextEditingController conveyorLength = TextEditingController();
  int? conveyorLengthUnit = -1;
  final TextEditingController conveyorSpeed = TextEditingController();
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? temperature = -1;
  int? singleOrDoubleStrand = -1;
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  int? existingMonitoring = -1;
  int? outboardWheels = -1;
  int? highRollers = -1;
  int? lubricationSideChain = -1;
  int? lubricationTopChain = -1;
  int? chainMasterController = -1;
  int? timer = -1;
  int? electricOnOff = -1;
  int? pneumaticOnOff = -1;
  int? mightyLubeMonitoring = -1;
  int? plcConnection = -1;
  int? measurementUnits = -1;

  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'conveyorIndex': null,
    'operatingVoltage': null,
    'otherInfo': null,
    'specialOptions': null,
    'equipBrand': null,
    'currentType': null,
    'currentGrade': null,
  };

  bool validForm() {
    validate.mapSections(sections);
    validate.mapErrors(errors);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  void _validateForm() {
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(otherInfo.text, 'otherInfo');
    validate.validateTextField(specialOptions.text, 'specialOptions');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(currentType.text, 'currentType');
    validate.validateTextField(currentGrade.text, 'currentGrade');

    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(conveyorLengthUnit, 'conveyorLengthUnit');
    validate.validateDropdownField(conveyorSpeedUnit, 'conveyorSpeedUnit');
    validate.validateDropdownField(directionOfTravel, 'directionOfTravel');
    validate.validateDropdownField(applicationEnvironment, 'applicationEnvironment');
    validate.validateDropdownField(temperature, 'temperature');
    validate.validateDropdownField(singleOrDoubleStrand, 'singleOrDoubleStrand');
    validate.validateDropdownField(existingMonitoring, 'existingMonitoring');
    validate.validateDropdownField(outboardWheels, 'outboardWheels');
    validate.validateDropdownField(highRollers, 'highRollers');
    validate.validateDropdownField(lubricationSideChain, 'lubricationSideChain');
    validate.validateDropdownField(lubricationTopChain, 'lubricationTopChain');
    validate.validateDropdownField(chainMasterController, 'chainMasterController');
    validate.validateDropdownField(timer, 'timer');
    validate.validateDropdownField(electricOnOff, 'electricOnOff');
    validate.validateDropdownField(pneumaticOnOff, 'pneumaticOnOff');
    validate.validateDropdownField(mightyLubeMonitoring, 'mightyLubeMonitoring');
    validate.validateDropdownField(plcConnection, 'plcConnection');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');

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
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
    specialOptions.addListener(() {
      validate.onNameOpChanged(specialOptions.text, 'specialOptions');
      setState(() {});
    });
    otherInfo.addListener(() {
      validate.onNameOpChanged(otherInfo.text, 'otherInfo');
      setState(() {});
    });
    equipBrand.addListener(() {
      validate.onNameOpChanged(equipBrand.text, 'equipBrand');
      setState(() {});
    });
    currentType.addListener(() {
      validate.onNameOpChanged(currentType.text, 'currentType');
      setState(() {});
    });
    currentGrade.addListener(() {
      validate.onNameOpChanged(currentGrade.text, 'currentGrade');
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
    operatingVoltage.removeListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
    specialOptions.removeListener(() {
      validate.onNameOpChanged(specialOptions.text, 'specialOptions');
      setState(() {});
    });
    otherInfo.removeListener(() {
      validate.onNameOpChanged(otherInfo.text, 'otherInfo');
      setState(() {});
    });
    equipBrand.removeListener(() {
      validate.onNameOpChanged(equipBrand.text, 'equipBrand');
      setState(() {});
    });
    currentType.removeListener(() {
      validate.onNameOpChanged(currentType.text, 'currentType');
      setState(() {});
    });
    currentGrade.removeListener(() {
      validate.onNameOpChanged(currentGrade.text, 'currentGrade');
      setState(() {});
    });

    validate.delay?.cancel();
    super.dispose();
  }

  final Map<String, List<String>> sections = {
    "general":["conveyorSystem", "conveyorChainSize", "chainManufacturer", "conveyorLength", "conveyorLengthUnit", "conveyorSpeed", "conveyorSpeedUnit", "directionOfTravel", "applicationEnvironment", "temperature", "singleOrDoubleStrand", "conveyorIndex"],
    "customer":["operatingVoltage"],
    "monitoring":["existingMonitoring"],
    "specifications":["outboardWheels", "highRollers", "equipBrand", "currentType", "currentGrade", "lubricationSideChain", "lubricationTopChain"],
    "controller":["chainMasterController", "timer", "electricOnOff", "pneumaticOnOff", "mightyLubeMonitoring", "plcConnection", "otherInfo", "specialOptions"],
    "measurements":["measurementUnits"]
  };

  //currentGrade

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const ProductsHome()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent(), isError: validate.sectionError("general")),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent(), isError: validate.sectionError("customer")),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildNewMonitoringSystem(), isError: validate.sectionError("monitoring")),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications(), isError: validate.sectionError("specifications")),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController(), isError: validate.sectionError("controller")),
              CommonWidgets.buildGradientButton(context, 'CC5: Measurements',buildMeasurements(), isError: validate.sectionError("measurements")),
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
        CommonWidgets.buildDropdownFieldError('Conveyor Chain Size', [
          'CC5 3”',
          'CC5 4”',
          'CC5 6”',
          'RC60', 'RC80', 'RC 2080', 'RC 2060',
          'Other'
        ],  conveyorChainSize,
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
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownFieldError('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Millimeter',
        ],  conveyorLengthUnit,
                (value) {
                  setState(() {
                    conveyorLengthUnit = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorLengthUnit, 'conveyorLengthUnit');
                  });
                },
                errorText: errors['conveyorLengthUnit'],
              ),
        CommonWidgets.buildTextField('Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownFieldError('Conveyor Speed Unit', [
          'Feet/Minute',
          'Meters/Minute',
        ] ,  conveyorSpeedUnit,
                (value) {
                  setState(() {
                    conveyorSpeedUnit = value; // Update state properly
                    validate.validateDropdownField(
                        conveyorSpeedUnit, 'conveyorSpeedUnit');
                  });
                },
                errorText: errors['conveyorSpeedUnit'],
              ),
        CommonWidgets.buildTextField('Indexing or Variable Speed Conditions',conveyorIndex),
        CommonWidgets.buildDropdownFieldError('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ], directionOfTravel,
                (value) {
                  setState(() {
                    directionOfTravel = value; // Update state properly
                    validate.validateDropdownField(
                        directionOfTravel, 'directionOfTravel');
                  });
                },
                errorText: errors['directionOfTravel'],
              ),
        CommonWidgets.buildDropdownFieldError('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phospate/E-Coat, etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic','Food Grade', 'Other'
        ], applicationEnvironment,
                (value) {
                  setState(() {
                    applicationEnvironment = value; // Update state properly
                    validate.validateDropdownField(
                        applicationEnvironment, 'applicationEnvironment');
                  });
                },
                errorText: errors['applicationEnvironment'],
              ),
        CommonWidgets.buildDropdownFieldError('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No',
        ],  temperature,
                (value) {
                  setState(() {
                    temperature = value; // Update state properly
                    validate.validateDropdownField(
                        temperature, 'temperature');
                  });
                },
                errorText: errors['temperature'],
              ),
        CommonWidgets.buildDropdownFieldError('Is Conveyor Single or Double Strand', [
          'Single',
          'Double',
        ], singleOrDoubleStrand,
                (value) {
                  setState(() {
                    singleOrDoubleStrand = value; // Update state properly
                    validate.validateDropdownField(
                        singleOrDoubleStrand, 'singleOrDoubleStrand');
                  });
                },
                errorText: errors['singleOrDoubleStrand'],
              ),
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
        CommonWidgets.buildDropdownFieldError('Outboard Wheels', [
          'Yes',
          'No'
        ] , outboardWheels,
                (value) {
                  setState(() {
                    outboardWheels = value; // Update state properly
                    validate.validateDropdownField(
                        outboardWheels, 'outboardWheels');
                  });
                },
                errorText: errors['outboardWheels'],
              ),
        CommonWidgets.buildDropdownFieldError('High Rollers', [
          'Yes',
          'No'
        ] , highRollers,
                (value) {
                  setState(() {
                    highRollers = value; // Update state properly
                    validate.validateDropdownField(
                        highRollers, 'highRollers');
                  });
                },
                errorText: errors['highRollers'],
              ),
        
        CommonWidgets.buildTextField('Enter Rail Lubrication Equipment (Brand)',equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type',currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade',currentGrade),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ], lubricationSideChain,
                (value) {
                  setState(() {
                    lubricationSideChain = value; // Update state properly
                    validate.validateDropdownField(
                        lubricationSideChain, 'lubricationSideChain');
                  });
                },
                errorText: errors['lubricationSideChain'],
              ),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ], lubricationTopChain,
                (value) {
                  setState(() {
                    lubricationTopChain = value; // Update state properly
                    validate.validateDropdownField(
                        lubricationTopChain, 'lubricationTopChain');
                  });
                },
                errorText: errors['lubricationTopChain'],
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
        CommonWidgets.buildDropdownFieldError('ChainMaster Contoller', [
          'Yes',
          'No'
        ], chainMasterController,
                (value) {
                  setState(() {
                    chainMasterController = value; // Update state properly
                    validate.validateDropdownField(
                        chainMasterController, 'chainMasterController');
                  });
                },
                errorText: errors['chainMasterController'],
              ),
        CommonWidgets.buildDropdownFieldError('Timer', [
          'Not Required',
          '12 Hour', 
          '1000 Hour'
        ], timer,
                (value) {
                  setState(() {
                    timer = value; // Update state properly
                    validate.validateDropdownField(
                        timer, 'timer');
                  });
                },
                errorText: errors['timer'],
              ),
        CommonWidgets.buildDropdownFieldError('Electric On/Off', [
          'On',
          'Off'
        ], electricOnOff,
                (value) {
                  setState(() {
                    electricOnOff = value; // Update state properly
                    validate.validateDropdownField(
                        electricOnOff, 'electricOnOff');
                  });
                },
                errorText: errors['electricOnOff'],
              ),
        CommonWidgets.buildDropdownFieldError('Pneumatic On/Off', [
          'On',
          'Off'
        ], pneumaticOnOff,
                (value) {
                  setState(() {
                    pneumaticOnOff = value; // Update state properly
                    validate.validateDropdownField(
                        pneumaticOnOff, 'pneumaticOnOff');
                  });
                },
                errorText: errors['pneumaticOnOff'],
              ),
        CommonWidgets.buildDropdownFieldError('Mighty Lube Monitoring', [
          'Yes',
          'No'
        ], mightyLubeMonitoring,
                (value) {
                  setState(() {
                    mightyLubeMonitoring = value; // Update state properly
                    validate.validateDropdownField(
                        mightyLubeMonitoring, 'mightyLubeMonitoring');
                  });
                },
                errorText: errors['mightyLubeMonitoring'],
              ),
        CommonWidgets.buildDropdownFieldError('PLC Connection', [
          'Yes',
          'No'
        ], plcConnection,
                (value) {
                  setState(() {
                    plcConnection = value; // Update state properly
                    validate.validateDropdownField(
                        plcConnection, 'plcConnection');
                  });
                },
                errorText: errors['plcConnection'],
              ),
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
                    validate.validateDropdownField(
                        measurementUnits, 'measurementUnits');
                  });
                },
                errorText: errors['measurementUnits'],
              ),
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
        'conveyorLengthUnit': conveyorLengthUnit,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': conveyorSpeedUnit,
        'directionOfTravel': directionOfTravel,
        'applicationEnvironment': applicationEnvironment,
        'temperature': temperature,
        'singleOrDoubleStrand': singleOrDoubleStrand,
        'conveyorIndex': conveyorIndex.text,
        'operatingVoltage': operatingVoltage.text,
        'otherInfo': otherInfo.text,
        'specialOptions': specialOptions.text,
        'equipBrand': equipBrand.text,
        'currentType': currentType.text,
        'currentGrade': currentGrade.text,
        'existingMonitoring': existingMonitoring,
        'outboardWheels': outboardWheels,
        'highRollers': highRollers,
        'lubricationSideChain': lubricationSideChain,
        'lubricationTopChain': lubricationTopChain,
        'chainMasterController': chainMasterController,
        'timer': timer,
        'electricOnOff': electricOnOff,
        'pneumaticOnOff': pneumaticOnOff,
        'mightyLubeMonitoring': mightyLubeMonitoring,
        'plcConnection': plcConnection,
        'measurementUnits': measurementUnits,
      };
      status = FormAPI().addOrder("CC5_OP40E", opData, numRequested);
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields.'),
        ),
      );
      }
      return null;
    }
  }
