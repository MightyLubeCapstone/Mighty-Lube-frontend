import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/6.%20FC%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
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
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController chainMaster = TextEditingController();
  final TextEditingController optionalInfo = TextEditingController();
  final TextEditingController compAir = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();

  final TextEditingController eCenter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController kCenter = TextEditingController();
  final TextEditingController tLead = TextEditingController();
  final TextEditingController uLoad = TextEditingController();
  final TextEditingController vLoad = TextEditingController();
  final TextEditingController wOutside = TextEditingController();

  // Dropdown values
  int? wheelManufacturer = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorType = -1;
  int? compressedAirUnit = -1;
  int? freeTrolleyWheels = -1;
  int? dogActuator = -1;
  int? pivotPoints = -1;
  int? kingPin = -1;
  int? zerkLocationSide = -1;
  int? zerkLocationOrientation = -1;
  int? remote = -1;
  int? mountedOnGreaser = -1;
  int? controlsOtherUnits = -1;
  int? timer = -1;
  int? electricOnOff = -1;
  int? pneumaticOnOff = -1;
  int? mightyLubeMonitoring = -1;
  int? plcConnection = -1;
  int? measurementUnits = -1;
  int? existingMonitoring = -1;

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};
  bool? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'equipBrand': null,
    'currentType': null,
    'currentGrade': null,
    'greaseType': null,
    'greaseGrade': null,
  };

  // Sections map
  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'wheelManufacturer',
      'conveyorSpeed',
      'conveyorSpeedUnit',
      'directionOfTravel',
      'applicationEnvironment',
      'surroundingTemp',
      'conveyorType',
    ],
    'Customer Power Utilities': [
      'operatingVoltage',
      'compAir',
      'compressedAirUnit',
    ],
    'New/Existing Monitoring System': [],
    'Conveyor Specifications': [
      'freeTrolleyWheels',
      'dogActuator',
      'pivotPoints',
      'kingPin',
      'equipBrand',
      'currentType',
      'currentGrade',
      'greaseType',
      'greaseGrade',
      'zerkLocationSide',
      'zerkLocationOrientation',
    ],
    'Controller': [
      'chainMaster',
      'remote',
      'mountedOnGreaser',
      'controlsOtherUnits',
      'timer',
      'electricOnOff',
      'pneumaticOnOff',
      'mightyLubeMonitoring',
      'plcConnection',
      'optionalInfo',
    ],
    'Greaser Free Carrier: Measurements': [
      'measurementUnits',
      'eCenter',
      'gWidth',
      'hHeight',
      'kCenter',
      'tLead',
      'uLoad',
      'vLoad',
      'wOutside',
    ],
  };

  @override
  void initState() {
    super.initState();
    conveyorSystem.addListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorSystem');
      setState(() {});
    });
    conveyorSpeed.addListener(() {
      validate.onNameOpChanged(conveyorSpeed.text, 'conveyorSpeed');
      setState(() {});
    });
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
  }

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    operatingVoltage.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    chainMaster.dispose();
    optionalInfo.dispose();
    compAir.dispose();
    greaseType.dispose();
    greaseGrade.dispose();

    eCenter.dispose();
    gWidth.dispose();
    hHeight.dispose();
    kCenter.dispose();
    tLead.dispose();
    uLoad.dispose();
    vLoad.dispose();
    wOutside.dispose();
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
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(currentType.text, 'currentType');
    validate.validateTextField(currentGrade.text, 'currentGrade');
    validate.validateTextField(greaseType.text, 'greaseType');
    validate.validateTextField(greaseGrade.text, 'greaseGrade');
    validate.validateTextField(eCenter.text, 'eCenter');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(kCenter.text, 'kCenter');
    validate.validateTextField(tLead.text, 'tLead');
    validate.validateTextField(uLoad.text, 'uLoad');
    validate.validateTextField(vLoad.text, 'vLoad');
    validate.validateTextField(wOutside.text, 'wOutside');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
          context,
          '>',
          const ApplicationPage(),
          'Products',
          const FCProducts(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(
                context,
                'General Information',
                buildGeneralInformationContent(),
                isError: validate.sectionError('General Information'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Customer Power Utilities',
                buildCustomerPowerUtilitiesContent(),
                isError: validate.sectionError('Customer Power Utilities'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'New/Existing Monitoring System',
                buildNewMonitoringSystem(),
                isError: validate.sectionError('New/Existing Monitoring System'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Conveyor Specifications',
                buildConveyorSpecifications(),
                isError: validate.sectionError('Conveyor Specifications'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Controller',
                buildController(),
                isError: validate.sectionError('Controller'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Greaser Free Carrier: Measurements',
                buildMeasurements(),
                isError: validate.sectionError('Greaser Free Carrier: Measurements'),
              ),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addFR314Configuration(value);
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
          'Enter Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Wheel Manufacturer',
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
            'Other',
          ],
          wheelManufacturer,
          (value) {
            setState(() {
              wheelManufacturer = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Speed (Min/Max)',
          conveyorSpeed,
          errorText: errors['conveyorSpeed'],
        ),
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
            'Other',
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
          surroundingTemp,
          (value) {
            setState(() {
              surroundingTemp = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          ['Overhead', 'Inverted', 'Inverted/Inverted'],
          conveyorType,
          (value) {
            setState(() {
              conveyorType = value;
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
        CommonWidgets.buildTextField(
          'Enter Compressed Air Supply',
          compAir,
        ),
        CommonWidgets.buildDropdownFieldError(
          'Compressed Air Supply Unit',
          ['PSI', 'KPI', 'Bar'],
          compressedAirUnit,
          (value) {
            setState(() {
              compressedAirUnit = value;
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
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

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError(
          'Free Trolley Wheels',
          ['Yes', 'No'],
          freeTrolleyWheels,
          (value) {
            setState(() {
              freeTrolleyWheels = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Dog Actuator',
          ['Yes', 'No'],
          dogActuator,
          (value) {
            setState(() {
              dogActuator = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Pivot Points',
          ['Yes', 'No'],
          pivotPoints,
          (value) {
            setState(() {
              pivotPoints = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'King Pin',
          ['Yes', 'No'],
          kingPin,
          (value) {
            setState(() {
              kingPin = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubrication Equipment (Brand)',
          equipBrand,
          errorText: errors['equipBrand'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubricant Type',
          currentType,
          errorText: errors['currentType'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubricant Viscosity/Grade',
          currentGrade,
          errorText: errors['currentGrade'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Grease Type',
          greaseType,
          errorText: errors['greaseType'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Grease NLGI Grade',
          greaseGrade,
          errorText: errors['greaseGrade'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Zerk Fitting Location (Side)',
          ['Left', 'Right'],
          zerkLocationSide,
          (value) {
            setState(() {
              zerkLocationSide = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Zerk Fitting Location (Orientation)',
          ['Center', '12 O-Clock', '3 O-Clock', '6 O-Clock', '9 O-Clock'],
          zerkLocationOrientation,
          (value) {
            setState(() {
              zerkLocationOrientation = value;
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
        CommonWidgets.buildTextField(
          'Enter ChainMaster Controller',
          chainMaster,
        ),
        CommonWidgets.buildDropdownFieldError(
          'Remote',
          ['Yes', 'No'],
          remote,
          (value) {
            setState(() {
              remote = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Mounted on Greaser',
          ['Yes', 'No'],
          mountedOnGreaser,
          (value) {
            setState(() {
              mountedOnGreaser = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Controls Other Units (list)',
          ['Yes', 'No'],
          controlsOtherUnits,
          (value) {
            setState(() {
              controlsOtherUnits = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Timer',
          ['Yes', 'No'],
          timer,
          (value) {
            setState(() {
              timer = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Electric On/Off',
          ['Yes', 'No'],
          electricOnOff,
          (value) {
            setState(() {
              electricOnOff = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Pneumatic On/Off',
          ['Yes', 'No'],
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
        CommonWidgets.buildTextField(
          'Enter Other Details',
          optionalInfo,
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
          title: "Greaser - Free Carrier Zerk Fitting Vertical Location (E)",
          hintText: "Center of Free Trolley Wheel to Zerk Fitting",
          imagePath: 'assets/Measurements/6/314/E.png',
          controller: eCenter,
          subHint: "(Center of Free Trolley Wheel to Zerk Fitting)",
          errorText: errors['eCenter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/6/314/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/6/314/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Trolley Wheel Pitch (K)",
          hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
          imagePath: 'assets/Measurements/6/314/K.png',
          controller: kCenter,
          subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
          errorText: errors['kCenter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Free Rail Carrier Trolley Pitch (T)",
          hintText: "Lead to Load",
          imagePath: 'assets/Measurements/6/314/T.png',
          controller: tLead,
          subHint: "(Lead to Load)",
          errorText: errors['tLead'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Free Rail Carrier Trolley Pitch (U)",
          hintText: "Load to Load",
          imagePath: 'assets/Measurements/6/314/U.png',
          controller: uLoad,
          subHint: "(Load to Load)",
          errorText: errors['uLoad'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Free Rail Carrier Trolley Pitch (V)",
          hintText: "Load to Trailing",
          imagePath: 'assets/Measurements/6/314/V.png',
          controller: vLoad,
          subHint: "(Load to Trailing)",
          errorText: errors['vLoad'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Greaser - Free Carrier Free Rail Carrier Trolley Pitch (W)",
          hintText: "Outside to Outside",
          imagePath: 'assets/Measurements/6/314/W.png',
          controller: wOutside,
          subHint: "(Outside to Outside)",
          errorText: errors['wOutside'],
        ),
      ],
    );
  }

  Future<VoidCallback?> addFR314Configuration(int numRequested) async {
    if (validForm()) {
      dynamic fr314Data = {
        'conveyorName': conveyorSystem.text,
        'wheelManufacturer': wheelManufacturer,
        'otherWheelManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': null,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': conveyorSpeedUnit,
        'travelDirection': directionOfTravel,
        'appEnviroment': applicationEnvironment,
        'ovenStatus': null,
        'ovenTemp': null,
        'surroundingTemp': surroundingTemp,
        'conveyorSwing': null,
        'orientation': conveyorType,
        'operatingVoltage': operatingVoltage.text,
        'controlVoltage': null,
        'compressedAir': compAir.text,
        'airSupply': compressedAirUnit,
        'freeWheelStatus': freeTrolleyWheels,
        'actuatorStatus': dogActuator,
        'pivotStatus': pivotPoints,
        'kingPinStatus': kingPin,
        'lubeBrand': equipBrand.text,
        'lubeType': currentType.text,
        'lubeViscosity': currentGrade.text,
        'currentGrease': greaseType.text,
        'currentGreaseGrade': greaseGrade.text,
        'zerkDirection': zerkLocationOrientation,
        'zerkLocation': zerkLocationSide,
        'chainMaster': chainMaster.text,
        'remoteStatus': remote,
        'mountStatus': mountedOnGreaser,
        'otherUnitStatus': controlsOtherUnits,
        'timerStatus': timer,
        'electricStatus': electricOnOff,
        'pneumaticStatus': pneumaticOnOff,
        'mightyLubeMonitoring': mightyLubeMonitoring,
        'preMountType': null,
        'plcConnection': plcConnection,
        'otherControllerInfo': optionalInfo.text,
        'frUnitType': null,
        'frInvertedB': null,
        'frInvertedE': eCenter.text,
        'frInvertedG': gWidth.text,
        'frInvertedH': hHeight.text,
        'frInvertedK': kCenter.text,
        'frInvertedT': tLead.text,
        'frInvertedU': uLoad.text,
        'frInvertedV': vLoad.text,
        'frInvertedW': wOutside.text,
        "templateA": templateAData
      };
      status = await FormAPI().addOrder("FC_314", fr314Data, numRequested);
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

  buildErrorText(String message) {
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
