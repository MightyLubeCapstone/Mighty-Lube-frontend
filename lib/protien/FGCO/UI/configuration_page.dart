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
  bool? status = false;
  Timer? _delay;

  final TextEditingController conveyorSystemName = TextEditingController();
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? conveyorLoaded = -1;
  int? dripLine = -1;
  final TextEditingController operatingVoltage = TextEditingController();
  int? installationClearance = -1;
  int? pushButton = -1;
  int? enclosedShroud = -1;
  final TextEditingController additionalOtherInfo = TextEditingController();

  Map<String, String?> errors = {};

  void _validateTextField(String value, String field,
      {bool isNum = false, bool decimal = false}) {
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
      errors[field] =
          (value == null || value == -1) ? 'This field is required.' : null;
    });
  }

  void _validatorDelay(String value, String field,
      {bool isNum = false, bool decimal = false}) {
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
    _validateTextField(conveyorSystemName.text, 'conveyorName');
    _validateDropdownField(chainManufacturer, 'chainManufacturer');
    _validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    _validateDropdownField(installationClearance, 'installationClearance');
    _validateDropdownField(pushButton, 'pushButton');
    _validateDropdownField(conveyorLoaded, 'conveyorLoaded');
    _validateTextField(operatingVoltage.text, 'operatingVoltage',
        isNum: true, decimal: true);

    setState(() {});
  }

  @override
  void dispose() {
    conveyorSystemName.removeListener(_onNameChanged);
    operatingVoltage.removeListener(_onOpChanged);
    _delay?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    conveyorSystemName.addListener(_onNameChanged);
    operatingVoltage.addListener(_onOpChanged);
  }

  void _onNameChanged() {
    _validatorDelay(conveyorSystemName.text, 'conveyorName');
  }

  void _onOpChanged() {
    _validatorDelay(operatingVoltage.text, 'operatingVoltage',
        isNum: true, decimal: true);
  }

  final Map<String, List<String>> sections = {
    "general": [
      'conveyorName',
      'conveyorChainSize',
      'chainManufacturer',
      'conveyorLoaded'
    ],
    "customerPowerUtilities": ['operatingVoltage'],
    "opss": ['installationClearance'],
    "additional": ['pushButton']
  };

  bool sectionError(String section) {
    return sections[section]!.any((field) => errors[field] != null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context, '>',
            const ApplicationPage(), 'Products', const ProteinHome()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent(),
                  isError: sectionError("general")),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent(),
                  isError: sectionError("customerPowerUtilities")),
              CommonWidgets.buildGradientButton(context, 'OP-SS', buildOPSS(),
                  isError: sectionError("opss")),
              CommonWidgets.buildGradientButton(
                  context, 'Additional Options Avaliable', buildAdditional(),
                  isError: sectionError("additional")),
            ],
          ),
        ),
        if (status == null)
          // loading spinner instead of add button
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
            addFGCOinfo(value);
          }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGeneralInformationContent() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: conveyorSystemName,
        builder: (context, value, child) {
          _validatorDelay(value.text, 'conveyorName');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildTextField(
                  'Name of Conveyor System *', conveyorSystemName,
                  errorText: errors['conveyorName']),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Chain Size *',
                [
                  'X348 Chain (3”)',
                  'X458 Chain (4”)',
                  'OX678 Chain (6”)',
                  '3/8" Log Chain'
                      'Other'
                ],
                conveyorChainSize,
                (value) {
                  setState(() {
                    conveyorChainSize = (value); // Update state properly
                    _validateDropdownField(
                        conveyorChainSize, 'conveyorChainSize');
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
                    _validateDropdownField(
                        chainManufacturer, 'chainManufacturer');
                  });
                },
                errorText: errors['chainManufacturer'],
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
                'Is this a Drip Line?',
                ['Yes', 'No'],
                dripLine,
                (value) {
                  setState(() {
                    dripLine = (value); // Update state properly
                  });
                },
              ),
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
                  'Operating Voltage - 3 Phase: (Volts/hz] *', operatingVoltage,
                  errorText: errors['operatingVoltage']),
              CommonWidgets.buildSectionDivider(),
            ],
          );
        });
  }

  Widget buildOPSS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Confirm Installation Clearance of: Minimum of 2" (.61m) for Clearance fo Moter Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'],
          installationClearance,
          (value) {
            setState(() {
              installationClearance = (value); // Update state properly
              _validateDropdownField(
                  installationClearance, 'installationClearance');
            });
          },
          errorText: errors['installationClearance'],
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildAdditional() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          '3-Station Push Button Switch *',
          ['Yes', 'No'],
          pushButton,
          (value) {
            setState(() {
              pushButton = (value); // Update state properly
              _validateDropdownField(pushButton, 'pushButton');
            });
          },
          errorText: errors['pushButton'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Totally Enclosed Food-Grade Metal Shroud',
          ['Yes', 'No'],
          enclosedShroud,
          (value) {
            setState(() {
              enclosedShroud = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildTextField(
            'Enter Other Information Here: ', additionalOtherInfo),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Future<VoidCallback?> addFGCOinfo(int numRequested) async {
    if (validForm()) {
      dynamic fgcoData = {
        "conveyorSystemName": conveyorSystemName.text,
        "conveyorChainSize": conveyorChainSize,
        "chainManufacturer": chainManufacturer,
        "conveyorLoaded": conveyorLoaded,
        if (dripLine != -1) "dripLine": dripLine,
        "operatingVoltTriple": num.parse(operatingVoltage.text),
        "installationClearance": installationClearance,
        "pushButton": pushButton,
        if (enclosedShroud != -1) "enclosedShroud": enclosedShroud,
        "additionalOtherInfo": additionalOtherInfo.text,
      };
      setState(() {
        status = null;
      });
      status = await FormAPI().addOrder("fgco", fgcoData, numRequested);
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
      setState(() {});
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
          icon: const Icon(
            Icons.home,
            color: Color(0xFF579AF6),
          ),
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
