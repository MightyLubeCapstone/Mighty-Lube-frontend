import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/5.%20FT(4)/CLS%20(3)/products.dart';
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
  final TextEditingController otherInfo = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();

  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController a1Diameter = TextEditingController();
  final TextEditingController b1Width = TextEditingController();
  final TextEditingController h1Width = TextEditingController();
  final TextEditingController j1Thickness = TextEditingController();
  final TextEditingController l1Flat = TextEditingController();
  final TextEditingController m1Inside = TextEditingController();
  final TextEditingController n1Width = TextEditingController();
  final TextEditingController p1Outside = TextEditingController();
  final TextEditingController r1Center = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? conveyorStrand = -1;
  int? measurementUnits = -1;
  int? existingMonitoring = -1;

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};
  final GlobalKey<TemplateFWidgetState> templateFKey = GlobalKey();
  bool? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'equipBrand': null,
    'currentType': null,
    'currentGrade': null,
  };

  // Sections map
  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'conveyorChainSize',
      'chainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
      'directionOfTravel',
      'applicationEnvironment',
    ],
    'Customer Power Utilities': ['operatingVoltage'],
    'Conveyor Specifications': [
      'equipBrand',
      'currentType',
      'currentGrade',
    ],
    'Controller': [
      'otherInfo',
      'specialOptions',
    ],
    'Measurements': [
      'measurementUnits',
      'gWidth',
      'hHeight',
      'a1Diameter',
      'b1Width',
      'h1Width',
      'j1Thickness',
      'l1Flat',
      'm1Inside',
      'n1Width',
      'p1Outside',
      'r1Center',
    ],
  };

  @override
  void initState() {
    super.initState();
    conveyorSystem.addListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorSystem');
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
    operatingVoltage.addListener(() {
      validate.onNameOpChanged(operatingVoltage.text, 'operatingVoltage');
      setState(() {});
    });
  }

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    operatingVoltage.dispose();
    otherInfo.dispose();
    specialOptions.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    gWidth.dispose();
    hHeight.dispose();
    a1Diameter.dispose();
    b1Width.dispose();
    h1Width.dispose();
    j1Thickness.dispose();
    l1Flat.dispose();
    m1Inside.dispose();
    n1Width.dispose();
    p1Outside.dispose();
    r1Center.dispose();
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
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(currentType.text, 'currentType');
    validate.validateTextField(currentGrade.text, 'currentGrade');
    validate.validateTextField(otherInfo.text, 'otherInfo');
    validate.validateTextField(specialOptions.text, 'specialOptions');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(a1Diameter.text, 'a1Diameter');
    validate.validateTextField(b1Width.text, 'b1Width');
    validate.validateTextField(h1Width.text, 'h1Width');
    validate.validateTextField(j1Thickness.text, 'j1Thickness');
    validate.validateTextField(l1Flat.text, 'l1Flat');
    validate.validateTextField(m1Inside.text, 'm1Inside');
    validate.validateTextField(n1Width.text, 'n1Width');
    validate.validateTextField(p1Outside.text, 'p1Outside');
    validate.validateTextField(r1Center.text, 'r1Center');
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
          const CLSProducts(),
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
                'Flat Top: Measurements',
                buildMeasurements(),
                isError: validate.sectionError('Measurements'),
              ),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addOP40EConfiguration(value);
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
          'Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            '3/8" Log Chain',
            'Other',
          ],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value;
              validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
            });
          },
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
            'Other',
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
              validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        CommonWidgets.buildTextField(
          'Conveyor Speed (Min/Max)',
          conveyorSpeed,
          errorText: errors['conveyorSpeed'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Direction of Travel',
          ['Right to Left', 'Left to Right'],
          directionOfTravel,
          (value) {
            setState(() {
              directionOfTravel = value;
              validate.validateDropdownField(directionOfTravel, 'directionOfTravel');
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
              validate.validateDropdownField(applicationEnvironment, 'applicationEnvironment');
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
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Enter Rail Lubrication Equipment (Brand)',
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
          'Enter Other Information',
          otherInfo,
          errorText: errors['otherInfo'],
        ),
        CommonWidgets.buildTextField(
          'Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          specialOptions,
          errorText: errors['specialOptions'],
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
          title: "Flat Top Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Power Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/5/CGS/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel (A1)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/5/CGS/A1.png',
          controller: a1Diameter,
          subHint: "(Diameter)",
          errorText: errors['a1Diameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel (B1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/B1.png',
          controller: b1Width,
          subHint: "(Width)",
          errorText: errors['b1Width'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Sleeve (H1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/H1.png',
          controller: h1Width,
          subHint: "(Width)",
          errorText: errors['h1Width'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Rail (J1)",
          hintText: "Thickness",
          imagePath: 'assets/Measurements/5/CGS/J1.png',
          controller: j1Thickness,
          subHint: "(Thickness)",
          errorText: errors['j1Thickness'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Double Chain Pitch (L1)",
          hintText: "Center of Chain to Center of Chain",
          imagePath: 'assets/Measurements/5/CGS/L1.png',
          controller: l1Flat,
          subHint: "(Center of Chain to Center of Chain)",
          errorText: errors['l1Flat'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel Pitch (M1)",
          hintText: "Inside of Left Roller to Inside of Right Roller",
          imagePath: 'assets/Measurements/5/CGS/M1.png',
          controller: m1Inside,
          subHint: "(Inside of Left Roller to Inside of Right Roller)",
          errorText: errors['m1Inside'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Mounting Plate (N1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/N1.png',
          controller: n1Width,
          subHint: "(Width)",
          errorText: errors['n1Width'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Rail Pitch (P1)",
          hintText: "Outside of Left Rail to Outside of Right Rail",
          imagePath: 'assets/Measurements/5/CGS/P1.png',
          controller: p1Outside,
          subHint: "(Outside of Left Rail to Outside of Right Rail)",
          errorText: errors['p1Outside'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Double Strand Pitch (R1)",
          hintText: "Center of Strand to Center of Strand",
          imagePath: 'assets/Measurements/5/CGS/R1.png',
          controller: r1Center,
          subHint: "(Center of Strand to Center of Strand)",
          errorText: errors['r1Center'],
        ),
      ],
    );
  }

  Future<VoidCallback?> addOP40EConfiguration(int numRequested) async {
    if (validForm()) {
      dynamic op40eData = {
        'conveyorName': conveyorSystem.text,
        'chainSize': conveyorChainSize,
        'industrialChainManufacturer': chainManufacturer,
        'otherIndustrialChainManufacturer': null,
        'wheelManufacturer': null,
        'otherWheelManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': null,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': null,
        'conveyorIndex': null,
        'travelDirection': directionOfTravel,
        'appEnviroment': applicationEnvironment,
        'ovenStatus': null,
        'ovenTemp': null,
        'surroundingTemp': null,
        'conveyorLoaded': null,
        'conveyorSwing': null,
        'strandStatus': null,
        'plantLayout': null,
        'requiredPics': null,
        'operatingVoltage': operatingVoltage.text,
        'wheelOpenType': null,
        'wheelClosedType': null,
        'openStatus': null,
        'freeWheelStatus': null,
        'guideRollerStatus': null,
        'openRaceStyleType': null,
        'closedRaceStyleType': null,
        'holeStatus': null,
        'actuatorStatus': null,
        'pivotStatus': null,
        'kingPinStatus': null,
        'outboardStatus': null,
        'lubeBrand': equipBrand.text,
        'lubeType': currentType.text,
        'lubeViscosity': currentGrade.text,
        'chainMaster': null,
        'timerStatus': null,
        'electricStatus': null,
        'pneumaticStatus': null,
        'mightyLubeMonitoring': null,
        'plcConnection': null,
        'otherControllerInfo': otherInfo.text,
        'ftUnitType': null,
        'ftTopG': gWidth.text,
        'ftTopH': hHeight.text,
        'ftTopA1': a1Diameter.text,
        'ftTopB1': b1Width.text,
        'ftTopH1': h1Width.text,
        'ftTopJ1': j1Thickness.text,
        'ftTopL1': l1Flat.text,
        'ftTopM1': m1Inside.text,
        'ftTopN1': n1Width.text,
        'ftTopP1': p1Outside.text,
        'ftTopR1': r1Center.text,
        "templateA": templateAData,
        //"templateF": templateFData
      };
      status = await FormAPI().addOrder("FT_OP4OE", op40eData, numRequested);
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
