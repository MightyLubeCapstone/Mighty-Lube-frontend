import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData proteinFoodGradeLubricationMonitorData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PROTEIN_FGLM',
  title: 'Food Grade Lubrication and Monitor',
  imagePath: AppAssets.PROTEIN_FGLAM,

  description: 'Mighty Lube has created conveyor maintenance equipment and lubricants '
      'to meet the specific needs of food industry manufacturers including '
      'poultry plants. Our food processing conveyor lubricators, monitoring '
      'systems and H1 lubricants have been tested and proven to provide '
      'significant cost savings in food industry conveyor operations.',

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

        // -----------------------------------------------------
        // Source identifies Conveyor Chain Size but does not
        // provide its dropdown values in the supplied data.
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
        // Wheel Manufacturer
        //
        // Options are not present in supplied source.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'wheelManufacturer',
          label: 'Wheel Manufacturer',
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
        // Chain Pin Type
        //
        // Source marks this field required but does not provide
        // its available values.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'chainPinType',
          label: 'Chain Pin Type',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Bolts',
            'Pin',
            'Log'
          ]
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Source currently exposes Feet.
        // -----------------------------------------------------

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

        // -----------------------------------------------------
        // Source currently exposes Feet / minute.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Feet / minute',
            'Meters/ Minute'
          ],
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Direction of Travel
        //
        // Options are not present in supplied source.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Right to Left',
            'Left to Right'
          ]
        ),


        // -----------------------------------------------------
        // What Type of Metal
        //
        // Required according to source.
        // Options are not supplied.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'metalType',
          label: 'What Type of Metal',
          type: ProductFieldType.text,
          required: true,
          options: [
            'Stainless Steel',
            'Zinc',
            'Mild Steel',
            'Other'
          ]
        ),

        // -----------------------------------------------------
        // Style of Conveyor
        //
        // Required according to source.
        // Options are not supplied.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'conveyorStyle',
          label: 'Style of Conveyor',
          type: ProductFieldType.text,
          required: true,
          options: [
            'I-Beam',
            'Meyn',
            'Sani Track',
            'T Rail',
            'Other'
          ]
        ),


        // -----------------------------------------------------
        // Color of Trolley
        //
        // Required according to source.
        // Options are not supplied.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'trolleyColor',
          label: 'Color of Trolley',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Blue',
            'Green',
            'Gray',
            'Other'
          ]
        ),


        // -----------------------------------------------------
        // Type of Trolley
        //
        // Source provides the field but no available values.
        // -----------------------------------------------------

        // -----------------------------------------------------
        // Type of Trolley
        //
        // Dropdown options confirmed from the provided
        // reference image.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'trolleyType',
          label: 'Type of Trolley',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Meyn Trolley Halve Green Wheel Bolt Version',
            'Meyn Plastic Quick Version',
            'Meyn Stainless Steel Halve with Green Wheel',
            'Meyn Stainless Steel Halve Gray Wheel',
            'Stork Halve Bolt Version Blue Wheel',
            'Linco Plastic Halve Blue Wheel',
          ],
        ),

        // -----------------------------------------------------
        // Application Environment
        //
        // Required according to source.
        // Supplied source does not contain the option values.
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
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.text,
          required: true,
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
          key: 'plantLayoutToAttach',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        ProductFieldData(
          key: 'requiredPicturesToAttach',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes - Will Attach',
            'No - Do Not Have',
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

        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =========================================================
    // NEW MONITORING SYSTEM OR ADDING TO EXISTING
    // MONITORING SYSTEM
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
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
    // MONITORING FEATURES REQUESTED
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoringFeaturesRequested',
      title: 'Monitoring Features Requested',
      fields: [
        ProductFieldData(
          key: 'driveMotorAmp',
          label: 'Drive Motor Amp',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No'
          ]
        ),

        ProductFieldData(
          key: 'driveTakeUpAir',
          label: 'Drive Take-up - Air',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]
        ),

        ProductFieldData(
          key: 'takeUpDistance',
          label: 'Take-Up Distance',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]
        ),

        ProductFieldData(
          key: 'driveMotorTemp',
          label: 'Drive Motor Temp',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]
        ),

        ProductFieldData(
          key: 'driveMotorVibration',
          label: 'Drive Motor Vibration',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]
        ),

        ProductFieldData(
          key: 'dogPitchValidation',
          label: 'Dog Pitch Validation',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]
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
          key: 'lubricationFromSideOfChain',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubricationFromTopOfChain',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'timeLubrication',
          label: 'Time Lubrication',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'timeDelayLubrication',
          label: 'Time Delay Lubrication',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // Reservoir Size
        //
        // Source does not provide available values.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
          required: true,
        ),

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
    // WIRE
    // =========================================================

    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'fourConductor',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        // -----------------------------------------------------
        // First Measurement Unit
        //
        // Source lists Measurement Unit here but does not show
        // the available values.
        // -----------------------------------------------------

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
          key: 'sevenConductor',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'twoConductor',
          label: '2 Conductor',
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

        // -----------------------------------------------------
        // Source contains another Measurement Unit followed
        // explicitly by Feet.
        // Keeping it separate instead of silently merging it
        // with the earlier Measurement Unit.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'wireSecondaryMeasurementUnit',
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
      ],
    ),

    // =========================================================
    // FOOD GRADE LUBRICATION AND MONITOR: MEASUREMENT
    // =========================================================

    ProductConfigurationSection(
      id: 'foodGradeLubricationMonitorMeasurement',
      title: 'Food Grade Lubrication and Monitor: Measurement',
      fields: [
        ProductFieldData(
          key: 'powerTrolleyWheelB',
          label: 'Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'powerRailG',
          label: 'Power Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'powerRailH',
          label: 'Power Rail (H)',
          hintText: 'Height',
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