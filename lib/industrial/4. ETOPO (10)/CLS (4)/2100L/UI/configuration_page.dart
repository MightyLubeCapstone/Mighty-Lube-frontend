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
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  int? operatingVoltage = -1;
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

  // Dropdown values
  int? conveyorChainSize = -1;
  int? chainManufacturer = -1;
  int? directionOfTravel = -1;
  int? applicationEnvironment = -1;
  int? lubricationSide = -1;
  int? lubricationTop = -1;
  int? cleanChain = -1;
  int? measurementUnits = -1;
  int? existingMonitoring = -1;
  int? newMonitoring = -1;
  int? driveMotorAmp = -1;
  int? driveTakeUpAir = -1;
  int? takeUpDistance = -1;
  int? driveTemp = -1;
  int? driveVibration = -1;
  int? detectTrolley = -1;
  int? sideLube = -1;
  int? topLube = -1;
  int? conveyorClean = -1;
  int? conveyorLoaded = -1;     


  final Validators validate = Validators();
  Future<bool>? status;

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
    ],
    'Customer Power Utilities': ['operatingVoltage'],
    'New/Existing Monitoring System': [],
    'Conveyor Specifications': [
      'lubricationSide',
      'lubricationTop',
      'cleanChain',
    ],
    'Controller': [],
    'Wire': [
      'conductor4',
      'conductor7',
      'conductor2',
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
  }

  @override
  void dispose() {
    conveyorSystem.dispose();
    conveyorLength.dispose();
    conveyorSpeed.dispose();
    conveyorIndex.dispose();
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
    validate.validateDropdownField(conveyorChainSize, 'conveyorChainSize');
    validate.validateTextField(conveyorSpeed.text, 'conveyorSpeed');
    validate.validateDropdownField(operatingVoltage, 'operatingVoltage');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CLSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent(), isError: validate.sectionError('General Information')),
              CommonWidgets.buildGradientButton(context, 'Customer Power Utilities',buildCustomerPowerUtilitiesContent(), isError: validate.sectionError('Customer Power Utilities')),
              CommonWidgets.buildGradientButton(context, 'New/Existing Monitoring System',buildMonitoringFeatures(), isError: validate.sectionError('New/Existing Monitoring System')),
              CommonWidgets.buildGradientButton(context, 'Conveyor Specifications',buildConveyorSpecifications(), isError: validate.sectionError('Conveyor Specifications')),
              CommonWidgets.buildGradientButton(context, 'Controller',buildController(), isError: validate.sectionError('Controller')),
              CommonWidgets.buildGradientButton(context, 'Wire',buildWire(), isError: validate.sectionError('Wire')),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(callback: (int value) {
          addETO2100(value);
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
              validate.validateDropdownField(
                  conveyorChainSize, 'conveyorChainSize');
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
        CommonWidgets.buildDropdownField('Is the Conveyor "__" at Planned Install Location',
            ['Loaded', 'Unloaded']),
        CommonWidgets.buildDropdownField('Is this a Drip Line', ['Yes', 'No']),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildDropdownFieldError('Operating Voltage - 3 Phase: (Volts/hz)',
            ['Option 1', 'Option 2', 'Option 3'], operatingVoltage, (value) {
            setState(() {
              operatingVoltage = value;
              validate.validateDropdownField(chainManufacturer, 'chainManufacturer');
            });
          },),
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
        CommonWidgets.buildDropdownFieldError('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ], existingMonitoring, (value) {
          setState(() {
            existingMonitoring = value;
            validate.validateDropdownField(existingMonitoring, 'existingMonitoringSystem');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Add New Monitoring System', [
          'Yes',
          'No'
        ], newMonitoring, (value) {
          setState(() {
            newMonitoring = value;
            validate.validateDropdownField(newMonitoring, 'newMonitoringSystem');
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Drive Motor Amp', [
          'Yes',
          'No'
        ], driveMotorAmp, (value) {
          setState(() {
            driveMotorAmp = value;
            validate.validateDropdownField(driveMotorAmp, 'driveMotorAmp');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Take-up-Air', [
          'Yes',
          'No'
        ], driveTakeUpAir, (value) {
          setState(() {
            driveTakeUpAir = value;
            validate.validateDropdownField(driveTakeUpAir, 'driveTakeUpAir');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Take-Up Distance', [
          'Yes',
          'No'
        ], takeUpDistance, (value) {
          setState(() {
            takeUpDistance = value;
            validate.validateDropdownField(takeUpDistance, 'takeUpDistance');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Temp', [
          'Yes',
          'No'
        ], driveTemp, (value) {
          setState(() {
            driveTemp = value;
            validate.validateDropdownField(driveTemp, 'driveTemp');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Drive Motor Vibration', [
          'Yes',
          'No'
        ], driveVibration, (value) {
          setState(() {
            driveVibration = value;
            validate.validateDropdownField(driveVibration, 'driveVibration');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Bent or Missing Trolley detect', [
          'Yes',
          'No'
        ], detectTrolley, (value) {
          setState(() {
            detectTrolley = value;
            validate.validateDropdownField(detectTrolley, 'detectTrolley');
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
       CommonWidgets. buildSectionDivider(),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ], lubricationSide, (value) {
          setState(() {
            lubricationSide = value;
            validate.validateDropdownField(lubricationSide, 'lubricationSide');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ], lubricationTop, (value) {
          setState(() {
            lubricationTop = value;
            validate.validateDropdownField(lubricationTop, 'lubricationTop');
          });
        }),
        CommonWidgets.buildDropdownFieldError('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ], cleanChain, (value) {
          setState(() {
            cleanChain = value;
            validate.validateDropdownField(cleanChain, 'cleanChain');
          });
        }),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
  
  Widget buildController() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        CommonWidgets.buildTextField('Enter 4 Conductor Number Here',conductor4),
        CommonWidgets.buildTextField('Enter 7 Conductor Number Here',conductor7),
        CommonWidgets.buildTextField('Enter 2 Conductor Number Here',conductor2),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  VoidCallback? addETO2100(int numRequested) {
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
      'surroundingTemp': null,
      'conveyorLoaded': conveyorLoaded,
      'conveyorSwing': null,
      'operatingVoltage': operatingVoltage,
      'monitorData': {
        'existingMonitor': existingMonitoring,
        'newMonitor': newMonitoring,
        'dcuStatus': null,
        'dcuNum': null,
        'existingWindows': null,
        'existingHeadUnit': null,
        'existingDCU': null,
        'existingPowerInterface': null,
        'newReservoir': null,
        'reservoirSize': null,
        'otherReservoirSize': null,
        'newReservoirNum': null,
        'typeMonitor': null,
        'driveMotorAmp': driveMotorAmp,
        'driveMotorAmpNum': null,
        'driveTakeUpAir': driveTakeUpAir,
        'driveTakeUpAirNum': null,
        'takeUpDistance': takeUpDistance,
        'takeUpDistanceNum': null,
        'driveTemp': driveTemp,
        'driveTempNum':null,
        'driveVibration': driveVibration,
        'driveVibrationNum': null,
        'dogPitch': null,
        'dogPitchNum': null,
        'paintMarker': null,
        'paintMarkerNum': null,
        'chainVision': null,
        'lubeVision': null,
        'trolleyVision': null,
        'trolleyDetect': null,
        'omniView': null,
        'dcuUpgradeNum': null,
        'itNameOne': null,
        'itIPOne': null,
        'itGatewayOne': null,
        'itSubnetOne': null,
        'itDNSOne': null,
        'itSMTPOne': null,
        'itNameTwo': null,
        'itIPTwo': null,
        'itGatewayTwo': null,
        'itSubnetTwo': null,
        'itDNSTwo': null,
        'itSMTPTwo': null,
        'itNameThree': null,
        'itIPThree': null,
        'itGatewayThree': null,
        'itSubnetThree': null,
        'itDNSThree': null,
        'itSMTPThree': null,
        'itAdditionalNotes': null,
        'piuDistance': null,
        'switchDistance': null,
        'ampPickup': null,
        'fromAirTakeUpDistance': null,
        'specialControllerOptions': null,
      },
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
    };

    status = FormAPI().addOrder("ETO_2100", etoData, numRequested);
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
