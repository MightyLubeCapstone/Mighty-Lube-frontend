import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/CLS%20(2)/products.dart';
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
  final TextEditingController conductor12 = TextEditingController();

  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController sCenter = TextEditingController();
  final TextEditingController kDiameter = TextEditingController();
  final TextEditingController lWidth = TextEditingController();
  final TextEditingController mDiameter = TextEditingController();
  final TextEditingController nTop = TextEditingController();
  final TextEditingController s2Center = TextEditingController();


  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? surroundingTemp = -1;
  int? conveyorLoaded = -1;
  int? conveyorSwing = -1;
  int? measurementUnits = -1;
  int? existingMonitoring = -1;

  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
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
      'surroundingTemp',
      'conveyorLoaded',
      'conveyorSwing',
    ],
    'Customer Power Utilities': ['operatingVoltage'],
    'New/Existing Monitoring System': [],
    'Conveyor Specifications': [],
    'Controller': [],
    'Wire': [
      'conductor4',
      'conductor7',
      'conductor2',
      'conductor12',
    ],
    'Measurements': ['measurementUnits','bDiameter','gWidth','hHeight','sCenter','kDiameter','lWidth','mDiameter','nTop','s2Center'],
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

    bDiameter.dispose();
    gWidth.dispose();
    hHeight.dispose();
    sCenter.dispose();
    kDiameter.dispose();
    lWidth.dispose();
    mDiameter.dispose();
    nTop.dispose();
    s2Center.dispose();
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
    validate .validateDropdownField(
        chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(
        conveyorLengthUnit, 'conveyorLengthUnit');
    validate.validateDropdownField(
        conveyorSpeedUnit, 'conveyorSpeedUnit');
    validate.validateTextField(operatingVoltage.text, 'operatingVoltage');
    validate.validateTextField(conductor4.text, 'conductor4');
    validate.validateTextField(conductor7.text, 'conductor7');
    validate.validateTextField(conductor2.text, 'conductor2');

    validate.validateDropdownField(measurementUnits, 'measurementUnits');
    validate.validateTextField(bDiameter.text, 'bDiameter');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(sCenter.text, 'sCenter');
    validate.validateTextField(kDiameter.text, 'kDiameter');
    validate.validateTextField(lWidth.text, 'lWidth');
    validate.validateTextField(mDiameter.text, 'mDiameter');
    validate.validateTextField(nTop.text, 'nTop');
    validate.validateTextField(s2Center.text, 's2Center');

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
                'New/Existing Monitoring System',
                buildNewMonitoringSystem(),
                isError:
                    validate.sectionError('New/Existing Monitoring System'),
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
                'Wire',
                buildWire(),
                isError: validate.sectionError('Wire'),
              ),
              CommonWidgets.buildGradientButton(
                context,
                'Measurements',
                buildMeasurements(),
                isError: validate
                    .sectionError('Measurements'),
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
        CommonWidgets.buildTextField('Enter Name of Conveyor System',
          conveyorSystem,
          errorText: errors['conveyorSystem'],
        ),
        CommonWidgets.buildDropdownFieldError('Chain Manufacturer',
          [
            'Webb',
            'Richard-Wilcox',
            'Rapid',
            'Pacline',
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
        CommonWidgets.buildTextField('Enter Conveyor Length',
          conveyorLength,
          errorText: errors['conveyorLength'],
        ),
        CommonWidgets.buildDropdownFieldError( 'Conveyor Length Unit',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeters'],
          conveyorLengthUnit,
          (value) {
            setState(() {
              conveyorLengthUnit = value;
              validate.validateDropdownField(
                  conveyorLengthUnit, 'conveyorLengthUnit');
            });
          },
        ),
        CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max)',
          conveyorSpeed,
          errorText: errors['conveyorSpeed'],
        ),
        CommonWidgets.buildDropdownFieldError('Conveyor Speed Unit',
          ['Feet/Minute', 'Meters/Minute'],
          conveyorSpeedUnit,
          (value) {
            setState(() {
              conveyorSpeedUnit = value;
              validate.validateDropdownField(
                  conveyorSpeedUnit, 'conveyorSpeedUnit');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Direction of Travel',
          ['Right to Left', 'Left to Right'],
          directionOfTravel,
          (value) {
            setState(() {
              directionOfTravel = value;
              validate.validateDropdownField(
                  directionOfTravel, 'directionOfTravel');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Application Environment',
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
              validate.validateDropdownField(
                  applicationEnvironment, 'applicationEnvironment');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          ['Yes', 'No'],
          surroundingTemp,
          (value) {
            setState(() {
              surroundingTemp = value;
              validate.validateDropdownField(
                  surroundingTemp, 'surroundingTemp');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          ['Unloaded', 'Loaded'],
          conveyorLoaded,
          (value) {
            setState(() {
              conveyorLoaded = value;
              validate.validateDropdownField(conveyorLoaded, 'conveyorLoaded');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
          ['Yes', 'No'],
          conveyorSwing,
          (value) {
            setState(() {
              conveyorSwing = value;
              validate.validateDropdownField(conveyorSwing, 'conveyorSwing');
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
          'Enter Operating Voltage - Single Phase: (Volts/hz)',
          operatingVoltage,
          errorText: errors['operatingVoltage'],
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
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Add New Monitoring System',
          ['Yes', 'No'],
          null,
          (value) {
            setState(() {
              // Handle value
            });
          },
        ),
        CommonWidgets.buildSectionDivider(),
        if (existingMonitoring == 1) CommonWidgets.buildTemplateA(templateAKey, validate),
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
          null,
          (value) {
            setState(() {
              // Handle value
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Lubrication from the Top of Chain',
          ['Yes', 'No'],
          null,
          (value) {
            setState(() {
              // Handle value
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor Chain Clean?',
          ['Yes', 'No'],
          null,
          (value) {
            setState(() {
              // Handle value
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
          'Measurement Units',
          ['Feet', 'Inches', 'm Meter', 'mm Millimeters'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
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
        CommonWidgets.buildTextField(
          'Enter 12 Conductor Number Here',
          conductor12,
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
          ['Feet', 'Inches', 'm Meter', 'mm Millimeters'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
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
        CommonWidgets.buildTextField(
          'Enter 12 Conductor Number Here',
          conductor12,
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
          title: "Enclosed Track (Inverted) Power Trolley Wheel (B)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/3/CLS/b.png',
          controller: bDiameter,
          subHint: "(Diameter)",
          errorText: errors['bDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/3/CLS/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Power Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/3/CLS/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)",
          hintText: "Center of Power Wheel to Center of Power Wheel",
          imagePath: 'assets/Measurements/3/CLS/S.png',
          controller: sCenter,
          subHint: "(Center of Power Wheel to Center of Power Wheel)",
          errorText: errors['sCenter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Free Trolley Wheel (K2)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/3/CLS/K2.png',
          controller: kDiameter,
          subHint: "(Diameter)",
          errorText: errors['kDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Free Rail (L2)",
          hintText: "Width",
          imagePath: 'assets/Measurements/3/CLS/L2.png',
          controller: lWidth,
          subHint: "(Width)",
          errorText: errors['lWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Free Rail (M2)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/3/CLS/M2.png',
          controller: mDiameter,
          subHint: "(Diameter)",
          errorText: errors['mDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Free Rail Vertical Position (Height) (N2)",
          hintText: "Top of Power Rail to Bottom of Free Rail",
          imagePath: 'assets/Measurements/3/CLS/N2.png',
          controller: nTop,
          subHint: "(Top of Power Rail to Bottom of Free Rail)",
          errorText: errors['nTop'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Inverted) Power Trolley Wheel Pitch (S2)",
          hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
          imagePath: 'assets/Measurements/3/CLS/S2.png',
          controller: s2Center,
          subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
          errorText: errors['s2Center'],
        ),
      
      ],
    );
  }

  VoidCallback? addConfiguration(int numRequested) {
  if (validForm()) {
    dynamic configurationData = {
      'conveyorName': conveyorSystem.text,
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
      'surroundingTemp': surroundingTemp,
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': conveyorSwing,
      'operatingVoltage': operatingVoltage.text,
      'templateB': {
        'newMonitor': null,
      },
      'freeCarrierSystem': null,
      'catDriveStatus': null,
      'catDriveNum': null,
      'externalLubeStatus': null,
      'lubeBrand': null,
      'lubeType': null,
      'lubeViscosity': null,
      'sideLubeStatus': null,
      'chainCleanStatus': null,
      'mightyLubeMonitoring': null,
      'ctrStatus': null,
      'plcConnection': null,
      'monitorControlStatus': null,
      'otherControllerInfo': null,
      'wireMeasurementUnit': measurementUnits,
      'conductor2': conductor2.text,
      'conductor4': conductor4.text,
      'conductor7': conductor7.text,
      'conductor12': conductor12.text,
      'junctionBoxNum': null,
      'enclosedUnitType': null,
      'enclosedTrackB': null,
      'enclosedTrackG': null,
      'enclosedTrackH': null,
      'enclosedTrackS': null,
      'enclosedTrackK2': null,
      'enclosedTrackL2': null,
      'enclosedTrackM2': null,
      'enclosedTrackN2': null,
      'enclosedTrackS2': null,
      "monitorData": templateAKey.currentState?.getData()
    };
    status = FormAPI().addOrder("ETI_9000INVL", configurationData, numRequested);
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
