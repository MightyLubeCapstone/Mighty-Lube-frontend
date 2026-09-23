import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadYokeCleaningBrushData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_CLEANING_BRUSH',
  title: 'Yoke Cleaning Brush',
  imagePath: AppAssets.OHP_CSS_YCB,
  description: 'Yoke Cleaning Brush for overhead power rail conveyor systems.',

  // =========================================================
  // CONFIGURATION SECTIONS
  // =========================================================

  configurationSections: [
    // =======================================================
    // GENERAL INFORMATION
    // =======================================================

    const ProductConfigurationSection(
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
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherConveyorChainSize',
          label: 'Conveyor Chain Size - Other',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
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
            key: 'otherChainManufacturer',
            label: 'Chain Manufacturer - Other Details',
            type: ProductFieldType.text,
            visibleWhenFieldKey: 'chainManufacturer',
            visibleWhenValue: 'Other',
            required: true
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
          key: 'applicationEnvironment',
          label: 'Application Environment *',
          type: ProductFieldType.dropdown,
          options: [
            'Ambient',
            'Caustic (i.e. Phosphate / E-Coat, etc.)',
            'Dusty',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
          required: true,
        ),

        ProductFieldData(
          key: 'otherApplicationEnvironment',
          label: 'Application Environment - Other',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),
      ],
    ),

    // =======================================================
    // OVERHEAD POWER RAIL MEASUREMENTS
    // =======================================================

    const ProductConfigurationSection(
      id: 'overheadPowerRailMeasurements',
      title: 'Overhead Power Rail Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Meter',
            'Inches',
            'Millimeter',
          ],
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerRailYokeRailH1',
          label: 'Overhead Power Rail Yoke Rail (H1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Measurement',
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    // =======================================================

    const ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          multiline: true,
          required: true,
        ),
      ],
    ),
  ],
);