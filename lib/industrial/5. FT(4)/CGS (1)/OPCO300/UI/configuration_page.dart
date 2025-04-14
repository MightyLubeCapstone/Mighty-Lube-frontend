import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/5.%20FT(4)/CGS%20(1)/products.dart';
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
  final TextEditingController compressedAir = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController lubricationType = TextEditingController();
  final TextEditingController lubricationGrade = TextEditingController();
  final TextEditingController greaseType = TextEditingController();
  final TextEditingController greaseGrade = TextEditingController();
  final TextEditingController otherInfo = TextEditingController();

  final TextEditingController fOutside = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController a1Diameter = TextEditingController();
  final TextEditingController b1Width = TextEditingController();
  final TextEditingController h1Width = TextEditingController();
  final TextEditingController j1Thickness = TextEditingController();
  final TextEditingController k1Thickness = TextEditingController();
  final TextEditingController l1Flat = TextEditingController();
  final TextEditingController m1Inside = TextEditingController();
  final TextEditingController n1Width = TextEditingController();
  final TextEditingController p1Outside = TextEditingController();
  final TextEditingController r1Center = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? wheelManufacturer = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? conveyorStrand = -1;
  int? compressedAirUnit = -1;
  int? zerkLocation = -1;
  int? zerkOrientation = -1;

  final Validators validate = Validators();
  Future<bool>? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'compressedAir': null,
    'equipBrand': null,
    'lubricationType': null,
    'lubricationGrade': null,
    'greaseType': null,
    'greaseGrade': null,
  };

  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'conveyorChainSize',
      'chainManufacturer',
      'wheelManufacturer',
      'conveyorLength',
      'conveyorLengthUnit',
      'conveyorSpeed',
      'conveyorSpeedUnit',
      'directionOfTravel',
      'applicationEnvironment',
      'surroundingTemp',
      'conveyorLoaded',
      'conveyorSwing',
      'conveyorStrand',
    ],
    'Customer Power Utilities': ['operatingVoltage', 'compressedAir'],
    'Conveyor Specifications': [
      'equipBrand',
      'lubricationType',
      'lubricationGrade',
      'greaseType',
      'greaseGrade',
    ],
    'Controller': ['otherInfo'],
  };

  @override
  void initState() {
    super.initState();
    conveyorSystem.addListener(() {
      validate.onNameOpChanged(conveyorSystem.text, 'conveyorSystem');
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
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    operatingVoltage.dispose();
    compressedAir.dispose();
    equipBrand.dispose();
    lubricationType.dispose();
    lubricationGrade.dispose();
    greaseType.dispose();
    greaseGrade.dispose();
    otherInfo.dispose();
    fOutside.dispose();
    gWidth.dispose();
    hHeight.dispose();
    a1Diameter.dispose();
    b1Width.dispose();
    h1Width.dispose();
    j1Thickness.dispose();
    k1Thickness.dispose();
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
    validate .validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(conveyorLengthUnit, 'conveyorLengthUnit');
    validate.validateDropdownField(conveyorSpeedUnit, 'conveyorSpeedUnit');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(compressedAir.text, 'compressedAir');
    validate.validateTextField(equipBrand.text, 'equipBrand');
    validate.validateTextField(lubricationType.text, 'lubricationType');
    validate.validateTextField(lubricationGrade.text, 'lubricationGrade');
    validate.validateTextField(greaseType.text, 'greaseType');
    validate.validateTextField(greaseGrade.text, 'greaseGrade');
    validate.validateTextField(otherInfo.text, 'otherInfo');
    validate.validateTextField(fOutside.text, 'fOutside');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(a1Diameter.text, 'a1Diameter');
    validate.validateTextField(b1Width.text, 'b1Width');
    validate.validateTextField(h1Width.text, 'h1Width');
    validate.validateTextField(j1Thickness.text, 'j1Thickness');
    validate.validateTextField(k1Thickness.text, 'k1Thickness');
    validate.validateTextField(l1Flat.text, 'l1Flat');
    validate.validateTextField(m1Inside.text, 'm1Inside');
    validate.validateTextField(n1Width.text, 'n1Width');
    validate.validateTextField(p1Outside.text, 'p1Outside');
    validate.validateTextField(r1Center.text, 'r1Center');

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
          const CGSProducts(),
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
              CommonWidgets.buildGradientButton(
                context,
                'Customer Power Utilities',
                buildCustomerPowerUtilitiesContent(),
                isError: validate.sectionError("Customer Power Utilities"),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Conveyor Specifications',
                buildConveyorSpecifications(),
                isError: validate.sectionError("Conveyor Specifications"),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Controller',
                buildController(),
                isError: validate.sectionError("Controller"),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Flat Top: Measurements',
                buildMeasurements(),
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField(
          'Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          [
            'CC5 3”',
            'CC5 4”',
            'CC5 6”',
            'RC60',
            'RC80',
            'RC 2080',
            'RC 2060',
            'Other',
          ],
          conveyorChainSize,
          (value) {
            setState(() {
              conveyorChainSize = value;
              validate.validateDropdownField(
                  conveyorChainSize, 'conveyorChainSize');
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
            'Other',
          ],
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
              validate.validateDropdownField(
                  chainManufacturer, 'chainManufacturer');
            });
          },
          errorText: errors['chainManufacturer'],
        ),
        CommonWidgets.buildTextField(
          'Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value;
              validate.validateDropdownField(
                  conveyorLengthUnit, 'conveyorLengthUnit');
            });
          },
          errorText: errors['conveyorLengthUnit'],
        ),
        CommonWidgets.buildTextField(
          'Conveyor Speed (Min/Max)',
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
              validate.validateDropdownField(
                  conveyorSpeedUnit, 'conveyorSpeedUnit');
            });
          },
          errorText: errors['conveyorSpeedUnit'],
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
          'Enter Operating Voltage - Single Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
        ),
        CommonWidgets.buildTextField(
          'Enter Compressed Air Supply',
          compressedAir,
          errorText: errors['compressedAir'],
        ),
        CommonWidgets.buildDropdownFieldError(
          'Compressed Air Supply Unit',
          ['PSI', 'KPI', 'BAR'],
          compressedAirUnit,
          (value) {
            setState(() {
              compressedAirUnit = value;
              validate.validateDropdownField(
                  compressedAirUnit, 'compressedAirUnit');
            });
          },
          errorText: errors['compressedAirUnit'],
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
          'Enter Current Lubrication Equipment (Brand)',
          equipBrand,
          errorText: errors['equipBrand'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubrication Type',
          lubricationType,
          errorText: errors['lubricationType'],
        ),
        CommonWidgets.buildTextField(
          'Enter Current Lubrication Viscosity/Grade',
          lubricationGrade,
          errorText: errors['lubricationGrade'],
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
          'Other Information',
          otherInfo,
          errorText: errors['otherInfo'],
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Zerk Fitting Horizontal Location (F)",
          hintText: "Outside of Rail ftg. to Zerk ftg.",
          imagePath: 'assets/Measurements/5/CGS/F.png',
          controller: fOutside,
          subHint: "(Outside of Rail ftg. to Zerk ftg.)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/G.png',
          controller: gWidth,
          subHint: "(Width)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Power Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/5/CGS/H.png',
          controller: hHeight,
          subHint: "(Height)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel (A1)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/5/CGS/A1.png',
          controller: a1Diameter,
          subHint: "(Diameter)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel (B1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/B1.png',
          controller: b1Width,
          subHint: "(Width)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Sleeve (H1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/H1.png',
          controller: h1Width,
          subHint: "(Width)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Rail (J1)",
          hintText: "Thickness",
          imagePath: 'assets/Measurements/5/CGS/J1.png',
          controller: j1Thickness,
          subHint: "(Thickness)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Support Plate (K1)",
          hintText: "Thickness",
          imagePath: 'assets/Measurements/5/CGS/K1.png',
          controller: k1Thickness,
          subHint: "(Thickness)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Double Chain Pitch (L1)",
          hintText: "Center of Chain to Center of Chain",
          imagePath: 'assets/Measurements/5/CGS/L1.png',
          controller: l1Flat,
          subHint: "(Center of Chain to Center of Chain)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Roller Wheel Pitch (M1)",
          hintText: "Inside of Left Roller to Inside of Right Roller",
          imagePath: 'assets/Measurements/5/CGS/M1.png',
          controller: m1Inside,
          subHint: "(Inside of Left Roller to Inside of Right Roller)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Mounting Plate (N1)",
          hintText: "Width",
          imagePath: 'assets/Measurements/5/CGS/N1.png',
          controller: n1Width,
          subHint: "(Width)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Rail Pitch (P1)",
          hintText: "Outside of Left Rail to Outside of Right Rail",
          imagePath: 'assets/Measurements/5/CGS/P1.png',
          controller: p1Outside,
          subHint: "(Outside of Left Rail to Outside of Right Rail)",
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Flat Top Double Strand Pitch (R1)",
          hintText: "Center of Strand to Center of Strand",
          imagePath: 'assets/Measurements/5/CGS/R1.png',
          controller: r1Center,
          subHint: "(Center of Strand to Center of Strand)",
        ),
      ],
    );
  }

  VoidCallback? addConfiguration(int numRequested) {
  if (validForm()) {
    dynamic configurationData = {
      'conveyorName': conveyorSystem.text,
      'chainSize': conveyorChainSize,
      'industrialChainManufacturer': chainManufacturer,
      'otherIndustrialChainManufacturer': null,
      'wheelManufacturer': wheelManufacturer,
      'otherWheelManufacturer': null,
      'conveyorLength': conveyorLength.text,
      'conveyorLengthUnit': conveyorLengthUnit,
      'conveyorSpeed': conveyorSpeed.text,
      'conveyorSpeedUnit': conveyorSpeedUnit,
      'conveyorIndex': null,
      'travelDirection': directionOfTravel,
      'appEnviroment': applicationEnvironment,
      'ovenStatus': null,
      'ovenTemp': null,
      'surroundingTemp': surroundingTemp,
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': conveyorSwing,
      'strandStatus': conveyorStrand,
      'plantLayout': null,
      'requiredPics': null,
      'operatingVoltage': operatingVoltage.text,
      'compressedAir': compressedAir.text,
      'compressedAirUnit': compressedAirUnit,
      'templateB': {
        'existingMonitor': null,
        'newMonitor': null,
      },
      'wheelOpenType': null,
      'wheelClosedType': null,
      'openStatus': null,
      'freeWheelStatus': null,
      'guideRollerStatus': null,
      'openRaceStyleType': null,
      'closedRaceStyleType': null,
      'holeStatus': null,
      'rollerChainStatus': null,
      'brushStatus': null,
      'outboardStatus': null,
      'lubeBrand': equipBrand.text,
      'currentLube': lubricationType.text,
      'oilOrGrease': lubricationGrade.text,
      'lubeViscosity': greaseType.text,
      'greaseNGLIGrade': greaseGrade.text,
      'zerkDirection': zerkOrientation,
      'zerkLocationType': zerkLocation,
      'chainMaster': null,
      'remoteStatus': null,
      'mountStatus': null,
      'otherUnitStatus': null,
      'timerStatus': null,
      'electricStatus': null,
      'mightyLubeMonitoring': null,
      'preMountType': null,
      'plcConnection': null,
      'otherControllerInfo': otherInfo.text,
      'ftUnitType': null,
      'ftTopF': fOutside.text,
      'ftTopG': gWidth.text,
      'ftTopH': hHeight.text,
      'ftTopA1': a1Diameter.text,
      'ftTopB1': b1Width.text,
      'ftTopH1': h1Width.text,
      'ftTopJ1': j1Thickness.text,
      'ftTopK1': k1Thickness.text,
      'ftTopL1': l1Flat.text,
      'ftTopM1': m1Inside.text,
      'ftTopN1': n1Width.text,
      'ftTopP1': p1Outside.text,
      'ftTopR1': r1Center.text,
    };
    FormAPI().addOrder("FT_OPCO", configurationData, numRequested);
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
