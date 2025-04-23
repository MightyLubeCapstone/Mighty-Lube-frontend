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
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
  final TextEditingController equipBrand = TextEditingController();
  final TextEditingController currentType = TextEditingController();
  final TextEditingController currentGrade = TextEditingController();
  final TextEditingController specialOptions = TextEditingController();
  final TextEditingController jBox = TextEditingController();
  final TextEditingController conductor12 = TextEditingController();
  final TextEditingController resSize = TextEditingController();
  final TextEditingController optionInfo = TextEditingController();

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
  int? lubricationSide = -1;
  int? lubricationTop = -1;
  int? cleanChain = -1;
  int? measurementUnits = -1;

  final Validators validate = Validators();
  Future<bool>? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'conductor4': null,
    'conductor7': null,
    'conductor2': null,
  };

  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorSystem',
      'conveyorChainSize',
      'chainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
    ],
    'Customer Power Utilities': ['operatingVoltage'],
    'Conveyor Specifications': [
      'lubricationSide',
      'lubricationTop',
      'cleanChain',
    ],
    'Wire': [
      'conductor4',
      'conductor7',
      'conductor2',
    ],
    'Measurements':['measurementUnits','gWidth','hHeight','a1Diameter','b1Width','h1Width','j1Thickness','m1Inside','p1Outside','r1Center','l1Flat','n1Width']
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
    conductor4.dispose();
    conductor7.dispose();
    conductor2.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    specialOptions.dispose();
    jBox.dispose();
    conductor12.dispose();
    resSize.dispose();
    optionInfo.dispose();
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
    validate.validateTextField(conductor4.text, 'conductor4');
    validate.validateTextField(conductor7.text, 'conductor7');
    validate.validateTextField(conductor2.text, 'conductor2');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField( chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(lubricationSide, 'lubricationSide');
    validate.validateDropdownField(lubricationTop, 'lubricationTop');
    validate.validateDropdownField(cleanChain, 'cleanChain');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');
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
                'Wire',
                buildWire(),
                isError: validate.sectionError('Wire'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Measurements',
                buildMeasurements(),
                isError: validate.sectionError('Measurements'),
              ),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addMLCELConfiguration(value);
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
            'X348 Chain (3”)',
            'X458 Chain (4”)',
            'OX678 Chain (6”)',
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
        ),
        CommonWidgets.buildDropdownFieldError(
          'Chain Manufacturer',
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
          chainManufacturer,
          (value) {
            setState(() {
              chainManufacturer = value;
              validate.validateDropdownField(
                  chainManufacturer, 'chainManufacturer');
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
        CommonWidgets.buildDropdownFieldError(
          'Lubrication from the Side of Chain',
          ['Yes', 'No'],
          lubricationSide,
          (value) {
            setState(() {
              lubricationSide = value;
              validate.validateDropdownField(
                  lubricationSide, 'lubricationSide');
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
              validate.validateDropdownField(lubricationTop, 'lubricationTop');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Chain Clean?',
          ['Yes', 'No'],
          cleanChain,
          (value) {
            setState(() {
              cleanChain = value;
              validate.validateDropdownField(cleanChain, 'cleanChain');
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
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
              validate.validateDropdownField(
                  measurementUnits, 'measurementUnits');
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Enter 4 Conductor Number Here',
          conductor4,
          errorText: errors['conductor4'],
        ),
        CommonWidgets.buildTextField(
          'Enter 7 Conductor Number Here',
          conductor7,
          errorText: errors['conductor7'],
        ),
        CommonWidgets.buildTextField(
          'Enter 2 Conductor Number Here',
          conductor2,
          errorText: errors['conductor2'],
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

  VoidCallback? addMLCELConfiguration(int numRequested) {
    if (validForm()) {
      dynamic mlcelData = {
        'conveyorSystem': conveyorSystem.text,
        'conveyorChainSize': conveyorChainSize,
        'chainManufacturer': chainManufacturer,
        'conveyorLength': conveyorLength.text,
        'conveyorSpeed': conveyorSpeed.text,
        'operatingVoltage': operatingVoltage.text,
        'lubricationSide': lubricationSide,
        'lubricationTop': lubricationTop,
        'cleanChain': cleanChain,
        'measurementUnits': measurementUnits,
        'conductor4': conductor4.text,
        'conductor7': conductor7.text,
        'conductor2': conductor2.text,
      };
      status = FormAPI().addOrder("mlcel", mlcelData, numRequested);
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
