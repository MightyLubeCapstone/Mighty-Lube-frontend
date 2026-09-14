import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData inBoardRollerChainOp40eData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'IBR_OP4OE',

  title: 'OP-40E',

  imagePath: AppAssets.inBoardRollerChainOp40e,

  description:
  'OP-40E lubrication system for In-Board Roller Chain conveyor applications.',

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
        ),

        // ---------------------------------------------------
        // CONVEYOR CHAIN SIZE
        //
        // Website confirms multiple values exist,
        // but only "Other" was explicitly confirmed.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: [
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherConveyorChainSize',
          label: 'Other Conveyor Chain Size',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
        ),

        // ---------------------------------------------------
        // CHAIN MANUFACTURER
        // ---------------------------------------------------

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
          options: [
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherChainManufacturer',
          label: 'Other Chain Manufacturer',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'chainManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
        ),

        // Exact unit options were not fully exposed
        // in the recording, therefore not invented.
        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.text,
          hintText: 'Enter/select conveyor length unit',
        ),

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.text,
          hintText: 'Enter/select conveyor speed unit',
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.text,
        ),

        // ---------------------------------------------------
        // APPLICATION ENVIRONMENT
        // ---------------------------------------------------

        ProductFieldData(
          key: 'applicationEnvironment',
          label: 'Application Environment *',
          type: ProductFieldType.dropdown,
          options: [
            'Other',
          ],
          required: true,
        ),

        ProductFieldData(
          key: 'otherApplicationEnvironment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemperature',
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        // Website confirms dropdown,
        // but exact options were not visibly exposed.
        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Enter loaded/unloaded condition',
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),

        // Website confirms dropdown,
        // but exact options were not visibly exposed.
        ProductFieldData(
          key: 'conveyorStrand',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.text,
          hintText: 'Enter strand configuration',
        ),

        // ---------------------------------------------------
        // ATTACHMENTS
        //
        // Current generic ProductConfigurationForm does not
        // support file upload, so plant-layout and chain-image
        // file controls are intentionally not represented here.
        // ---------------------------------------------------
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
          label: 'Operating Voltage - Single Phase: (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // MONITORING SYSTEM
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
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
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'wheelSealedStyle',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'openInsideShieldedOutside',
          label: 'Open Inside / Shielded Outside',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'freeTrolleyWheels',
          label: 'Free Trolley Wheels',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'guideRollers',
          label: 'Guide Rollers',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'guideRollersOpenRaceStyle',
          label: 'Guide Rollers Open Race Style',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'guideRollersSealedStyle',
          label: 'Guide Rollers Sealed Style',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'openHole',
          label: 'Open Hole',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'dogActuator',
          label: 'Dog Actuator',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'pivotPoints',
          label: 'Pivot Points',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'kingPin',
          label: 'King Pin',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'railLubrication',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
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
        ProductFieldData(
          key: 'chainMasterController',
          label: 'ChainMaster Controller',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'electricOnOff',
          label: 'Electric On/Off',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'pneumaticOnOff',
          label: 'Pneumatic On/Off',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'otherControllerDescription',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),

        // Dropdown exists on website, but its complete option
        // list was not exposed in the recording.
        ProductFieldData(
          key: 'specialControllerOptions',
          label:
          'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
          multiline: true,
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
          hintText: 'Diameter',
        ),
        ProductFieldData(
          key: 'inBoardRollerChainRollerWheelB1',
          label: 'In Board Roller Chain Roller Wheel (B1)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),
        ProductFieldData(
          key: 'inBoardRollerChainLinkC1',
          label: 'In Board Roller Chain Link (C1)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),
        ProductFieldData(
          key: 'inBoardRollerChainLinkD1',
          label: 'In Board Roller Chain Link (D1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
        ),
        ProductFieldData(
          key: 'inBoardRollerChainOuterLinkOffsetF1',
          label: 'In Board Roller Chain Outer Link Offset (F1)',
          type: ProductFieldType.text,
          hintText: 'Outside to Outside of Outer Links',
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
          multiline: true,
          required: true,
        ),
      ],
    ),
  ],
);