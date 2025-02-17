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
  Timer? _delay;

  Future<bool>? status;
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
  // error messages
  Map<String, String?> errors = {};

  void _validateTextField(String value, String field) {
    setState(() {
      errors[field] = value.trim().isEmpty ? 'This field is required.' : null;
    });
  }

  void _validateDropdownField(int? value, String field) {
    setState(() {
      errors[field] = (value == null || value == -1) ? 'This field is required.' : null;
    });
  }

  void _validatorDelay(String value, String field) {
    if (_delay?.isActive ?? false){
      _delay!.cancel();
    }
    // manual delay so its not a constant spam of requirements (hopefully)
    _delay = Timer(const Duration(milliseconds: 100), () {
      _validateTextField(value, field);
    });
  }

  bool validForm() {
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    _validateTextField(conveyorSystemName.text, 'conveyorName');

    _validateDropdownField(chainPinType, 'chainPinType');
    _validateDropdownField(metalType, 'metalType');
    _validateDropdownField(conveyorStyle, 'conveyorStyle');
    _validateDropdownField(trolleyColor, 'trolleyColor');
    _validateDropdownField(trolleyType, 'trolleyType');
    _validateDropdownField(conveyorLoaded, 'conveyorLoaded');
    _validateDropdownField(conveyorSwing, 'conveyorSwing');

    _validateTextField(operatingVoltage.text, 'operatingVoltage');

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _validateForm();
      setState(() {});
    });
  }

  void _onNameChanged() {
    _validatorDelay(conveyorSystemName.text, 'conveyorName');
  }

  void _onOpChanged() {
    _validatorDelay(operatingVoltage.text, 'operatingVoltage');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildBreadcrumbNavigation(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent()),
              CommonWidgets.buildGradientButton(
                  context,
                  'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent()),
              CommonWidgets.buildGradientButton(
                  context,
                  'New/Adding to Existing Monitoring System',
                  buildNewMonitoringSystem()),
              CommonWidgets.buildGradientButton(context,
                  'Monitoring Features Requested', buildMonitoringFeatures()),
              CommonWidgets.buildGradientButton(context,
                  'Conveyor Specifications', buildConveyorSpecifications()),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire()),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addFGLMInfo(value);
        }),
        const SizedBox(height: 20),
      ],
      );
  }

//buttons

  Widget buildGeneralInformationContent() {
    return
    ValueListenableBuilder<TextEditingValue>(
          valueListenable: conveyorSystemName,
          builder: (context, value, child) {
            _validatorDelay(value.text, 'conveyorName');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildTextField(
            'Name of Conveyor System *', conveyorSystemName, errorText: errors['conveyorName']),
        if (errors['conveyorName'] != null) buildErrorText(errors['conveyorName']!),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildDropdownFieldProtein(
          'Conveyor Chain Size',
          ['X348 Chain (3”)', 'X458 Chain (4”)', 'OX678 Chain (6”)', 'Other'],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value; // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildTextField('Enter Number Here', conveyorLength),
        CommonWidgets.buildDropdownFieldProtein(
          'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildTextField(
            'Enter Conveyor Speed (Min/Max)', conveyorSpeed),
        CommonWidgets.buildDropdownFieldProtein(
          'Conveyor Speed Unit',
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
        CommonWidgets.buildTextField(
            'Indexing or Variable Speed Conditions', conveyorIndex),
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
          'Type of Trolley',
          [
            'Meyn Trolley Halve Green Wheel Bolt Version',
            'Meyn Plastic Click Version',
            'Meyn Stainless Steel Halve w/ Green Wheel',
            'Meyn Stainless Stell Halve Gray Wheel',
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
        CommonWidgets.buildDropdownFieldProtein(
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          ['Yes', 'No'],
          surroundingTemp,
          (value) {
            setState(() {
              surroundingTemp = value; // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
          'I Have A Plant Layout To Attach',
          ['Yes - Will Attach', 'No - Do Not Have'],
          plantLayout,
          (value) {
            setState(() {
              plantLayout = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'I Have The Required Pictures Of Each Chain To Attach',
          ['Yes - Will Attach', 'No - Do Not Have'],
          requiredPics,
          (value) {
            setState(() {
              requiredPics = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return
    ValueListenableBuilder<TextEditingValue>(
      valueListenable: operatingVoltage,
      builder: (context, value, child) {
        _validatorDelay(value.text, 'operatingVoltage');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
            'Operating Voltage - Single Phase: (Volts/hz] *', operatingVoltage, errorText: errors['operatingVoltage']),
        if (errors['operatingVoltage'] != null) buildErrorText(errors['operatingVoltage']!),
        CommonWidgets.buildSectionDivider(),
      ],
    );
      }
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
          'Connecting to Existing Monitoring',
          ['Yes', 'No'],
          existingMonitor,
          (value) {
            setState(() {
              existingMonitor = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Add New Monitoring System',
          ['Yes', 'No'],
          newMonitor,
          (value) {
            setState(() {
              newMonitor = (value); // Update state properly
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
        CommonWidgets.buildDropdownFieldProtein(
          'Drive Motor Amp',
          ['Yes', 'No'],
          motorAmp,
          (value) {
            setState(() {
              motorAmp = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Drive Take-up-Air',
          ['Yes', 'No'],
          takeUpAir,
          (value) {
            setState(() {
              takeUpAir = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Take-Up Distance',
          ['Yes', 'No'],
          takeUpDist,
          (value) {
            setState(() {
              takeUpDist = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Drive Motor Temp',
          ['Yes', 'No'],
          motorTemp,
          (value) {
            setState(() {
              motorTemp = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Drive Motor Vibration',
          ['Yes', 'No'],
          motorVib,
          (value) {
            setState(() {
              motorVib = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Bent or Missing Trolley detect',
          ['Yes', 'No'],
          detectFaultyTrolley,
          (value) {
            setState(() {
              detectFaultyTrolley = (value); // Update state properly
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldProtein(
          'Lubrication from the Side of Chain',
          ['Yes', 'No'],
          sideLube,
          (value) {
            setState(() {
              sideLube = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
          'Lubrication from the Top of Chain',
          ['Yes', 'No'],
          topLube,
          (value) {
            setState(() {
              topLube = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildDropdownFieldProtein(
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
        CommonWidgets.buildDropdownFieldProtein(
          'Measurement Units',
          ['Feet', 'Inches', 'm Meter', 'mm Milimeter'],
          measureUnits,
          (value) {
            setState(() {
              measureUnits = (value); // Update state properly
            });
          },
        ),
        CommonWidgets.buildTextField(
            'Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField(
            'Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField(
            'Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addFGLMInfo(int numRequested) {
    if (validForm()) {
    dynamic fglmData = {
      "conveyorName": conveyorSystemName.text,
      "conveyorChainSize": conveyorChainSize,
      "chainManufacturer": chainManufacturer,
      "chainPinType": chainPinType,
      "conveyorLength": conveyorLength.text,
      "conveyorLengthUnit": conveyorLengthUnit,
      "conveyorSpeed": conveyorSpeed.text,
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
      "operatingVoltage": operatingVoltage.text,
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
      "measureUnits": measureUnits,
      "conductor4": conductor4.text,
      "conductor7": conductor7.text,
      "conductor2": conductor2.text
    };
    //add a loader that shows a happy popup for this eventually :)
    status = FormAPI().addOrder("fglm", fglmData, numRequested);
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

Widget buildErrorText(String message){
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
