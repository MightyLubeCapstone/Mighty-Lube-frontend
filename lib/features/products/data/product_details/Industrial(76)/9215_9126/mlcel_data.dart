import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData mightyLubeChainOnEdgeLubricatorData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'COE_CEL',
  title: 'Mighty Lube Chain On Edge Lubricator',
  imagePath: AppAssets.caterpillarMlcEdgeLubricator,
  description: 'Mighty Lube Chain On Edge Lubricator for Chain on Edge Drag Line conveyor applications.',

  // =========================================================
  // CONFIGURATION SECTIONS
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
            'CC5 3"',
            'CC5 4"',
            'CC5 6"',
            'RC60',
            'RC80',
            'RC 2080',
            'RC 2060',
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
            'Feet / Minute',
            'Meters / Minute',
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
            'Caustic (i.e. Phosphate / E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label:
          'Is the temperature at the planned lubrication system location below 30°F or above 120°F?',
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
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'plantLayout',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        ProductFieldData(
          key: 'requiredPics',
          label:
          'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),
      ],
    ),

    // =======================================================
    // CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'power',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label:
          'Operating Voltage - 3 Phase (Volts/Hz)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/Hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // NEW / EXISTING MONITORING
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
          key: 'addMonitoring',
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
      id: 'conveyor',
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
          key: 'openStatus',
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
          key: 'caterpillarDriveQuantity',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'railLubeStatus',
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
          label: 'Current Lubrication Equipment Brand',
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
          label: 'Current Lubricant Viscosity / Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'reservoirSizeQuantity',
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

        ProductFieldData(
          key: 'conditionDescription',
          label: 'Describe Existing Conditions',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
          hintText: 'Describe any existing conveyor or lubrication conditions...',
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
          key: 'specialControllerOptions',
          label:
          'Special Options to Add on to Controller',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'specialControllerDetails',
          label:
          'I/O Link, Plug and Play, Dry Contacts - Please Specify',
          type: ProductFieldType.text,
          required: true,
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
            'Meter',
            'Millimeter',
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
    // CHAIN ON EDGE DRAG LINE MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Chain on Edge Drag Line: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
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
          key: 'coeLineA',
          label:
          'Chain on Edge Drag Line Chain Drop (A) - Top of Rail to Center of Chain',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelA,
        ),

        ProductFieldData(
          key: 'coeLineG',
          label:
          'Chain on Edge Drag Line Power Rail (G) - Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelG,
        ),

        ProductFieldData(
          key: 'coeLineH',
          label:
          'Chain on Edge Drag Line Power Rail (H) - Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelH,
        ),

        ProductFieldData(
          key: 'coeLineJ',
          label:
          'Chain on Edge Drag Line Rail Offset (J) - Inside of Rail Channel to Inside of Rail Channel',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelJ,
        ),

        ProductFieldData(
          key: 'coeLineX',
          label:
          'Chain on Edge Drag Line Wear Bar (X) - Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelX,
        ),

        ProductFieldData(
          key: 'coeLineY',
          label:
          'Chain on Edge Drag Line Wear Bar (Y) - Thickness',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.mlcelY,
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
          hintText:
          'Enter any additional notes or instructions here...',
        ),
      ],
    ),
  ],
);