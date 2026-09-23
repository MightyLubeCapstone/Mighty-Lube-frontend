import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadOversprayEliminatorBrushData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_BRUSH',
  title: 'Overspray Eliminator Brush',
  imagePath: AppAssets.OHP_CSS_OEB,
  description: 'Mighty Lube Overspray Eliminator Brush for overhead power rail conveyor systems.',

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
          key: 'otherApplicationEnvironment',
          label: 'Application Environment - Other',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
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
          type: ProductFieldType.text,
          hintText: 'Rail to Center of Chain',
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailG',
          label: 'Overhead Power MonoRail Power Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailH',
          label: 'Overhead Power MonoRail Power Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
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
          required: true,
          multiline: true,
        ),
      ],
    ),
  ],
);