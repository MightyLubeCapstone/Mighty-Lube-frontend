import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData proteinFoodGradeCleanerOp8ssData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PROTEIN_OP8SS',
  title: 'Food Grade Cleaner OP-8SS',
  imagePath: AppAssets.PROTEIN_FGCO,

  description: 'The Aluminum and Stainless Steel OP-8SS Powered Brush assembly '
      'cleans the chains and trolley for conveyors in food industry plants. '
      'TheOP-8SS powered brush assembly cleans conveyor chains, trolley '
      'wheels and trolley brackets. It fits every size of overhead monorail '
      'or power & free conveyor.',

  configurationSections: [
    // =========================================================
    // GENERAL INFORMATION
    // =========================================================

    ProductConfigurationSection(
      id: 'generalInformation',
      title: 'General Information',
      fields: [
        // -----------------------------------------------------
        // Name of Conveyor System
        // -----------------------------------------------------

        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Conveyor Chain Size
        // -----------------------------------------------------

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

        // -----------------------------------------------------
        // Protein Chain Manufacturer
        // -----------------------------------------------------

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Protein: Chain Manufacturer',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Green Line',
            'Frost',
            'M&M',
            'Stork',
            'Meyn',
            'Linco',
            'DC',
            'Merel',
            'D&F',
            'Other',
          ],
        ),

        // -----------------------------------------------------
        // Conveyor Length Unit
        //
        // Source contains the label twice, but only one actual
        // dropdown/value is represented here.
        // -----------------------------------------------------

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

        // -----------------------------------------------------
        // Direction of Travel
        // -----------------------------------------------------

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Right to left',
            'Left to right',
          ],
        ),

        // -----------------------------------------------------
        // Application Environment
        // -----------------------------------------------------

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
        // -----------------------------------------------------
        // Surrounding Temperature
        // -----------------------------------------------------

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

        // -----------------------------------------------------
        // Conveyor Loaded / Unloaded
        // -----------------------------------------------------

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
          key: 'operatingVoltageThreePhase',
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

    // =========================================================
    // OP-SS
    // =========================================================

    ProductConfigurationSection(
      id: 'opSs',
      title: 'OP-SS',
      fields: [
        ProductFieldData(
          key: 'installationClearanceConfirmed',
          label: "Confirm Installation Clearance of: Minimum of 2' (.61m) "
              'for clearance of Motor Height from Rail AND Motor Gear '
              'Housing assembly width',
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
    // ADDITIONAL OPTIONS AVAILABLE
    // =========================================================

    ProductConfigurationSection(
      id: 'additionalOptionsAvailable',
      title: 'Additional Options Available:',
      fields: [
        // -----------------------------------------------------
        // Wash Down
        // -----------------------------------------------------

        ProductFieldData(
          key: 'washDown',
          label: 'Wash Down',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        // -----------------------------------------------------
        // Food Industry
        // -----------------------------------------------------

        ProductFieldData(
          key: 'foodIndustry',
          label: 'Food Industry',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        // -----------------------------------------------------
        // Power Panel with Timer
        //
        // Source currently provides only "Option 1".
        // -----------------------------------------------------

        ProductFieldData(
          key: 'powerPanelWithTimer',
          label: 'Power Panel with Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Option 1',
          ],
        ),

        // -----------------------------------------------------
        // 3-Station Push Button Switch
        //
        // Source currently provides only "Option 1".
        // -----------------------------------------------------

        ProductFieldData(
          key: 'threeStationPushButtonSwitch',
          label: '3-Station Push Button Switch',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Option 1',
          ],
        ),

        // -----------------------------------------------------
        // Totally Enclosed Food-Grade Metal Shroud
        //
        // Source currently provides only "Option 1".
        // -----------------------------------------------------

        ProductFieldData(
          key: 'totallyEnclosedFoodGradeMetalShroud',
          label: 'Totally Enclosed Food-Grade Metal Shroud',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Option 1',
          ],
        ),

        // -----------------------------------------------------
        // Other
        // -----------------------------------------------------

        ProductFieldData(
          key: 'otherAdditionalOptions',
          label: 'Other (Describe)',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),
      ],
    ),

    // =========================================================
    // WIRE
    // =========================================================

    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'wireMeasurementUnit',
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
          key: 'twoConductor',
          label: '2 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'fourConductor',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'sevenConductor',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'twelveConductor',
          label: '12 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'junctionBoxQuantities',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =========================================================
    // FOOD GRADE CLEANER OP-8SS: MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'foodGradeCleanerOp8ssMeasurements',
      title: 'Food Grade Cleaner OP-8SS: Measurements',
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

        // -----------------------------------------------------
        // Chain Drop (A)
        // -----------------------------------------------------

        ProductFieldData(
          key: 'chainDropA',
          label: 'Chain Drop (A)',
          hintText: 'Rail to Center of Chain',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Power Trolley Wheel (B)
        // -----------------------------------------------------

        ProductFieldData(
          key: 'powerTrolleyWheelB',
          label: 'Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Power Rail (G)
        // -----------------------------------------------------

        ProductFieldData(
          key: 'powerRailG',
          label: 'Power Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Power Rail (H)
        // -----------------------------------------------------

        ProductFieldData(
          key: 'powerRailH',
          label: 'Power Rail (H)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),


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