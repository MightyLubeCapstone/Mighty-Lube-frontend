import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfoOp8PowerBrushCleaningSystemData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PFO_CCS_OP8',
  title: 'OP-8 Power Brush Cleaning System Conveyor Chain & Trolley Wheel Cleaner',
  imagePath: AppAssets.PFO_CCS_OP8,
  description: 'The OP-08 powered conveyor brush is a motorized brush assembly that cleans debris and buildup off of conveyor chains, trolley wheels and trolley brackets.',

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
          key: 'directionOfTravel',
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
          key: 'monitoringCapabilitiesRequired',
          label: 'Does the New system require Monitoring Capabilities?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
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
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'installationClearanceConfirmed',
          label: "Confirm Installation Clearance of: Minimum of 2' (.61m) for clearance of Motor Height from Rail AND Motor Gear Housing assembly width",
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
            'No',
          ],
        ),

        ProductFieldData(
          key: 'foodIndustry',
          label: 'Food Industry',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
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
            'Option 1',
          ],
        ),

        ProductFieldData(
          key: 'shroud',
          label: 'Shroud',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Neoprene Curtain',
            'Full Steel Enclosure',
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
          imagePath: AppAssets.PFO_CCS_L,
        ),

        ProductFieldData(
          key: 'overheadFreeRailG',
          label: 'Overhead P&F Free Rail Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_G2
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
          imagePath: AppAssets.PFO_CCS_G,
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
          required: true,
          multiline: true,
        ),
      ],
    ),
  ],
);