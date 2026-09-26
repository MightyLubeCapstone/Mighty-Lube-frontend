import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData flatTopMightyLubeLubricatorData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'FT_MLCEL',
  title: 'Mighty Lube Flat Top Lubricator',
  imagePath: AppAssets.flatTopMlcLubricator,
  description: 'Mighty Lube Flat Top Lubricator for flat top conveyor systems.',

  // =========================================================
  // CONFIGURATION SECTIONS
  // =========================================================

  configurationSections: [
    // =======================================================
    // 1. GENERAL INFORMATION
    // =======================================================

    ProductConfigurationSection(
      id: 'general_information',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'chainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            '3/8" Log Chain',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
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
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: true,
        ),

        // Website shows this as a dropdown, but its exact options
        // were not available in the supplied source.
        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'Meter',
            'Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet / minute',
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        // Only one option was confirmed from the supplied website data,
        // therefore keeping this as text rather than inventing options.
        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Left to Right',
            'Right to Left'
          ],
          hintText: 'Example: Left to Right',
        ),

        ProductFieldData(
          key: 'applicationEnvironment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Ambient',
            'Caustic',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'surroundingTemperature',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorStrandType',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Single',
            'Double',
          ],
        ),

        ProductFieldData(
          key: 'plantLayoutAvailable',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        // TODO:
        // Current reusable ProductFieldData file-upload type has not
        // been confirmed yet. This field preserves the API contract.
        ProductFieldData(
          key: 'plantLayoutFile',
          label: 'Please attach plant layout',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Plant layout attachment',
          visibleWhenFieldKey: 'plantLayoutAvailable',
          visibleWhenValue: 'Yes - Will Attach',
        ),

        ProductFieldData(
          key: 'chainPhotosAvailable',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        // TODO:
        // Replace with actual upload field when generic form supports it.
        ProductFieldData(
          key: 'chainPhotosFile',
          label: 'Please attach required chain photos',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Required chain photos attachment',
          visibleWhenFieldKey: 'chainPhotosAvailable',
          visibleWhenValue: 'Yes - Will Attach',
        ),
      ],
    ),

    // =======================================================
    // 2. CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'customer_power_utilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase (Volts/Hz)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/Hz)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =======================================================
    // 3. MONITORING SYSTEM
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoring_system',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        // Exact website dropdown options were not supplied.
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          required: true,
          type: ProductFieldType.text,
        ),

        // Exact website dropdown options were not supplied.
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // 4. CONVEYOR SPECIFICATIONS
    // =======================================================

    ProductConfigurationSection(
      id: 'conveyor_specifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenType',
          label: 'Wheel: Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),

        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),

        ProductFieldData(
          key: 'openInsideShieldedOutside',
          label: 'Open Inside / Shielded Outside',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'sliderPlates',
          label: 'Slider Plates',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'caterpillarDrive',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'caterpillarDriveQuantity',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'caterpillarDrive',
          visibleWhenValue: 'Yes',
        ),

        ProductFieldData(
          key: 'railLubrication',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'externalLubrication',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment Brand',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity / Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        // Exact website choices were not supplied.
        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            '10 Gallon',
            '65 Gallon',
          ],
        ),

        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorChainClean',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =======================================================
    // 5. CONTROLLER
    // =======================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        // Source says dropdown/input but exact options are unknown.
        ProductFieldData(
          key: 'ctrController',
          label: 'CTR Controller',
          type: ProductFieldType.text,
          required: true,
        ),

        // Source says dropdown/input but exact options are unknown.
        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'monitoringController',
          label: 'Monitoring Controller',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'controllerOtherDescribe',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),

        // Exact dropdown choices were not supplied.
        ProductFieldData(
          key: 'specialControllerOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'controllerPleaseSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // 6. FLAT TOP MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'flat_top_measurements',
      title: 'Flat Top: Measurements',
      fields: [
        ProductFieldData(
          key: 'ftUnitType',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'ftTopG',
          label: 'Flat Top Measurement G',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_G,
        ),

        ProductFieldData(
          key: 'ftTopH',
          label: 'Flat Top Measurement H',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_H,
        ),

        ProductFieldData(
          key: 'ftTopA1',
          label: 'Flat Top Measurement A1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_A1,
        ),

        ProductFieldData(
          key: 'ftTopB1',
          label: 'Flat Top Measurement B1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_B1,
        ),

        ProductFieldData(
          key: 'ftTopH1',
          label: 'Flat Top Measurement H1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_H1,
        ),

        ProductFieldData(
          key: 'ftTopJ1',
          label: 'Flat Top Measurement J1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_J1,
        ),

        ProductFieldData(
          key: 'ftTopL1',
          label: 'Flat Top Measurement L1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_L1,
        ),

        ProductFieldData(
          key: 'ftTopM1',
          label: 'Flat Top Measurement M1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_M1,
        ),

        ProductFieldData(
          key: 'ftTopN1',
          label: 'Flat Top Measurement N1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_N1,
        ),

        ProductFieldData(
          key: 'ftTopP1',
          label: 'Flat Top Measurement P1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_P1,
        ),

        ProductFieldData(
          key: 'ftTopR1',
          label: 'Flat Top Measurement R1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_R1,
        ),
      ],
    ),

    // =======================================================
    // 7. WIRE
    // =======================================================

    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'wireMeasurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'Meter',
            'Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'wire2Conductor',
          label: '2 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'wire4Conductor',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'wire7Conductor',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'wire12Conductor',
          label: '12 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'junctionBoxQuantities',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),


    // =======================================================
    // TECHNICIAN NOTE
    //
    // Not shown on current website recording.
    // Kept as optional because this application currently
    // supports technician notes across configurations.
    // =======================================================

    ProductConfigurationSection(
      id: 'technician',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
          hintText:
          'Enter any additional notes or instructions here...',
        ),
      ],
    ),
  ],
);