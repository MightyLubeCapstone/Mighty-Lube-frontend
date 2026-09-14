import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData cChannelOversprayEliminatorBrushData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'FRO_OEB',

  title: 'Overspray Eliminator Brush',

  imagePath: AppAssets.cChannelOversprayEliminatorBrush,

  description:
  'The Overspray Eliminator Brush is also known as the part saver brush '
      'because it prevents contamination of parts by lubricant overspray. '
      'The part saver brush assembly mounts on the conveyor at the location '
      'of the lubricator.',

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
        // ---------------------------------------------------
        // NAME OF CONVEYOR SYSTEM
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
        ),

        // ---------------------------------------------------
        // CONVEYOR CHAIN SIZE
        // Current website values
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            '3/8" Log Chain',
            'Other',
          ],
        ),

        // ---------------------------------------------------
        // CHAIN MANUFACTURER
        // Current website values
        // ---------------------------------------------------

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
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

        // ---------------------------------------------------
        // CONVEYOR LENGTH
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        // ---------------------------------------------------
        // APPLICATION ENVIRONMENT
        // Website-required field
        // ---------------------------------------------------

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

        // ---------------------------------------------------
        // OTHER APPLICATION ENVIRONMENT
        // Visible only when Other is selected
        // ---------------------------------------------------

        ProductFieldData(
          key: 'otherApplicationEnvironment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        // ---------------------------------------------------
        // SURROUNDING TEMPERATURE
        // ---------------------------------------------------

        ProductFieldData(
          key: 'surroundingTemperature',
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System — is it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =======================================================
    // FREE RAIL: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'freeRailMeasurements',
      title: 'Free Rail: Measurements',
      fields: [
        // ---------------------------------------------------
        // MEASUREMENT UNIT
        // ---------------------------------------------------

        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        // ---------------------------------------------------
        // OVERHEAD POWER & FREE
        // ---------------------------------------------------

        ProductFieldData(
          key: 'overheadFreeRailChainDropA',
          label: 'Overhead P&F Free Rail Chain Drop (A)',
          type: ProductFieldType.text,
          hintText: 'Top of Rail to Center of Chain',
          imagePath: 'assets/Measurements/7/CCS/A.png',
        ),

        ProductFieldData(
          key: 'overheadFreeRailPowerTrolleyWheelB',
          label: 'Overhead P&F Free Rail Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          imagePath: 'assets/Measurements/7/CCS/B.png',
        ),

        ProductFieldData(
          key: 'overheadFreeRailRailG',
          label: 'Overhead P&F Free Rail Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: 'assets/Measurements/7/CCS/G.png',
        ),

        ProductFieldData(
          key: 'overheadFreeRailRailH',
          label: 'Overhead P&F Free Rail Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: 'assets/Measurements/7/CCS/H.png',
        ),

        ProductFieldData(
          key: 'overheadFreeRailTrolleyWheelVerticalL',
          label:
          'Overhead P&F Free Rail Free Trolley Wheel Position (Vertical) (L)',
          type: ProductFieldType.text,
          hintText: 'Center of Free Trolley Wheel to Bottom of Rail',
          imagePath: 'assets/Measurements/7/CCS/L.png',
        ),

        // ---------------------------------------------------
        // INVERTED POWER & FREE
        // ---------------------------------------------------

        ProductFieldData(
          key: 'invertedPowerFreeChainDropA',
          label: 'Inverted Power and Free Chain Drop (A)',
          type: ProductFieldType.text,
          hintText: 'Center of Chain to Opposite Edge of Rail',
          imagePath: 'assets/Measurements/7/CCS/A_Color.png',
        ),

        ProductFieldData(
          key: 'invertedPowerFreePowerTrolleyWheelB',
          label: 'Inverted Power and Free Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          imagePath: 'assets/Measurements/7/CCS/B2.png',
        ),

        ProductFieldData(
          key: 'invertedPowerFreeRailG',
          label: 'Inverted Power and Free Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: 'assets/Measurements/7/CCS/G2.png',
        ),

        ProductFieldData(
          key: 'invertedPowerFreeRailH',
          label: 'Inverted Power and Free Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: 'assets/Measurements/7/CCS/H2.png',
        ),

        ProductFieldData(
          key: 'invertedPowerFreeTrolleyWheelPitchK',
          label: 'Inverted Power and Free Trolley Wheel Pitch (K)',
          type: ProductFieldType.text,
          hintText:
          'Center of Trolley Wheel to Center of Trolley Wheel',
          imagePath: 'assets/Measurements/7/CCS/K.png',
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Present in legacy Flutter.
    // Not observed in the supplied website extraction.
    // Retained to preserve the existing product workflow.
    // =======================================================

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),
  ],
);