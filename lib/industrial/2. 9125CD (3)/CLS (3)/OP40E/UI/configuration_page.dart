import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/industrial/2.%209125CD%20(3)/CLS%20(3)/products.dart';
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
  final TextEditingController otherInfo = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();

  final TextEditingController aTop = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController jWidth = TextEditingController();
  final TextEditingController xWidth = TextEditingController();
  final TextEditingController yThickness = TextEditingController();
  final TextEditingController zInside = TextEditingController();

  // Dropdown values
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

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};
  final GlobalKey<TemplateDWidgetState> templateDKey = GlobalKey();
  Map<String, dynamic> templateDData = {};
  final GlobalKey<TemplateFWidgetState> templateFKey = GlobalKey();
  Map<String, dynamic> templateFData = {};

  bool? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'chainManufacturer': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'existingMonitoring': null,
    'measurementUnit': null,
  };

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
    "Measurements": [
      'measurementUnits',
      'aTop',
      'gWidth',
      'hHeight',
      'jWidth',
      'xWidth',
      'yThickness',
      'zInside'
    ],
  };

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
    conveyorSystem.dispose();
    operatingVoltage.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    otherInfo.dispose();
    specialOptions.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    aTop.dispose();
    gWidth.dispose();
    hHeight.dispose();
    jWidth.dispose();
    xWidth.dispose();
    yThickness.dispose();
    zInside.dispose();
    super.dispose();
  }

  bool validForm() {
    validate.mapErrors(errors);
    validate.mapSections(sections);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorSystem.text, 'conveyorSystem');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateDropdownField(existingMonitoring, 'existingMonitoring');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');

    validate.validateTextField(aTop.text, 'aTop');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(jWidth.text, 'jWidth');
    validate.validateTextField(xWidth.text, 'xWidth');
    validate.validateTextField(yThickness.text, 'yThickness');
    validate.validateTextField(zInside.text, 'zInside');

    setState(() {});

    errors = Map<String, String?>.from(validate.errors);
    print(errors);
  }

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
                  context, 'New/Existing Monitoring System', buildNewMonitoringSystem(),
                  isError: validate.sectionError('New/Existing Monitoring System')),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError('Conveyor Specifications')),
              CommonWidgets.buildGradientButton(context, 'Controller', buildController(),
                  isError: validate.sectionError('Controller')),
              CommonWidgets.buildGradientButton(context, 'Measurements', buildMeasurements(),
                  isError: validate.sectionError('Measurements')),
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

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Name of Conveyor System *',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        if (errors['conveyorSystem'] != null) buildErrorText(errors['conveyorSystem']!),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          ['CC5 3”', 'CC5 4”', 'CC5 6”', 'RC60', 'RC80', 'RC 2080', 'RC 2060', 'Other'],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value;
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
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Conveyor Speed (Min/Max)',
          conveyorSpeed,
          errorText: errors['conveyorSpeed'],
        ),
        if (errors['conveyorSpeed'] != null) buildErrorText(errors['conveyorSpeed']!),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Speed Unit',
          ['Feet/Minute', 'Meters/Minute'],
          conveyorSpeedUnit,
          (value) {
            setState(() {
              conveyorSpeedUnit = value;
            });
          },
        ),
        CommonWidgets.buildTextField('Indexing or Variable Speed Conditions', conveyorIndex),
        CommonWidgets.buildDropdownFieldError(
          'Direction of Travel',
          ['Right to Left', 'Left to Right'],
          directionOfTravel,
          (value) {
            setState(() {
              directionOfTravel = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Application Environment',
          [
            'Ambient',
            'Caustic (i.e. Phosphate/E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other'
          ],
          applicationEnvironment,
          (value) {
            setState(() {
              applicationEnvironment = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          ['Yes', 'No'],
          temperatureOfSurroundingArea,
          (value) {
            setState(() {
              temperatureOfSurroundingArea = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is Conveyor Single or Double Strand',
          ['Single', 'Double'],
          conveyorSingleDouble,
          (value) {
            setState(() {
              conveyorSingleDouble = value;
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Operating Voltage - 3 Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
        ),
        if (errors['operatingVoltage'] != null) buildErrorText(errors['operatingVoltage']!),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New Monitoring System or Adding to Existing Monitoring System',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Connecting to Existing Monitoring',
          ['Yes', 'No'],
          existingMonitoring,
          (value) {
            setState(() {
              existingMonitoring = value;
              validate.validateDropdownField(
                existingMonitoring,
                'existingMonitoring',
              );
            });
          },
          errorText: errors['existingMonitoring'],
        ),
        CommonWidgets.buildSectionDivider(),
        if (existingMonitoring == 1) ...[
          CommonWidgets.buildTemplateA(templateAKey, validate,
            data: templateAData,
            callback: (data) {
              templateAData = data;
            },
          ),
          CommonWidgets.buildTemplateD(templateDKey, validate,
            data: templateDData,
            callback: (data) {
              templateDData = data;
            },
          ),
          CommonWidgets.buildTemplateF(templateFKey, validate,
            data: templateFData,
            callback: (data) {
              templateFData = data;
            },
          ),
        ],
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Outboard Wheels',
          ['Yes', 'No'],
          outboardWheels,
          (value) {
            setState(() {
              outboardWheels = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'High Rollers',
          ['Yes', 'No'],
          highRollers,
          (value) {
            setState(() {
              highRollers = value;
            });
          },
        ),
        CommonWidgets.buildTextField('Enter Rail Lubrication Equipment (Brand)', equipBrand),
        CommonWidgets.buildTextField('Enter Current Lubricant Type', currentType),
        CommonWidgets.buildTextField('Enter Current Lubricant Viscosity/Grade', currentGrade),
        CommonWidgets.buildDropdownFieldError(
          'Lubrication from the Side of Chain',
          ['Yes', 'No'],
          lubricationSide,
          (value) {
            setState(() {
              lubricationSide = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Lubrication from the Top of Chain',
          ['Yes', 'No'],
          lubricationTop,
          (value) {
            setState(() {
              lubricationTop = value;
            });
          },
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
        CommonWidgets.buildDropdownFieldError(
          'ChainMaster Controller',
          ['Yes', 'No'],
          chainMasterController,
          (value) {
            setState(() {
              chainMasterController = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Timer',
          ['Not Required', '12 Hour', '1000 Hour'],
          timer,
          (value) {
            setState(() {
              timer = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Electric On/Off',
          ['On', 'Off'],
          electricOnOff,
          (value) {
            setState(() {
              electricOnOff = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Pneumatic On/Off',
          ['On', 'Off'],
          pneumaticOnOff,
          (value) {
            setState(() {
              pneumaticOnOff = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Mighty Lube Monitoring',
          ['Yes', 'No'],
          mightyLubeMonitoring,
          (value) {
            setState(() {
              mightyLubeMonitoring = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'PLC Connection',
          ['Yes', 'No'],
          plcConnection,
          (value) {
            setState(() {
              plcConnection = value;
            });
          },
        ),
        CommonWidgets.buildTextField('Enter Other Information', otherInfo),
        CommonWidgets.buildTextField(
          'Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          specialOptions,
        ),
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
          title: "Chain on Edge Drag Line Chain Drop (A)",
          hintText: "Top of Rail to Center of Chain",
          imagePath: 'assets/Measurements/2/A.png',
          controller: aTop,
          subHint: "(Top of Rail to Center of Chain)",
          errorText: errors['aTop'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drag Line Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/2/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drag Line Power Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/2/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drag Line Rail Offset (J)",
          hintText: "Inside of Rail Channel to Inside of Rail Channel",
          imagePath: 'assets/Measurements/2/J.png',
          controller: jWidth,
          subHint: "(Inside of Rail Channel to Inside of Rail Channel)",
          errorText: errors['jWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drain Line Wear Bar (X)",
          hintText: "Width",
          imagePath: 'assets/Measurements/2/X.png',
          controller: xWidth,
          subHint: "(Width)",
          errorText: errors['xWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drag Line Wear Bar (Y)",
          hintText: "Thickness",
          imagePath: 'assets/Measurements/2/Y.png',
          controller: yThickness,
          subHint: "(Thickness)",
          errorText: errors['yThickness'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Chain on Edge Drag Line Wear Bar Offset (Z)",
          hintText: "Inside Edge of Rail to Inside Edge of Wear Bar",
          imagePath: 'assets/Measurements/2/Z_OP40E.png',
          controller: zInside,
          subHint: "(Inside Edge of Rail to Inside Edge of Wear Bar)",
          errorText: errors['zInside'],
        ),
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

  Future<VoidCallback?> addOP40E(int numRequested) async {
    if (validForm()) {
      dynamic opData = {
        'conveyorName': conveyorSystem.text,
        'chainSize': conveyorChainSize,
        'industrialChainManufacturer': chainManufacturer,
        'otherIndustrialChainManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': conveyorLengthUnit,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': conveyorSpeedUnit,
        'conveyorIndex': conveyorIndex.text,
        'travelDirection': directionOfTravel,
        'appEnviroment': applicationEnvironment,
        'ovenStatus': null,
        'ovenTemp': null,
        'surroundingTemp': temperatureOfSurroundingArea,
        'conveyorLoaded': null,
        'conveyorSwing': null,
        'plantLayout': null,
        'requiredPics': null,
        'operatingVoltage': operatingVoltage.text,
        'wheelOpenType': null,
        'wheelClosedType': null,
        'openStatus': null,
        'catDriveStatus': null,
        'railLubeStatus': lubricationSide,
        'externalLubeStatus': lubricationTop,
        'lubeBrand': equipBrand.text,
        'lubeType': currentType.text,
        'lubeViscosity': currentGrade.text,
        'chainMaster': chainMasterController,
        'timerStatus': timer,
        'electricStatus': electricOnOff,
        'pneumaticStatus': pneumaticOnOff,
        'mightyLubeMonitoring': mightyLubeMonitoring,
        'plcConnection': plcConnection,
        'otherControllerInfo': otherInfo.text,
        'specialControllerOptions': specialOptions.text,
        'coeUnitType': null,
        'coeLineA': aTop.text,
        'coeLineG': gWidth.text,
        'coeLineH': hHeight.text,
        'coeLineJ': jWidth.text,
        'coeLineX': xWidth.text,
        'coeLineY': yThickness.text,
        'coeLineZ': zInside.text,
        "templateA": templateAData,
        "templateD": templateDData,
        "templateF": templateFData,
      };
      status = await FormAPI().addOrder("COE_OP4OE", opData, numRequested);
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
