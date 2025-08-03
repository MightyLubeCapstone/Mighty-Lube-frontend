import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/2.%209125CD%20(3)/CLS%20(3)/products.dart';
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

  final TextEditingController aTop = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController jWidth = TextEditingController();
  final TextEditingController xWidth = TextEditingController();
  final TextEditingController yThickness = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? conveyorChainManufacturer = -1;
  int? existingMonitoring = -1;
  int? wheelOpenRace = -1;
  int? wheelSealedStyle = -1;
  int? openInsideShielded = -1;
  int? openOutsideShielded = -1;
  int? railLubrication = -1;
  int? externalLubrication = -1;
  int? reservoirSize = -1;
  int? chainClean = -1;
  int? measurementUnits = -1;
  int? conveyorLengthUnit = -1;
  int? conveyorSpeedUnit = -1;
  int? conveyorDirection = -1;
  int? conveyorEnvironment = -1;
  int? conveyorTemperature = -1;
  int? conveyorStrand = -1;
  int? measurementsUnits = -1;

  final Validators validate = Validators();
  final GlobalKey<TemplateAWidgetState> templateAKey = GlobalKey();
  Map<String, dynamic> templateAData = {};
  final GlobalKey<TemplateDWidgetState> templateDKey = GlobalKey();
  Map<String, dynamic> templateDData = {};
  final GlobalKey<TemplateEWidgetState> templateEKey = GlobalKey();
  Map<String, dynamic> templateEData = {};

  bool? status;

  // Error messages
  Map<String, String?> errors = {
    'conveyorSystem': null,
    'conveyorChainSize': null,
    'conveyorChainManufacturer': null,
    'conveyorLength': null,
    'conveyorSpeed': null,
    'operatingVoltage': null,
    'existingMonitoring': null,
    'measurementsUnits': null,
    'aTop': null,
    'gWidth': null,
    'hHeight': null,
    'jWidth': null,
    'xWidth': null,
    'yThickness': null,
  };

  final Map<String, List<String>> sections = {
    'general': [
      'conveyorSystem',
      'conveyorChainSize',
      'conveyorChainManufacturer',
      'conveyorLength',
      'conveyorSpeed',
      'conveyorIndex',
      'conveyorDirection',
      'conveyorEnvironment',
      'conveyorTemperature',
      'conveyorStrand',
    ],
    'customerPowerUtilities': [
      'operatingVoltage',
    ],
    'newExistingMonitoringSystem': [
      'existingMonitoring',
    ],
    'conveyorSpecifications': [
      'wheelOpenRace',
      'wheelSealedStyle',
      'openInsideShielded',
      'openOutsideShielded',
      'railLubrication',
      'externalLubrication',
      'equipBrand',
      'currentType',
      'currentGrade',
      'reservoirSize',
      'chainClean',
    ],
    'controller': [
      'specialOptions',
    ],
    'wire': [
      'measurementUnits',
      'conductor2',
      'conductor4',
      'conductor7',
      'conductor12',
      'jBox',
    ],
    'measurements': [
      'measurementsUnits',
      'aTop',
      'gWidth',
      'hHeight',
      'jWidth',
      'xWidth',
      'yThickness'
    ],
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
    operatingVoltage.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conductor4.dispose();
    conductor7.dispose();
    conductor2.dispose();
    equipBrand.dispose();
    currentType.dispose();
    currentGrade.dispose();
    specialOptions.dispose();
    jBox.dispose();
    conductor12.dispose();
    aTop.dispose();
    gWidth.dispose();
    hHeight.dispose();
    jWidth.dispose();
    xWidth.dispose();
    yThickness.dispose();
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

    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateDropdownField(conveyorChainManufacturer, 'conveyorChainManufacturer');
    validate.validateDropdownField(existingMonitoring, 'existingMonitoring');
    validate.validateDropdownField(measurementUnits, 'measurementUnits');
    validate.validateDropdownField(measurementsUnits, 'measurementsUnits');
    validate.validateTextField(aTop.text, 'aTop');
    validate.validateTextField(gWidth.text, 'gWidth');
    validate.validateTextField(hHeight.text, 'hHeight');
    validate.validateTextField(jWidth.text, 'jWidth');
    validate.validateTextField(xWidth.text, 'xWidth');
    validate.validateTextField(yThickness.text, 'yThickness');

    setState(() {});
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
                  isError: validate.sectionError("general")),
              CommonWidgets.buildGradientButton(
                  context, 'Customer Power Utilities', buildCustomerPowerUtilitiesContent(),
                  isError: validate.sectionError("customerPowerUtilities")),
              CommonWidgets.buildGradientButton(
                  context, 'New/Existing Monitoring System', buildNewMonitoringSystem(),
                  isError: validate.sectionError("newExistingMonitoringSystem")),
              CommonWidgets.buildGradientButton(
                  context, 'Conveyor Specifications', buildConveyorSpecifications(),
                  isError: validate.sectionError("conveyorSpecifications")),
              CommonWidgets.buildGradientButton(context, 'Controller', buildController(),
                  isError: validate.sectionError("controller")),
              CommonWidgets.buildGradientButton(context, 'Wire', buildWire(),
                  isError: validate.sectionError("wire")),
              CommonWidgets.buildGradientButton(context, 'Measurements', buildMeasurements(),
                  isError: validate.sectionError("measurements")),
            ],
          ),
        ),
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addMLCEL(value);
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
          conveyorChainManufacturer,
          (value) {
            setState(() {
              conveyorChainManufacturer = value;
              validate.validateDropdownField(
                  conveyorChainManufacturer, 'conveyorChainManufacturer');
            });
          },
          errorText: errors['conveyorChainManufacturer'],
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
          CommonWidgets.buildTemplateA(templateAKey, validate, data: templateAData,
              callback: (data) {
            templateAData = data;
          }),
          CommonWidgets.buildTemplateD(templateDKey, validate, data: templateDData,
              callback: (data) {
            templateDData = data;
          }),
          CommonWidgets.buildTemplateE(templateEKey, validate, data: templateEData,
              callback: (data) {
            templateEData = data;
          }),
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
          'Wheel: Open Race Style',
          ['Not Applicable', 'Open Inside', 'Open Outside'],
          wheelOpenRace,
          (value) {
            setState(() {
              wheelOpenRace = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Wheel Sealed Style',
          ['Extended', 'Flush', 'Recessed'],
          wheelSealedStyle,
          (value) {
            setState(() {
              wheelSealedStyle = value;
            });
          },
        ),
        CommonWidgets.buildDropdownFieldError(
          'Rail Lubrication',
          ['Yes', 'No'],
          railLubrication,
          (value) {
            setState(() {
              railLubrication = value;
            });
          },
        ),
        CommonWidgets.buildTextField(
          'Current Lubrication Equipment (Brand)',
          equipBrand,
        ),
        CommonWidgets.buildTextField(
          'Current Lubricant Type',
          currentType,
        ),
        CommonWidgets.buildTextField(
          'Current Lubricant Viscosity/Grade',
          currentGrade,
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
          'Enter Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          specialOptions,
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
            });
          },
        ),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here', conductor2),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here', conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here', conductor7),
        CommonWidgets.buildTextField('Enter 12 Conductor Number Here', conductor12),
        CommonWidgets.buildTextField('Enter Junction Box Quantities', jBox),
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
          measurementsUnits,
          (value) {
            setState(() {
              measurementsUnits = value;
              validate.validateDropdownField(measurementsUnits, 'measurementsUnits');
            });
          },
          errorText: errors['measurementsUnits'], // ✅ Add this!
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
      ],
    );
  }

  Future<VoidCallback?> addMLCEL(int numRequested) async {
    if (validForm()) {
      dynamic mlcelData = {
        "conveyorName": conveyorSystem.text,
        "chainSize": conveyorChainSize,
        "industrialChainManufacturer": conveyorChainManufacturer,
        "otherIndustrialChainManufacturer": null,
        "conveyorLength": conveyorLength.text,
        "conveyorLengthUnit": conveyorLengthUnit,
        "conveyorSpeed": conveyorSpeed.text,
        "conveyorSpeedUnit": conveyorSpeedUnit,
        "conveyorIndex": conveyorIndex.text,
        "travelDirection": conveyorDirection,
        "appEnviroment": conveyorEnvironment,
        "ovenStatus": null,
        "ovenTemp": null,
        "surroundingTemp": conveyorTemperature,
        "conveyorLoaded": null,
        "conveyorSwing": null,
        "plantLayout": null,
        "requiredPics": null,
        "operatingVoltage": operatingVoltage.text,
        "wheelOpenType": wheelOpenRace,
        "wheelClosedType": wheelSealedStyle,
        "openStatus": null,
        "catDriveStatus": null,
        "railLubeStatus": railLubrication,
        "externalLubeStatus": externalLubrication,
        "lubeBrand": equipBrand.text,
        "lubeType": currentType.text,
        "lubeViscosity": currentGrade.text,
        "chainCleanStatus": chainClean,
        "wireMeasurementUnit": measurementUnits,
        "conductor2": conductor2.text,
        "conductor4": conductor4.text,
        "conductor7": conductor7.text,
        "conductor12": conductor12.text,
        "junctionBoxNum": jBox.text,
        "coeUnitType": null,
        "coeLineA": aTop.text,
        "coeLineG": gWidth.text,
        "coeLineH": hHeight.text,
        "coeLineJ": jWidth.text,
        "coeLineX": xWidth.text,
        "coeLineY": yThickness.text,
        "templateA": templateAData,
        "templateD": templateDData,
        "templateE": templateEData,
      };
      status = await FormAPI().addOrder("COE_CEL", mlcelData, numRequested);
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
