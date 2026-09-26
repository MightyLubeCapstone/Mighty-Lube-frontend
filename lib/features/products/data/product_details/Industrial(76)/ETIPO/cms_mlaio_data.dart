import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData etiMlaioData = ProductDetailData(
  id: 'ETI_MLAIO',
  title: 'Multi Line (Permanent) ALL IN ONE Monitoring + Lubrication',
  imagePath: AppAssets.etipoMonitorSystemsMultiLine,
  description: 'The Next Generation Permanent Conveyor Monitoring System is connected to the network and provides chain wear data and projections for up to 100 conveyor lines.',

  configurationSections: [
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
          options: const [
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
          options: const [
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
          options: const [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
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
          options: const [
            'Feet / minute',
            'Meters / minute',
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
          options: const [
            'Right to Left',
            'Left to Right',
          ],
        ),
        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
            'Loaded',
            'Unloaded',
          ],
        ),
        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

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

    ProductConfigurationSection(
      id: 'monitoring',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'dcuQuantity',
          label: 'DCU Quantity',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

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
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'catDriveStatus',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            '30 Gallon',
            '85 Gallon',
          ],
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
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'controllerSpecialOptions',
          label:
          'Special Options to Add onto Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
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

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Inverted: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnits',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          hintText: 'Diameter',
          imagePath: AppAssets.etioB,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackG',
          label: 'Enclosed Track (Inverted) Power Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: AppAssets.etioG,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackH',
          label: 'Enclosed Track (Inverted) Power Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: AppAssets.etioH,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackS',
          label:
          'Enclosed Track (Inverted) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.etioS,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackK2',
          label: 'Enclosed Track (Inverted) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          imagePath: AppAssets.etioK2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackL2',
          label: 'Enclosed Track (Inverted) Free Rail (L2)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: AppAssets.etioL2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackM2',
          label: 'Enclosed Track (Inverted) Free Rail (M2)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: AppAssets.etioM2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackN2',
          label: 'Enclosed Track (Inverted) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          hintText: 'Top of Power Rail to Bottom of Free Rail',
          imagePath: AppAssets.etioN2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackS2',
          label: 'Enclosed Track (Inverted) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          hintText: 'Center of Trolley Wheel to Center of Trolley Wheel',
          imagePath: AppAssets.etioS2,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Existing app-specific field.
    // Kept optional.
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