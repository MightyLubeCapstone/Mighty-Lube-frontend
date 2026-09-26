import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfoPortableMultiLineMonitoringSystemData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PFO_CMS_PMLMS',
  title: 'Portable (Multi-Line) Mighty Lube® Monitoring System',
  imagePath: AppAssets.PFO_CMS_PMLMS,

  description: 'The Next Generation Portable chain wear monitoring system has a '
      'lightweight frame and battery power to allow customers to easily '
      'move the unit from one conveyor to another. The user-friendly '
      'software comes preloaded on a Windows tablet and provides link by '
      'link as well as 10-foot data.',

  configurationSections: [
    // =========================================================
    // GENERAL INFORMATION
    // =========================================================

    ProductConfigurationSection(
      id: 'generalInformation',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorChainSize',
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
          key: 'chainManufacturer',
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
          label: 'Conveyor Speed Length',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Feet / minute',
            'Meters /minute',
          ],
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
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
          key: 'applicationEnvironment',
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
          key: 'surroundingTemperature',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorOrientation',
          label:
          'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Overhead',
            'Inverted',
            'Inverted/Inverted',
          ],
        ),
      ],
    ),

    // =========================================================
    // CUSTOMER POWER UTILITIES
    // =========================================================

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltageSinglePhase',
          label: 'Operating Voltage - Single Phase: (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =========================================================
    // MONITORING FEATURES REQUESTED
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoringFeaturesRequested',
      title: 'Monitoring Features Requested',
      fields: [
        ProductFieldData(
          key: 'paintMarkerSystem',
          label: 'Paint Marker System',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // CONVEYOR SPECIFICATIONS
    // =========================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'conveyorChainClean',
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

    // =========================================================
    // INVERTED P&F: MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'invertedPowerAndFreeMeasurements',
      title: 'Inverted P&F: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
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
          key: 'invertedPowerAndFreeChainDropA',
          label: 'Inverted Power and Free Chain Drop (A)',
          hintText: 'Center of Chain to Opposite Edge of Rail',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CLS_9000l_A,
        ),

        ProductFieldData(
          key: 'invertedPowerAndFreeRailG',
          label: 'Inverted Power and Free Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CLS_9000l_G2,
        ),

        ProductFieldData(
          key: 'invertedPowerAndFreeRailH',
          label: 'Inverted Power and Free Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CLS_9000l_H2,
        ),
      ],
    ),

    // =========================================================
    // TECHNICIAN NOTE
    // Internal application workflow field.
    // =========================================================

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          multiline: true,
          required: false,
          hintText:
          'Enter any additional notes or instructions here...',
        ),
      ],
    ),
  ],
);