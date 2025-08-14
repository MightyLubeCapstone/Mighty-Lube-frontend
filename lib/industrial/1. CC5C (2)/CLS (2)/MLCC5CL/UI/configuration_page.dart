import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/1.%20CC5C%20(2)/CLS%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'dart:async';
import 'package:mighty_lube/api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count

  // Text controllers
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController aDiameter = TextEditingController();
  final TextEditingController bWidth = TextEditingController();
  final TextEditingController dThickness = TextEditingController();
  final TextEditingController mInside = TextEditingController();
  final TextEditingController yDiameter = TextEditingController();
  final TextEditingController zLength = TextEditingController();

  // Dropdown values
  int? conveyorSpeedUnit = -1;
  int? conveyorLengthUnit = -1;
  int? directionOfTravel = -1;
  int? measurementUnits = -1;
  int? monitoringUnits = -1;
  int? conveyorClean = -1;
  int? highRollers = -1;
  int? outboardWheels = -1;
  int? conveyorStrand = -1;
  int? existingMonitoring = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? existingMonitoringStr = -1;

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};

  bool? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'conveyorIndex': null,
    'applicationEnvironment': null,
    'surroundingTemp': null,
    'operatingVoltage': null,
    'conveyorStrand': null,
    'existingMonitoring': null,
    'specialOptions': null,
    'conveyorSpeedUnit': null,
    'conveyorLengthUnit': null,
    'directionOfTravel': null,
    'measurementUnits': null,
    'conveyorClean': null,
    'highRollers': null,
    'outboardWheels': null,
    'gWidth': null,
    'hHeight': null,
    'aDiameter': null,
    'bWidth': null,
    'dThickness': null,
    'mInside': null,
    'yDiameter': null,
    'zLength': null,
  };

  // Sections map
  final Map<String, List<String>> sections = {
    "general": [
      "conveyorSystem",
      "conveyorChainSize",
      "chainManufacturer",
      "conveyorLength",
      "conveyorSpeed",
      "conveyorIndex",
      "applicationEnvironment",
      "surroundingTemp",
      "conveyorStrand",
    ],
    "custom": ["operatingVoltage"],
    "monitoring": ["existingMonitoring"],
    "controller": ["specialOptions"],
    "conveyor": ["highRollers", "outboardWheels", "conveyorClean"],
    "measurements": [
      "gWidth",
      "hHeight",
      "aDiameter",
      "bWidth",
      "dThickness",
      "mInside",
      "yDiameter",
      "zLength"
    ],
  };

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
    validate.delay?.cancel();
    gWidth.dispose();
    hHeight.dispose();
    aDiameter.dispose();
    bWidth.dispose();
    dThickness.dispose();
    mInside.dispose();
    yDiameter.dispose();
    zLength.dispose();
    super.dispose();
  }

  bool validForm() {
    validate.mapSections(sections);
    validate.mapErrors(errors);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(conveyorIndex.text, 'conveyorIndex');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(specialOptions.text, 'specialOptions');

    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(applicationEnvironment, 'applicationEnvironment');
    validate.validateDropdownField(surroundingTemp, 'surroundingTemp');
    validate.validateDropdownField(conveyorStrand, 'conveyorStrand');
    validate.validateDropdownField(existingMonitoring, 'existingMonitoring');
    validate.validateDropdownField(conveyorSpeedUnit, 'conveyorSpeedUnit');
    validate.validateDropdownField(conveyorLengthUnit, 'conveyorLengthUnit');
    validate.validateDropdownField(directionOfTravel, 'directionOfTravel');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');    validate.validateDropdownField(conveyorClean, 'conveyorClean');
    validate.validateDropdownField(highRollers, 'highRollers');
    validate.validateDropdownField(outboardWheels, 'outboardWheels');

    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(aDiameter.text, 'aDiameter');
    validate.validateTextField(bWidth.text, 'bWidth');
    validate.validateTextField(dThickness.text, 'dThickness');
    validate.validateTextField(mInside.text, 'mInside');
    validate.validateTextField(yDiameter.text, 'yDiameter');
    validate.validateTextField(zLength.text, 'zLength');

    errors = Map<String, String?>.from(validate.errors);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
            context, '>', const ApplicationPage(), 'Products', const ProductsHome()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                  context, 'General Information', buildGeneralInformationContent(),
                  isError: validate.sectionError("general")),
              CommonWidgets.buildGradientButton(
                  context, 'Customer Power Utilities', buildCustomerPowerUtilitiesContent(),
                  isError: validate.sectionError("custom")),
              CommonWidgets.buildGradientButton(
                  context, 'New or Existing Monitoring System', buildNewMonitoringSystem(),
                  isError: validate.sectionError("monitoring")),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError("conveyor")),
              CommonWidgets.buildGradientButton(context, 'Controller', buildController(),
                  isError: validate.sectionError("controller")),
              CommonWidgets.buildGradientButton(context, 'CC5: Measurements', buildMeasurements(),
                  isError: validate.sectionError("measurements")),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addMLCC5CL(value);
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
        CommonWidgets.buildTextField('Name of Conveyor System', conveyorSystem,
            errorText: errors['conveyorSystem']),
        if (errors['conveyorName'] != null) buildErrorText(errors['conveyorName']!),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          [
            'a. CC5 3”',
            'b. CC5 4”',
            'c. CC5 6”',
            'd. RC60',
            'e. RC80',
            'f. RC 2080',
            'g. RC 2060',
            'h. Other'
          ],
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
            'Daifuku',
            'Frost',
            'NKC',
            'Pacline',
            'Rapid',
            'WEBB',
            'Webb-Stiles',
            'Wilkie Brothers',
            'Other'
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = (value); // Update state properly
              validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
            });
          },
          errorText: errors['chainManufacturer'],
        ),
        CommonWidgets.buildTextField('Enter Conveyor Length', conveyorLength),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Length Unit',
          [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value; // Update state properly
              validate.validateDropdownField(conveyorLengthUnit, 'conveyorLengthUnit');
            });
          },
          errorText: errors['conveyorLengthUnit'],
        ),
        CommonWidgets.buildTextField('Conveyor Speed (Min/Max)', conveyorSpeed),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Speed Unit',
          [
            'Feet/Minute',
            'Meters/Minute',
          ],
          conveyorSpeedUnit,
          (value) {
            setState(() {
              conveyorSpeedUnit = value; // Update state properly
              validate.validateDropdownField(conveyorSpeedUnit, 'conveyorSpeedUnit');
            });
          },
          errorText: errors['conveyorSpeedUnit'],
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
              directionOfTravel = value; // Update state properly
              validate.validateDropdownField(directionOfTravel, 'directionOfTravel');
            });
          },
          errorText: errors['directionOfTravel'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Application Environment',
          [
            'Ambient',
            'Caustic (i.e. Phospate/E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other'
          ],
          applicationEnvironment,
          (value) {
            setState(() {
              applicationEnvironment = value; // Update state properly
              validate.validateDropdownField(applicationEnvironment, 'applicationEnvironment');
            });
          },
          errorText: errors['applicationEnvironment'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          [
            'Yes',
            'No',
          ],
          surroundingTemp,
          (value) {
            setState(() {
              surroundingTemp = value; // Update state properly
              validate.validateDropdownField(surroundingTemp, 'surroundingTemp');
            });
          },
          errorText: errors['surroundingTemp'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is Conveyor Single or Double Strand',
          [
            'Single',
            'Double',
          ],
          conveyorStrand,
          (value) {
            setState(() {
              conveyorStrand = value; // Update state properly
              validate.validateDropdownField(conveyorStrand, 'conveyorStrand');
            });
          },
          errorText: errors['conveyorStrand'],
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
                  'Operating Voltage - Single Phase: (Volts/hz] *', operatingVoltage,
                  errorText: errors['operatingVoltage']),
              if (errors['operatingVoltage'] != null) buildErrorText(errors['operatingVoltage']!),
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
          existingMonitoring,
          (value) {
            setState(() {
              existingMonitoring = value;
              validate.validateDropdownField(existingMonitoring, 'existingMonitoring');
            });
          },
          errorText: errors['existingMonitoring'],
        ),
        CommonWidgets.buildSectionDivider(),
        if (existingMonitoring == 1)
          CommonWidgets.buildTemplateA(templateAKey, validate, data: templateAData,
              callback: (data) {
            templateAData = data;
          }),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Is their High Rollers',
          ['Yes', 'No'],
          highRollers,
          (value) {
            setState(() {
              highRollers = value; // Update state properly
              validate.validateDropdownField(highRollers, 'highRollers');
            });
          },
          errorText: errors['highRollers'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Outboard Wheels  ',
          ['Yes', 'No'],
          outboardWheels,
          (value) {
            setState(() {
              outboardWheels = value; // Update state properly
              validate.validateDropdownField(outboardWheels, 'outboardWheels');
            });
          },
          errorText: errors['outboardWheels'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Chain Clean?',
          ['Yes', 'No'],
          conveyorClean,
          (value) {
            setState(() {
              conveyorClean = value; // Update state properly
              validate.validateDropdownField(conveyorClean, 'conveyorClean');
            });
          },
          errorText: errors['conveyorClean'],
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
        CommonWidgets.buildTextField(
            'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
            specialOptions),
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
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value; // Update state properly
              validate.validateDropdownField(measurementUnits, 'measurementUnits');
            });
          },
          errorText: errors['measurementUnits'],
        ),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError(
          'Measurement Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
              validate.validateDropdownField(measurementUnits, 'measurementUnits');
            });
          },
          errorText: errors['measurementUnits'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/1/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Power Rail (H)",
          hintText: "Height ",
          imagePath: 'assets/Measurements/1/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Roller Wheel (A1)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/1/A1.png',
          controller: aDiameter,
          subHint: "(Diameter)",
          errorText: errors['aDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Roller Wheel (B1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/1/B1.png',
          controller: bWidth,
          subHint: "(Width)",
          errorText: errors['bWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Link (D1)",
          hintText: "Thickness",
          imagePath: 'assets/Measurements/1/D1.png',
          controller: dThickness,
          subHint: "(Thickness)",
          errorText: errors['dThickness'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Roller Wheel Pitch (M1)",
          hintText: " Inside of Left Roller to Inside of Right Roller",
          imagePath: 'assets/Measurements/1/M1.png',
          controller: mInside,
          subHint: "(Inside of Left Roller to Inside of Right Roller)",
          errorText: errors['mInside'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Roller Pin (Y1)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/1/Y1.png',
          controller: yDiameter,
          subHint: "(Diameter)",
          errorText: errors['yDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "CC5 Roller Pin (Z1)",
          hintText: "Length",
          imagePath: 'assets/Measurements/1/Z1.png',
          controller: zLength,
          subHint: "(Length)",
          errorText: errors['zLength'],
        ),
      ],
    );
  }

  Future<VoidCallback?> addMLCC5CL(int numRequested) async {
    if (validForm()) {
      dynamic mlData = {
        'conveyorName': conveyorSystem.text,
        'cc5ChainSize': conveyorChainSize,
        'industrialChainManufacturer': chainManufacturer,
        'otherChainManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': conveyorLengthUnit,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': conveyorSpeedUnit,
        'conveyorIndex': conveyorIndex.text,
        'travelDirection': directionOfTravel,
        'appEnviroment': applicationEnvironment,
        'surroundingTemp': surroundingTemp,
        'strandStatus': conveyorStrand,
        'operatingVoltage': operatingVoltage.text,
        'highRollerStatus': highRollers,
        'outboardStatus': outboardWheels,
        'cleanChain': conveyorClean,
        'wireMeasurementUnit': measurementUnits,
        'conductor2': conductor2.text,
        'conductor4': conductor4.text,
        'conductor7': conductor7.text,
        'specialControllerOptions': specialOptions.text,
        "coeLineG": gWidth.text,
        "coeLineH": hHeight.text,
        "coeLinea": aDiameter.text,
        "coeLineb": bWidth.text,
        "coeLined": dThickness.text,
        "coeLinem": mInside.text,
        "coeLiney": yDiameter.text,
        "coeLinez": zLength.text,
        "templateA": templateAData
      };
      status = await FormAPI().addOrder("CC5_CL", mlData, numRequested);
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
