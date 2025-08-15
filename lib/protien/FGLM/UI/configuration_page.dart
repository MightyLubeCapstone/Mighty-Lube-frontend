import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protein_home.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';
import 'dart:async';

class ConfigurationSection extends StatefulWidget {
  final void Function(int) updateCartItemCount;
  const ConfigurationSection({super.key, required this.updateCartItemCount});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  Timer? _delay;

  bool? status;
  bool loading = false;
  // Gen Info
  final TextEditingController conveyorSystemName = TextEditingController();
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? chainPinType = -1;
  final TextEditingController conveyorLength = TextEditingController();
  int? conveyorLengthUnit = -1;
  final TextEditingController conveyorSpeed = TextEditingController();
  int? conveyorSpeedUnit = -1;
  final TextEditingController conveyorIndex = TextEditingController();
  int? directionOfTravel = -1;
  int? metalType = -1;
  int? conveyorStyle = -1;
  int? trolleyColor = -1;
  int? trolleyType = -1;
  int? surroundingTemp = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? plantLayout = -1;
  int? requiredPics = -1;
  // CPU
  final TextEditingController operatingVoltage = TextEditingController();
  // MonSys
  int? existingMonitor = -1;
  int? newMonitor = -1;
  // MonFeatures
  int? motorAmp = -1;
  int? takeUpAir = -1;
  int? takeUpDist = -1;
  int? motorTemp = -1;
  int? motorVib = -1;
  int? detectFaultyTrolley = -1;
  // ConveyorSpecs
  int? sideLube = -1;
  int? topLube = -1;
  int? cleanChain = -1;
  // Wire
  int? measureUnits = -1;
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};
  // error messages
  Map<String, String?> errors = {
    //dropdowns
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'chainPinType': null,
    'metalType': null,
    'conveyorStyle': null,
    'sideLube': null,
    'topLube': null,
    'trolleyColor': null,
    'trolleyType': null,
    'conveyorLoaded': null,
    'conveyorSwing': null,
    //textfields
    'conveyorName': null,
    'con4': null,
    'con7': null,
    'con2': null,
    'operatingVoltage': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
  };

  void _validateTextField(String value, String field, {bool isNum = false, bool decimal = false}) {
    setState(() {
      if (value.trim().isEmpty) {
        errors[field] = 'This field is required.';
      } else if (isNum) {
        RegExp num = decimal ? RegExp(r'^\d+(\.\d+)?$') : RegExp(r'^\d+$');
        if (!num.hasMatch(value)) {
          errors[field] = 'Please enter a valid number.';
        } else {
          errors[field] = null;
        }
      } else {
        errors[field] = null;
      }
    });
  }

  void _validateDropdownField(int? value, String field) {
    setState(() {
      errors[field] = (value == null || value == -1) ? 'This field is required.' : null;
    });
  }

  void _validatorDelay(String value, String field, {bool isNum = false, bool decimal = false}) {
    if (_delay?.isActive ?? false) {
      _delay!.cancel();
    }
    // manual delay so its not a constant spam of requirements (hopefully)
    _delay = Timer(const Duration(milliseconds: 0), () {
      _validateTextField(value, field, isNum: isNum, decimal: decimal);
    });
  }

  bool validForm() {
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    _validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    _validateDropdownField(chainManufacturer, 'chainManufacturer');
    _validateDropdownField(chainPinType, 'chainPinType');
    _validateDropdownField(metalType, 'metalType');
    _validateDropdownField(conveyorStyle, 'conveyorStyle');
    _validateDropdownField(trolleyColor, 'trolleyColor');
    _validateDropdownField(trolleyType, 'trolleyType');
    _validateDropdownField(conveyorLoaded, 'conveyorLoaded');
    _validateDropdownField(conveyorSwing, 'conveyorSwing');
    _validateDropdownField(sideLube, 'sideLube');
    _validateDropdownField(topLube, 'topLube');

    _validateTextField(conveyorSystemName.text, 'conveyorName');
    _validateTextField(conductor4.text, 'con4', isNum: true, decimal: true);
    _validateTextField(conductor7.text, 'con7', isNum: true, decimal: true);
    _validateTextField(conductor2.text, 'con2', isNum: true, decimal: true);
    _validateTextField(operatingVoltage.text, 'operatingVoltage', isNum: true, decimal: true);
    _validateTextField(conveyorLength.text, 'conveyorLength', isNum: true, decimal: true);
    _validateTextField(conveyorSpeed.text, 'conveyorSpeed', isNum: true, decimal: true);

    setState(() {});
  }

  @override
  void dispose() {
    conveyorSystemName.removeListener(_onNameChanged);
    operatingVoltage.removeListener(_onOpChanged);
    conductor7.removeListener(_on7Changed);
    conductor4.removeListener(_on4Changed);
    conductor2.removeListener(_on2Changed);
    conveyorLength.removeListener(_onLengthChanged);
    conveyorSpeed.removeListener(_onSpeedChanged);
    _delay?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    conveyorSystemName.addListener(_onNameChanged);
    operatingVoltage.addListener(_onOpChanged);
    conductor7.addListener(_on7Changed);
    conductor4.addListener(_on4Changed);
    conductor2.addListener(_on2Changed);
    conveyorLength.addListener(_onLengthChanged);
    conveyorSpeed.addListener(_onSpeedChanged);
  }

  void _onNameChanged() {
    _validatorDelay(conveyorSystemName.text, 'conveyorName');
  }

  void _onOpChanged() {
    _validatorDelay(operatingVoltage.text, 'operatingVoltage', isNum: true, decimal: true);
  }

  void _on7Changed() {
    _validatorDelay(conductor7.text, 'con7', isNum: true, decimal: true);
  }

  void _on4Changed() {
    _validatorDelay(conductor4.text, 'con4', isNum: true, decimal: true);
  }

  void _on2Changed() {
    _validatorDelay(conductor2.text, 'con2', isNum: true, decimal: true);
  }

  void _onLengthChanged() {
    _validatorDelay(conveyorLength.text, 'conveyorLength', isNum: true, decimal: true);
  }

  void _onSpeedChanged() {
    _validatorDelay(conveyorSpeed.text, 'conveyorSpeed', isNum: true, decimal: true);
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

  bool sectionError(String section) {
    return sections[section]!.any((field) => errors[field] != null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
            context, '>', const ApplicationPage(), 'Products', const ProteinHome()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                context,
                'General Information',
                buildGeneralInformationContent(),
                isError: sectionError("general"),
              ),
              CommonWidgets.buildGradientButton(
                  context, 'Customer Power Utilities', buildCustomerPowerUtilitiesContent(),
                  isError: sectionError("custom")),
              CommonWidgets.buildGradientButton(
                  context, 'New or Existing Monitoring System', buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: sectionError("conveyor")),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire(),
                  isError: sectionError("wire")),
            ],
          ),
        ),
        if (loading == false)
          CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
            addFGLMInfo(value);
          }),
        const SizedBox(height: 20),
      ],
    );
  }

