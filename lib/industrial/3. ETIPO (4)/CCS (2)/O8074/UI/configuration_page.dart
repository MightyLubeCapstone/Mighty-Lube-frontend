import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/CCS%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  Validators validate = Validators(); // Validation object

  // Text controllers
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();

  // Dropdown values
  int? chainManufacturer = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'chainManufacturer': null,
    'conveyorLengthUnit': null,
    'conveyorSpeedUnit': null,
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
    super.dispose();
  }

  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'conveyorLength',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
          context,
          '>',
          const ApplicationPage(),
          'Products',
          const CCSProducts(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                context,
                'General Information',
                buildGeneralInformationContent(),
                isError: validate.sectionError("General Information"),
              ),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addConfiguration(value);
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField(
          'Enter Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        if (errors['conveyorSystem'] != null) buildErrorText(errors['conveyorSystem']!),
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
            'Others',
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
              validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
            });
          },
          errorText: errors['chainManufacturer'],
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        if (errors['conveyorLength'] != null) buildErrorText(errors['conveyorLength']!),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeters'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value;
              validate.validateDropdownField(conveyorLengthUnit, 'conveyorLengthUnit');
            });
          },
          errorText: errors['conveyorLengthUnit'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Speed Unit',
          ['Feet/Minute', 'Meters/Minute'],
          conveyorSpeedUnit,
          (value) {
            setState(() {
              conveyorSpeedUnit = value;
              validate.validateDropdownField(conveyorSpeedUnit, 'conveyorSpeedUnit');
            });
          },
          errorText: errors['conveyorSpeedUnit'],
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

  Future<VoidCallback?> addConfiguration(int numRequested) async {
    if ((validForm())) {
      dynamic configurationData = {
        'conveyorSystem': conveyorSystem.text,
        'industrialChainManufacturer': chainManufacturer,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': conveyorLengthUnit,
      };
      bool status = await FormAPI().addOrder("ETI_807", configurationData, numRequested);
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
