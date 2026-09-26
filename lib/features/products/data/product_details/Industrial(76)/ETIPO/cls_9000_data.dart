import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData etipo9000InvlData = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================
  id: 'ETI_9000INVL',
  title: '9000INVL (Inverted) Series Enclosed Track Conveyor Lubricators',
  imagePath: AppAssets.etipo9000Invl,
  description: '9000INVL Series lubrication system for inverted enclosed track conveyor applications.',

  // =========================================================
  // CONFIGURATION
  // =========================================================
  configurationSections: [
    // =======================================================
    // GENERAL INFORMATION
    // =======================================================
    ProductConfigurationSection(
      id: 'general',
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
          key: 'industrialChainManufacturer',
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

        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeters',
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
            'Feet/Minute',
            'Meters/Minute',
          ],
        ),

        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Right to Left',
            'Left to Right',
          ],
        ),

        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Ambient',
            'Caustic (i.e. Phosphate/E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'ovenStatus',
          label: 'Is Conveyor Located in an Oven?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Oven',
        ),

        ProductFieldData(
          key: 'ovenTemp',
          label: 'Oven Temperature',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Oven',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label:
          'Is Temperature of Surrounding Area at Planned Location of Lubrication System Below 30°F or Above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Unloaded',
            'Loaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
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
    // CUSTOMER POWER UTILITIES
    // =======================================================
    ProductConfigurationSection(
      id: 'powerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase: (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // MONITORING SYSTEM
    // =======================================================
    ProductConfigurationSection(
      id: 'monitoring',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
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
    // CONVEYOR SPECIFICATIONS
    // =======================================================
    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenType',
          label: 'Wheel: Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Not Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),
        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),

        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'catDriveStatus',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'catDriveNum',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'catDriveStatus',
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
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubeType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'sideLubeStatus',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

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
          key: 'reservoirQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'chainCleanStatus',
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
    // CONTROLLER
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

        ProductFieldData(
          key: 'ctrStatus',
          label: 'CTR Controller',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'monitorControlStatus',
          label: 'Monitoring Controller',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'otherControllerInfo',
          label: 'Other Describe',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),

        ProductFieldData(
          key: 'controllerSpecialOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),

        ProductFieldData(
          key: 'controllerSpecialOptionsSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // WIRE
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
            'm Meter',
            'mm Millimeters',
          ],
        ),

        ProductFieldData(
          key: 'conductor2',
          label: '2 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conductor4',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conductor7',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conductor12',
          label: '12 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'junctionBoxNum',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // ENCLOSED TRACK INVERTED MEASUREMENTS
    // =======================================================
    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Inverted: Measurements',
      fields: [
        ProductFieldData(
          key: 'enclosedUnitType',
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
          key: 'enclosedTrackB',
          label: 'Enclosed Track (Inverted) Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Diameter',
          imagePath: AppAssets.etioB,
        ),

        ProductFieldData(
          key: 'enclosedTrackG',
          label: 'Enclosed Track (Inverted) Power Rail (G)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.etioG,
        ),

        ProductFieldData(
          key: 'enclosedTrackH',
          label: 'Enclosed Track (Inverted) Power Rail (H)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Height',
          imagePath: AppAssets.etioH,
        ),

        ProductFieldData(
          key: 'enclosedTrackS',
          label:
          'Enclosed Track (Inverted) Trolley Pitch [Spacing] Minimum - For Variable Pitch Chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.etioS,
        ),

        ProductFieldData(
          key: 'enclosedTrackK2',
          label: 'Enclosed Track (Inverted) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Diameter',
          imagePath: AppAssets.etioK2,
        ),

        ProductFieldData(
          key: 'enclosedTrackL2',
          label: 'Enclosed Track (Inverted) Free Rail (L2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.etioL2,
        ),

        ProductFieldData(
          key: 'enclosedTrackM2',
          label: 'Enclosed Track (Inverted) Free Rail (M2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Diameter',
          imagePath: AppAssets.etioM2,
        ),

        ProductFieldData(
          key: 'enclosedTrackN2',
          label: 'Enclosed Track (Inverted) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Top of Power Rail to Bottom of Free Rail',
          imagePath: AppAssets.etioN2,
        ),

        ProductFieldData(
          key: 'enclosedTrackS2',
          label: 'Enclosed Track (Inverted) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Trolley Wheel to Center of Trolley Wheel',
          imagePath: AppAssets.etioS2,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
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
          hintText: 'Enter any additional notes or instructions here...',
        ),
      ],
    ),
  ],
);