//buttons

  Widget buildGeneralInformationContent() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: conveyorSystemName,
        builder: (context, value, child) {
          _validatorDelay(value.text, 'conveyorName');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildTextField('Name of Conveyor System *', conveyorSystemName,
                  errorText: errors['conveyorName']),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Chain Size *',
                ['X348 Chain (3”)', 'X458 Chain (4”)', 'OX678 Chain (6”)', 'Other'],
                conveyorChainSize,
                (value) {
                  setState(() {
                    conveyorChainSize = value; // Update state properly
                    _validateDropdownField(conveyorChainSize, 'conveyorChainSize');
                  });
                },
                errorText: errors['conveyorChainSize'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Protein: Chain Manufacturer *',
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
                chainManufacturer,
                (value) {
                  setState(() {
                    chainManufacturer = (value); // Update state properly
                    _validateDropdownField(chainManufacturer, 'chainManufacturer');
                  });
                },
                errorText: errors['chainManufacturer'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Chain Pin Type *',
                ['Bolts', 'Pin', 'Log'],
                chainPinType,
                (value) {
                  setState(() {
                    chainPinType = value;
                    _validateDropdownField(chainPinType, 'chainPinType');
                  });
                },
                errorText: errors['chainPinType'],
              ),
              CommonWidgets.buildTextField('Enter Number Here *', conveyorLength,
                  errorText: errors['conveyorLength']),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Length Unit *',
                ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
                conveyorLengthUnit,
                (value) {
                  setState(() {
                    conveyorLengthUnit = (value); // Update state properly
                  });
                },
              ),
              CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max) *', conveyorSpeed,
                  errorText: errors['conveyorSpeed']),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Speed Unit *',
                [
                  'Feet/Minute',
                  'Meter/Minute',
                ],
                conveyorSpeedUnit,
                (value) {
                  setState(() {
                    conveyorSpeedUnit = (value); // Update state properly
                  });
                },
              ),
              CommonWidgets.buildTextField('Indexing or Variable Speed Conditions', conveyorIndex),
              CommonWidgets.buildDropdownFieldError(
                'Direction of Travel',
                [
                  'Right to Left',
                  'Left to Right',
                ],
                directionOfTravel,
                (value) {
                  setState(() {
                    directionOfTravel = (value); // Update state properly
                  });
                },
              ),
              CommonWidgets.buildDropdownFieldError(
                'What Type of Metal *',
                ['Stainless Steel', 'Zinc', 'Mild Steel', 'Other'],
                metalType,
                (value) {
                  setState(() {
                    metalType = (value);
                    _validateDropdownField(metalType, 'metalType');
                  });
                },
                errorText: errors['metalType'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Style of Conveyor *',
                ['I-Beam', 'Meyn', 'Sani Track', 'T Rail', 'Other'],
                conveyorStyle,
                (value) {
                  setState(() {
                    conveyorStyle = (value);
                    _validateDropdownField(conveyorStyle, 'conveyorStyle');
                  });
                },
                errorText: errors['conveyorStyle'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Color of Trolley *',
                ['Blue', 'Green', 'Grey', 'Other'],
                trolleyColor,
                (value) {
                  setState(() {
                    trolleyColor = (value);
                    _validateDropdownField(trolleyColor, 'trolleyColor');
                  });
                },
                errorText: errors['trolleyColor'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Type of Trolley *',
                [
                  'Meyn Trolley Halve Green Wheel Bolt',
                  'Meyn Plastic Click Version',
                  'Meyn SS Halve Green Wheel',
                  'Meyn SS Halve Gray Wheel',
                  'Stork Halve Bolt Version Blue Wheel',
                  'Linco Plastic Halve Blue Wheel'
                ],
                trolleyType,
                (value) {
                  setState(() {
                    trolleyType = (value); // Update state properly
                    _validateDropdownField(trolleyType, 'trolleyType');
                  });
                },
                errorText: errors['trolleyType'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
                ['Yes', 'No'],
                surroundingTemp,
                (value) {
                  setState(() {
                    surroundingTemp = value; // Update state properly
                  });
                },
              ),
              CommonWidgets.buildDropdownFieldError(
                'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
                ['Loaded', 'Unloaded'],
                conveyorLoaded,
                (value) {
                  setState(() {
                    conveyorLoaded = (value); // Update state properly
                    _validateDropdownField(conveyorLoaded, 'conveyorLoaded');
                  });
                },
                errorText: errors['conveyorLoaded'],
              ),
              CommonWidgets.buildDropdownFieldError(
                'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
                ['Yes', 'No'],
                conveyorSwing,
                (value) {
                  setState(() {
                    conveyorSwing = (value); // Update state properly
                    _validateDropdownField(conveyorSwing, 'conveyorSwing');
                  });
                },
                errorText: errors['conveyorSwing'],
              ),
              // CommonWidgets.buildDropdownFieldError(
              //   'I Have A Plant Layout To Attach',
              //   ['Yes - Will Attach', 'No - Do Not Have'],
              //   plantLayout,
              //   (value) {
              //     setState(() {
              //       plantLayout = (value); // Update state properly
              //     });
              //   },
              // ),
              // CommonWidgets.buildDropdownFieldError(
              //   'I Have The Required Pictures Of Each Chain To Attach',
              //   ['Yes - Will Attach', 'No - Do Not Have'],
              //   requiredPics,
              //   (value) {
              //     setState(() {
              //       requiredPics = (value); // Update state properly
              //     });
              //   },
              // ),
              CommonWidgets.buildSectionDivider(),
            ],
          );
        });
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: operatingVoltage,
        builder: (context, value, child) {
          _validatorDelay(value.text, 'operatingVoltage');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildTextField(
                  'Operating Voltage - Single Phase: (Volts/hz] *', operatingVoltage,
                  errorText: errors['operatingVoltage']),
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
        CommonWidgets.buildDropdownFieldError(
          'Connecting to Existing Monitoring',
          ['Yes', 'No'],
          existingMonitor,
          (value) {
            setState(() {
              existingMonitor = value;
              validate.validateDropdownField(existingMonitor, 'existingMonitoring');
            });
          },
          errorText: errors['existingMonitoring'],
        ),
        CommonWidgets.buildSectionDivider(),
        if (existingMonitor == 1)
          CommonWidgets.buildTemplateA(
            templateAKey,
            validate,
            data: templateAData,
            callback: (data) {
              templateAData = data;
            },
          ),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Drive Motor Amp *',
          ['Yes', 'No'],
          motorAmp,
          (value) {
            setState(() {
              motorAmp = (value); // Update state properly
              _validateDropdownField(motorAmp, 'motorAmp');
            });
          },
          errorText: errors['motorAmp'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Drive Take-up-Air *',
          ['Yes', 'No'],
          takeUpAir,
          (value) {
            setState(() {
              takeUpAir = (value); // Update state properly
              _validateDropdownField(takeUpAir, 'takeUpAir');
            });
          },
          errorText: errors['takeUpAir'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Take-Up Distance *',
          ['Yes', 'No'],
          takeUpDist,
          (value) {
            setState(() {
              takeUpDist = (value); // Update state properly
              _validateDropdownField(takeUpDist, 'takeUpDist');
            });
          },
          errorText: errors['takeUpDist'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Drive Motor Temp ',
          ['Yes', 'No'],
          motorTemp,
          (value) {
            setState(() {
              motorTemp = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Drive Motor Vibration',
          ['Yes', 'No'],
          motorVib,
          (value) {
            setState(() {
              motorVib = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Bent or Missing Trolley detect *',
          ['Yes', 'No'],
          detectFaultyTrolley,
          (value) {
            setState(() {
              detectFaultyTrolley = (value); // Update state properly
              _validateDropdownField(detectFaultyTrolley, 'detectFaultyTrolley');
            });
          },
          errorText: errors['detectFaultyTrolley'],
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
          'Lubrication from the Side of Chain *',
          ['Yes', 'No'],
          sideLube,
          (value) {
            setState(() {
              sideLube = (value); // Update state properly
              _validateDropdownField(sideLube, 'sideLube');
            });
          },
          errorText: errors['sideLube'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Lubrication from the Top of Chain *',
          ['Yes', 'No'],
          topLube,
          (value) {
            setState(() {
              topLube = (value); // Update state properly
              _validateDropdownField(topLube, 'topLube');
            });
          },
          errorText: errors['topLube'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Chain Clean?',
          ['Yes', 'No'],
          cleanChain,
          (value) {
            setState(() {
              cleanChain = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Measurement Units',
          ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
          measureUnits,
          (value) {
            setState(() {
              measureUnits = (value); // Update state properly
            });
          },
        ),
        ValueListenableBuilder(
            valueListenable: conductor2,
            builder: (context, value, child) {
              _validatorDelay(value.text, 'con2');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.buildTextField('Enter 2 Conductor Number Here *', conductor2,
                      errorText: errors['con2']),
                ],
              );
            }),
        ValueListenableBuilder(
            valueListenable: conductor4,
            builder: (context, value, child) {
              _validatorDelay(value.text, 'con4');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.buildTextField('Enter 4 Conductor Number Here *', conductor4,
                      errorText: errors['con4']),
                ],
              );
            }),
        ValueListenableBuilder(
            valueListenable: conductor7,
            builder: (context, value, child) {
              _validatorDelay(value.text, 'con7');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.buildTextField('Enter 7 Conductor Number Here *', conductor7,
                      errorText: errors['con7']),
                ],
              );
            }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Future<VoidCallback?> addFGLMInfo(int numRequested) async {
    if (validForm()) {
      dynamic fglmData = {
        "conveyorName": conveyorSystemName.text,
        "conveyorChainSize": conveyorChainSize,
        "chainManufacturer": chainManufacturer,
        "chainPinType": chainPinType,
        "conveyorLength": num.parse(conveyorLength.text),
        "conveyorLengthUnit": conveyorLengthUnit,
        "conveyorSpeed": num.parse(conveyorSpeed.text),
        "conveyorSpeedUnit": conveyorSpeedUnit,
        "conveyorIndex": conveyorIndex.text,
        "travelDirection": directionOfTravel,
        "metalType": metalType,
        "conveyorStyle": conveyorStyle,
        "trolleyColor": trolleyColor,
        "trolleyType": trolleyType,
        "surroundingTemp": surroundingTemp,
        "conveyorLoaded": conveyorLoaded,
        "conveyorSwing": conveyorSwing,
        "plantLayout": plantLayout,
        "requiredPics": requiredPics,
        "operatingVoltage": num.parse(operatingVoltage.text),
        "existingMonitor": existingMonitor,
        "newMonitor": newMonitor,
        "motorAmp": motorAmp,
        "takeUpAir": takeUpAir,
        "takeUpDist": takeUpDist,
        "motorTemp": motorTemp,
        "motorVib": motorVib,
        "detectFaultyTrolley": detectFaultyTrolley,
        "sideLube": sideLube,
        "topLube": topLube,
        "cleanChain": cleanChain,
        "wireMeasurementUnit": measureUnits,
        "conductor4": num.parse(conductor4.text),
        "conductor7": num.parse(conductor7.text),
        "conductor2": num.parse(conductor2.text),
        "templateA": templateAData,
      };
      setState(() {
        status = null;
        loading = true;
      });
      //add a loader that shows a happy popup for this eventually :)
      status = await FormAPI().addOrder("fglm", fglmData, numRequested);
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
        widget.updateCartItemCount(numRequested);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding to configurator!')),
        );
      }
      setState(() {
        loading = false;
      });
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
    }
    return null;
  }
}

Widget buildBreadcrumbNavigation(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.blue),
          onPressed: () {
            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ApplicationPage()),
            );
          },
        ),
        const Text(' > '),
        GestureDetector(
          onTap: () {
            // Navigate to the Protein page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProteinHome()),
            ); // Replace with navigation to your Protein page
          },
          child: const Text(
            'Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
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