import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData overheadNonPoweredBrushCleaners300i400i600iData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_3000',
  title: 'Overhead Non-Powered Mighty Lube Brush Cleaners 300I 400I 600I',
  imagePath: AppAssets.OHP_CCS_300I,
  description: 'Overhead Non-Powered Mighty Lube Brush Cleaners 300I, 400I and 600I.',

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
          required: true
        ),

        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          required: true,
          // Only website-confirmed option.
          options: [
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
          required: true
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: true,
          // Only website-confirmed option.
          options: [
            'Feet / minute',
            'Meters / minute',
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
          // Only value clearly shown in the recording.
          options: [
            'No',
            'yes'
          ],
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
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          // Only website-confirmed option.
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
          required: true
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