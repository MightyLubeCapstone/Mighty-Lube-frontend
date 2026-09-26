import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfoOp8npNonPowerBrushCleaningSystemData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PFO_CCS_OP8NP',
  title: 'OP-8NP Non-Power Brush Cleaning System I-Beam Conveyor Chain Cleaner',
  imagePath: AppAssets.PFO_CCS_OP8NP,
  description: 'The Mighty Lube Non-Powered I-Beam Conveyor Chain Cleaner is a brush system that cleans the chain and trolleys on I-Beam conveyors as the chain travels. This chain cleaning brush assembly removes debris which helps to reduce rejects without contaminating parts. The chain cleaner adjusts to contact hard to reach points and is spring loaded to prevent jamming if a hanger passes at an odd angle.',

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
          options: [
            'Feet / minute',
            'Meters /minute',
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
          key: 'conveyorOrientation',
          label: 'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Overhead',
            'Inverted',
            'Inverted/Inverted',
          ],
        ),
      ],
    ),

    // =======================================================
    // P&F: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'powerAndFreeMeasurements',
      title: 'P&F: Measurements',
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
          key: 'freeTrolleyWheelPositionVerticalL',
          label: 'Overhead P&F Free Rail Free Trolley Wheel Position (Vertical) (L)',
          hintText: 'Center of Free Trolley Wheel to Bottom of Rail',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_L
        ),

        ProductFieldData(
          key: 'overheadFreeRailG',
          label: 'Overhead P&F Free Rail Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_G,
        ),

        ProductFieldData(
          key: 'overheadFreeRailH',
          label: 'Overhead P&F Free Rail Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_H,
        ),

        ProductFieldData(
          key: 'invertedPowerAndFreeChainDropA',
          label: 'Inverted Power and Free Chain Drop (A)',
          hintText: 'Center of Chain to Opposite Edge of Rail',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_A,
        ),

        ProductFieldData(
          key: 'invertedPowerAndFreeRailG',
          label: 'Inverted Power and Free Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_G2,
        ),

        ProductFieldData(
          key: 'invertedPowerAndFreeRailH',
          label: 'Inverted Power and Free Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_H2,
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