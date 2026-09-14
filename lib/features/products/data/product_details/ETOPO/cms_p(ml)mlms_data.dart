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
          key: 'otherChainSize',
          label: 'Please Specify Other Chain Size',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'chainSize',
          visibleWhenValue: 'Other',
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
          key: 'otherIndustrialChainManufacturer',
          label: 'Please Specify Other Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'industrialChainManufacturer',
          visibleWhenValue: 'Other',
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
            'Meter',
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
          required: false,
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
            'Indoor',
            'Outdoor',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherAppEnviroment',
          label: 'Please Specify Other Application Environment',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label:
          'Temperature of Surrounding Area at Planned Location of '
              'Lubrication System is below 30°F or above 120°F?',
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
      id: 'enclosed_track_overhead_measurements',
      title: 'Enclosed Track Overhead: Measurements',
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
          label:
          'Enclosed Track (Overhead) Power Trolley Wheel (B) - Diameter',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/B.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackG',
          label:
          'Enclosed Track (Overhead) Power Rail (G) - Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/G.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackH',
          label:
          'Enclosed Track (Overhead) Power Rail (H) - Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/H.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackS',
          label:
          'Enclosed Track (Overhead) Trolley Pitch [Spacing] Minimum - '
              'For variable pitch chain, Provide the Minimum Pitch Dimension '
              '(S) - Center of Power Wheel to Center of Power Wheel',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/S.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackK2',
          label:
          'Enclosed Track (Overhead) Free Trolley Wheel (K2) - Diameter',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/K2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackL2',
          label:
          'Enclosed Track (Overhead) Free Rail (L2) - Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/L2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackM2',
          label:
          'Enclosed Track (Overhead) Free Rail (M2) - Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/M2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackN2',
          label:
          'Enclosed Track (Overhead) Free Rail Vertical Position '
              '(Height) (N2) - Top of Power Rail to Bottom of Free Rail',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/N2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackS2',
          label:
          'Enclosed Track (Overhead) Power Trolley Wheel Pitch (S2) - '
              'Center of Trolley Wheel to Center of Trolley Wheel',
          type: ProductFieldType.text,
          required: true,
          imagePath: 'assets/Measurements/4/CMS/S2.png',
        ),
      ],
    ),
  ],
);