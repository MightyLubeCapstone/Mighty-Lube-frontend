import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/4.%20ETOPO%20(10)/CLS%20(4)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';
import 'package:mighty_lube/api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count

  // TextEditingControllers for text fields
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();
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
  int? conveyorChainSize;
  int? operatingVoltage = -1;
  int? chainManufacturer;
  int? directionOfTravel;
  int? applicationEnvironment;
  int? conveyorLoaded;
  int? dripLine;
  int? lubricationSide;
  int? lubricationTop;
  int? cleanChain;
  int? measurementUnits;
  int? newMonitorStatus;
  int? driveMotorAmp;
  int? driveTakeUpAir;
  int? takeUpDistance;
  int? driveTemp;
  int? driveVibration;
  int? trolleyDetect;
  int? existingMonitoring = -1;

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  final GlobalKey<TemplateBWidgetState> templateBKey = GlobalKey();
  final GlobalKey<TemplateCWidgetState> templateCKey = GlobalKey();
  final GlobalKey<TemplateFWidgetState> templateFKey = GlobalKey();
  Future<bool>? status;

  Map<String, String?> errors = {
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'conductor4': null,
    'conductor7': null,
    'conductor2': null,
  };

  @override
  void initState() {
    super.initState();
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
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
    super.dispose();
  }

  bool validForm() {
    validate.mapErrors(errors);
    _validateForm();
    return errors.values.every((error) => error == null);
  }

  Future<void> _validateForm() async {
    validate.validateTextField(conveyorLength.text, 'conveyorLength');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
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

  final Map<String, List<String>> sections = {
    'General Information': [
      'conveyorLength',
      'conveyorSpeed',
      'chainManufacturer',
      'conveyorChainSize'
    ],
    'Customer Power Utilities': ['operatingVoltage'],
    'New/Existing Monitoring System': ['newMonitorStatus'],
    'Conveyor Specifications': ['lubricationSide', 'lubricationTop', 'cleanChain'],
    'Controller': ['measurementUnits', 'conductor4', 'conductor7', 'conductor2'],
    'Wire': ['measurementUnits', 'conductor4', 'conductor7', 'conductor2'],
    'Measurements': [
      'measurementUnit',
      'bDiameter',
      'gWidth',
      'hHeight',
      'sCenter',
      'kDiameter',
      'lWidth',
      'mDiameter',
      'nTop',
      's2Center'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(
            context, '>', const ApplicationPage(), 'Products', const CLSProducts()),
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
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire(),
                  isError: validate.sectionError('Wire')),
              CommonWidgets.buildGradientButton(context, 'Measurements', buildMeasurements(),
                  isError: validate.sectionError('Measurements')),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addETO_OP48E(value);
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
        CommonWidgets.buildDropdownFieldError(
          'Conveyor Chain Size',
          [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'OX678 Chain (6")',
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildSectionTitle('Environmental Details'),
        CommonWidgets.buildDropdownFieldError(
          'Is the Conveyor "__" at Planned Install Location',
          ['Loaded', 'Unloaded'],
          conveyorLoaded,
          (value) {
            setState(() {
              conveyorLoaded = value;
              validate.validateDropdownField(conveyorLoaded, 'conveyorLoaded');
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Is this a Drip Line',
          ['Yes', 'No'],
          dripLine,
          (value) {
            setState(() {
              dripLine = value;
              validate.validateDropdownField(dripLine, 'dripLine');
            });
          },
        ),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError(
          'Operating Voltage - 3 Phase: (Volts/hz)',
          ['Option 1', 'Option 2', 'Option 3'],
          operatingVoltage,
          (value) {
            setState(() {
              operatingVoltage = value;
              validate.validateDropdownField(operatingVoltage, 'operatingVoltage');
            });
          },
        ),
        CommonWidgets.buildDropdownField(
          'Confirm Installation Clearance of: Minimum of 2\' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width',
          ['Yes', 'No'],
        ),
        CommonWidgets.buildDropdownField('3-Station Push Button Switch', ['Yes', 'No']),
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
        if (existingMonitoring == 1) CommonWidgets.buildTemplateA(templateAKey, validate),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Drive Motor Amp', ['Yes', 'No'], driveMotorAmp,
            (value) {
          setState(() {
            driveMotorAmp = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Take-up-Air', ['Yes', 'No'], driveTakeUpAir,
            (value) {
          setState(() {
            driveTakeUpAir = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Take-Up Distance', ['Yes', 'No'], takeUpDistance,
            (value) {
          setState(() {
            takeUpDistance = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Temp', ['Yes', 'No'], driveTemp,
            (value) {
          setState(() {
            driveTemp = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Drive Motor Vibration', ['Yes', 'No'], driveVibration, (value) {
          setState(() {
            driveVibration = value;
          });
        }),
        CommonWidgets.buildDropdownFieldError(
            'Bent or Missing Trolley detect', ['Yes', 'No'], trolleyDetect, (value) {
          setState(() {
            trolleyDetect = value;
          });
        }),
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
              validate.validateDropdownField(lubricationSide, 'lubricationSide');
            });
          },
          errorText: errors['lubricationSide'],
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
          errorText: errors['lubricationTop'],
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
          errorText: errors['cleanChain'],
        ),
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTemplateB(templateBKey, validate),
        CommonWidgets.buildTemplateC(templateCKey, validate),
        CommonWidgets.buildTemplateF(templateFKey, validate)
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
          ['Feet', 'Inches', 'm Meter', 'mm Millimeter'],
          measurementUnits,
          (value) {
            setState(() {
              measurementUnits = value;
              validate.validateDropdownField(measurementUnits, 'measurementUnits');
            });
          },
        ),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here', conductor2),
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
              validate.validateDropdownField(measurementUnits, 'measurementUnits');
            });
          },
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
          title: "Enclosed Track (Overhead) Power Trolley Wheel (B)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/4/CMS/B.png',
          controller: bDiameter,
          subHint: "(Diameter)",
          errorText: errors['bDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Power Rail (G)",
          hintText: "Width",
          imagePath: 'assets/Measurements/4/CMS/G.png',
          controller: gWidth,
          subHint: "(Width)",
          errorText: errors['gWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Power Rail (H)",
          hintText: "Height",
          imagePath: 'assets/Measurements/4/CMS/H.png',
          controller: hHeight,
          subHint: "(Height)",
          errorText: errors['hHeight'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title:
              "Enclosed Track (Overhead) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)",
          hintText: "Center of Power Wheel to Center of Power Wheel",
          imagePath: 'assets/Measurements/4/CMS/S.png',
          controller: sCenter,
          subHint: "(Center of Power Wheel to Center of Power Wheel)",
          errorText: errors['sCenter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Free Trolley Wheel (K2)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/4/CMS/K2.png',
          controller: kDiameter,
          subHint: "(Diameter)",
          errorText: errors['kDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Free Rail (L2)",
          hintText: "Width",
          imagePath: 'assets/Measurements/4/CMS/L2.png',
          controller: lWidth,
          subHint: "(Width)",
          errorText: errors['lWidth'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Free Rail (M2)",
          hintText: "Diameter",
          imagePath: 'assets/Measurements/4/CMS/M2.png',
          controller: mDiameter,
          subHint: "(Diameter)",
          errorText: errors['mDiameter'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Free Rail Vertical Position (Height) (N2)",
          hintText: "Top of Power Rail to Bottom of Free Rail",
          imagePath: 'assets/Measurements/4/CMS/N2.png',
          controller: nTop,
          subHint: "(Top of Power Rail to Bottom of Free Rail)",
          errorText: errors['nTop'],
        ),
        CommonWidgets.buildMeasurementFieldWithImage(
          context: context,
          title: "Enclosed Track (Overhead) Power Trolley Wheel Pitch (S2)",
          hintText: "Center of Trolley Wheel to Center of Trolley Wheel",
          imagePath: 'assets/Measurements/4/CMS/S2.png',
          controller: s2Center,
          subHint: "(Center of Trolley Wheel to Center of Trolley Wheel)",
          errorText: errors['s2Center'],
        ),
      ],
    );
  }

  VoidCallback? addETO_OP48E(int numRequested) {
    if (validForm()) {
      dynamic etoData = {
        'chainSize': conveyorChainSize,
        'industrialChainManufacturer': chainManufacturer,
        'otherIndustrialChainManufacturer': null,
        'conveyorLength': conveyorLength.text,
        'conveyorLengthUnit': null,
        'conveyorSpeed': conveyorSpeed.text,
        'conveyorSpeedUnit': null,
        'conveyorIndex': conveyorIndex.text,
        'travelDirection': directionOfTravel,
        'appEnviroment': applicationEnvironment,
        'ovenStatus': null,
        'ovenTemp': null,
        'newMonitorStatus': newMonitorStatus,
        'conveyorLoaded': conveyorLoaded,
        'conveyorSwing': null,
        'operatingVoltage': operatingVoltage,
        'freeCarrierSystem': null,
        'catDriveStatus': null,
        'catDriveNum': null,
        'lubeBrand': null,
        'lubeType': null,
        'lubeViscosity': null,
        'chainCleanStatus': null,
        'wireMeasurementUnit': null,
        'conductor2': conductor2.text,
        'conductor4': conductor4.text,
        'conductor7': conductor7.text,
        'conductor12': null,
        'junctionBoxNum': null,
        'etUnitType': null,
        'etOverheadB': null,
        'etOverheadG': null,
        'etOverheadH': null,
        'etOverheadS': null,
        'etOverheadK2': null,
        'etOverheadLS': null,
        'etOverheadM2': null,
        'etOverheadN2': null,
        'etOverheadS2': null,
        "templateA": templateAKey.currentState?.getData(),
        "templateB": templateBKey.currentState?.getData(),
        "templateC": templateCKey.currentState?.getData(),
        "templateF": templateFKey.currentState?.getData()
      };

      status = FormAPI().addOrder("ETO_OP48E", etoData, numRequested);
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
                MaterialPageRoute(builder: (context) => const CLSProducts()),
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
}
