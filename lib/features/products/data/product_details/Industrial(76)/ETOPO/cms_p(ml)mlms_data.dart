import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData etopoPmlmsData = ProductDetailData(
  id: 'ETO_PMLMS',
  title: 'Portable (Multi-Line) Mighty Lube Monitoring System',
  imagePath: AppAssets.etopoPortableMultiLine,

  description:
  'The Next Generation Portable chain wear monitoring system has a '
      'lightweight frame and battery power to allow customers to easily move '
      'the unit from one conveyor to another. The user-friendly software comes '
      'preloaded on a Windows tablet and provides link by link as well as '
      '10-foot data.',

  configurationSections: [
    // =========================================================
    // 1. GENERAL INFORMATION
    // =========================================================

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
            'Feet/Minute',
            'Meter/Minute',
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
            'Left to Right',
            'Right to Left',
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
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // 2. CUSTOMER POWER UTILITIES
    // =========================================================

    ProductConfigurationSection(
      id: 'customer_power_utilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase: (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =========================================================
    // 3. MONITORING FEATURES REQUESTED
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoring_features_requested',
      title: 'Monitoring Features Requested',
      fields: [
        ProductFieldData(
          key: 'paintMarkerSystem',
          label: 'Paint Marker System',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // 4. CONVEYOR SPECIFICATIONS
    // =========================================================

    ProductConfigurationSection(
      id: 'conveyor_specifications',
      title: 'Conveyor Specifications',
      fields: [
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

    // =========================================================
    // 5. ENCLOSED TRACK OVERHEAD MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Inverted: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnits',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
          required: true,
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
          imagePath: AppAssets.etioB,
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
          label:
          'Enclosed Track (Inverted) Free Rail Vertical Position (Height) (N2)',
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