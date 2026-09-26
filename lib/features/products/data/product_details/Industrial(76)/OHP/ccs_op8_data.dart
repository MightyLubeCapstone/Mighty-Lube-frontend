import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData overheadOp8PowerBrushCleaningSystemData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_OP8',
  title: 'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner',
  imagePath: AppAssets.OHP_CSS_OP8,
  description: 'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner.',

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
            required: true
        ),

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
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

        ProductFieldData(
            key: 'conveyorLengthUnit',
            label: 'Conveyor Length Unit',
            type: ProductFieldType.dropdown,
            hintText: 'Enter/select conveyor length unit',
            required: true,
            options: [
              'Feet',
              'Inches',
              'm Meter',
              'mm Millimeter',
            ]
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
          key: 'applicationEnvironment',
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
          key: 'surroundingTemperatureOutsideRange',
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
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage3Phase',
          label: 'Operating Voltage - 3 Phase: (Volts/hz)',
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
    // OP-SS
    // =======================================================

    ProductConfigurationSection(
      id: 'opSs',
      title: 'OP-SS',
      fields: [
        ProductFieldData(
          key: 'poweredNonPoweredAvailable',
          label: 'Powered / Non-Powered Available',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Powered',
            'Non-Powered',
          ],
        ),

        ProductFieldData(
          key: 'brushMaterialsAvailable',
          label: 'Brush Materials Available',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Standard Crimped Steel',
            'Nylon Carbide',
            'Polypropylene',
            'Other'
          ],
        ),

        ProductFieldData(
          key: 'installationClearanceConfirmed',
          label: "Confirm Installation Clearance of: Minimum of 2' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width",
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No'
          ],
        ),
      ],
    ),

    // =======================================================
    // ADDITIONAL OPTIONS AVAILABLE
    // =======================================================

    ProductConfigurationSection(
      id: 'additionalOptionsAvailable',
      title: 'Additional Options Available',
      fields: [
        ProductFieldData(
          key: 'washDown',
          label: 'Wash Down',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No'
          ],
        ),

        ProductFieldData(
          key: 'foodIndustry',
          label: 'Food Industry',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No'
          ],
        ),

        ProductFieldData(
          key: 'powerPanelWithTimer',
          label: 'Power Panel with Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Option 1',
          ],
        ),

        ProductFieldData(
          key: 'threeStationPushButtonSwitch',
          label: '3-Station Push Button Switch',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Option 1'
          ],
        ),

        ProductFieldData(
          key: 'shroud',
          label: 'Shroud',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Neoprene Curtain',
            'Full Steel Enclosure'
            // Exact options were not clearly visible.
          ],
        ),

        ProductFieldData(
          key: 'otherAdditionalOptions',
          label: 'Other (Describe)',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // OVERHEAD POWER RAIL: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'overheadPowerRailMeasurements',
      title: 'Overhead Power Rail: Measurements',
      fields: [
        ProductFieldData(
          key: 'freeRailMeasurementUnit',
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
          key: 'chainDropA',
          label: 'Chain Drop (A)',
          hintText: 'Rail to Center of Chain',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerTrolleyWheelB',
          label: 'Overhead Power MonoRail Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailG',
          label: 'Overhead Power MonoRail Power Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailH',
          label: 'Overhead Power MonoRail Power Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    // =======================================================

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
      ],
    ),
  ],
);