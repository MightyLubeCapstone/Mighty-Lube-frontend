import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData inBoardRollerChainMightyLubeRollerFlightConveyorData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'IBR_RFC',
  title: 'Mighty Lube Roller Flight Conveyor',
  imagePath: AppAssets.inBoardRollerChainMlrfc,
  description: 'Mighty Lube Roller Flight Conveyor lubrication system.',

  // =========================================================
  // CONFIGURATION SECTIONS
  // =========================================================

  configurationSections: [
    // =======================================================
    // GENERAL INFORMATION
    // =======================================================

    ProductConfigurationSection(
      id: 'general_information',
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
          key: 'industrialChainManufacturer',
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
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
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
          key: 'appEnviroment',
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
          key: 'surroundingTemp',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'plantLayout',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        ProductFieldData(
          key: 'requiredPics',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
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
          key: 'operatingVoltage',
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

    // =======================================================
    // NEW / EXISTING MONITORING SYSTEM
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
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
    // CONVEYOR SPECIFICATIONS
    // =======================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenRaceStyle',
          label: 'Wheel: Open Race Style',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Not Applicable',
              'Open Inside',
              'Open Outside'
            ]
        ),
        ProductFieldData(
          key: 'wheelSealedStyle',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),
        ProductFieldData(
          key: 'openInsideShieldedOutside',
          label: 'Open Inside / Shielded Outside',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'sliderPlates',
          label: 'Slider Plates',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'caterpillarDrive',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'caterpillarDriveQuantity',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'railLubrication',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'externalLubrication',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            '10 Gallon',
            '65 Gallon',
          ],
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
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =======================================================
    // CONTROLLER
    // =======================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        // Website shows this as selectable/dropdown,
        // but its options were not opened.
        ProductFieldData(
          key: 'specialControllerOptions',
          required: true,
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'controllerSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // IN BOARD ROLLER CHAIN: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
        id: 'measurements',
        title: 'In Board Roller Chain: Measurements',
        fields: [
          ProductFieldData(
            key: 'measurementUnit',
            label: 'Measurement Unit',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Inches',
              'Feet',
              'Millimeters',
              'Centimeters',
            ],
          ),
          ProductFieldData(
            key: 'inBoardRollerChainRollerWheelA1',
            label: 'In Board Roller Chain Roller Wheel (A1)',
            type: ProductFieldType.text,
            required: true,
            hintText: 'Diameter',
            imagePath: AppAssets.ibrc_A1,
          ),
          ProductFieldData(
            key: 'inBoardRollerChainRollerWheelB1',
            label: 'In Board Roller Chain Roller Wheel (B1)',
            type: ProductFieldType.text,
            required: true,
            hintText: 'Width',
            imagePath: AppAssets.ibrc_B1,
          ),
          ProductFieldData(
            key: 'inBoardRollerChainLinkC1',
            label: 'In Board Roller Chain Link (C1)',
            type: ProductFieldType.text,
            required: true,
            hintText: 'Width',
            imagePath: AppAssets.ibrc_C1,
          ),
          ProductFieldData(
            key: 'inBoardRollerChainLinkD1',
            label: 'In Board Roller Chain Link (D1)',
            type: ProductFieldType.text,
            required: true,
            hintText: 'Thickness',
            imagePath: AppAssets.ibrc_D1,
          ),
          ProductFieldData(
            key: 'inBoardRollerChainLinkF1',
            label: 'In Board Roller Chain Outer Link Offset (F1)',
            type: ProductFieldType.text,
            required: true,
            hintText: '(Outside to Outside of Outer Links)',
            imagePath: AppAssets.ibrc_F1,
          ),
        ]
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
          multiline: true,
          required: true,
        ),
      ],
    ),
  ],
);