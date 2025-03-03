import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protienHome.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';
import 'dart:async';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  Future<bool>? status;
  
  final Validators validate = Validators();

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

  Map<String, String?> errors = {
    'conveyorName': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'conveyorLoaded': null,
    'dripLine': null,
    'operatingVoltage': null,
    'installationClearance': null,
    'pushButton': null,
    'enclosedShroud': null,
    'additionalOtherInfo': null,
  };

  bool validForm() {
    validate.mapSections(sections);
    validate.mapErrors(errors);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorSystemName.text, 'conveyorName');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(installationClearance, 'installationClearance');
    validate.validateDropdownField(pushButton, 'pushButton');
    validate.validateDropdownField(conveyorLoaded, 'conveyorLoaded');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');

    setState(() {});
  }

  @override
  void dispose() {
    conveyorSystemName.removeListener(() {validate.onNameOpChanged(conveyorSystemName.text, 'conveyorName');
      setState(() {});
    });
    operatingVoltage.removeListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
    validate.delay?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    conveyorSystemName.addListener(() {
      validate.onNameOpChanged(conveyorSystemName.text, 'conveyorName');
      setState(() {});
    });
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
  }

  final Map<String, List<String>> sections = {
    "general" : ['conveyorName', 'conveyorChainSize', 'chainManufacturer', 'conveyorLoaded'],
    "customerPowerUtilities" : ['operatingVoltage'],
    "opss" : ['installationClearance'],
    "additional" : ['pushButton']
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const ProteinHome()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent(), isError: validate.sectionError("general")),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent(), isError: validate.sectionError("customerPowerUtilities")),
              CommonWidgets.buildGradientButton(context, 'OP-SS', buildOPSS(), isError: validate.sectionError("opss")),
              CommonWidgets.buildGradientButton(
                  context, 'Additional Options Avaliable', buildAdditional(), isError: validate.sectionError("additional")),
            ],
          ),
        ),
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
          validate.validatorDelay(value.text, 'conveyorName');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildTextField(
                  'Name of Conveyor System *', conveyorSystemName,
                  errorText: errors['conveyorName']),
              if (errors['conveyorName'] != null)
                buildErrorText(errors['conveyorName']!),
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildSectionTitle('Conveyor Details'),
              CommonWidgets.buildDropdownFieldError(
                'Conveyor Chain Size',
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
                  });
                },
              ),
              CommonWidgets.buildDropdownFieldError(
                'Protein: Chain Manufacturer',
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
                    validate.validateDropdownField(conveyorLoaded, 'conveyorLoaded');
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
          validate.validatorDelay(value.text, 'operatingVoltage');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.buildSectionDivider(),
              CommonWidgets.buildTextField(
                  'Operating Voltage - 3 Phase: (Volts/hz] *', operatingVoltage,
                  errorText: errors['operatingVoltage']),
              if (errors['operatingVoltage'] != null)
                buildErrorText(errors['operatingVoltage']!),
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
              validate.validateDropdownField(installationClearance, 'installationClearance');
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
          ' 3-Station Push Button Switch',
          ['Yes', 'No'],
          pushButton,
          (value) {
            setState(() {
              pushButton = (value); // Update state properly
              validate.validateDropdownField(pushButton, 'pushButton');
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

  VoidCallback? addFGCOinfo(int numRequested) {
    if (validForm()) {
      dynamic fgcoData = {
        "conveyorSystemName": conveyorSystemName.text,
        "conveyorChainSize": conveyorChainSize,
        "chainManufacturer": chainManufacturer,
        "conveyorLoaded": conveyorLoaded,
        "dripLine": dripLine,
        "operatingVoltTriple": (operatingVoltage.text != "")
            ? int.parse(operatingVoltage.text)
            : -1, // remove this once validation is here
        "installationClearance": installationClearance,
        "pushButton": pushButton,
        "enclosedShroud": enclosedShroud,
        "additionalOtherInfo": additionalOtherInfo.text
      };
      status = FormAPI().addOrder("fgco", fgcoData, numRequested);
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
