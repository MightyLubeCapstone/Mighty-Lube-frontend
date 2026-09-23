import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData inFloorTowLineOp40eData = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'IFT_OP4OE',
  title: 'OP-40E',
  imagePath: AppAssets.inFloorTowLineOp40e,
  // Old Flutter description was placeholder content for OP-8SS,
  // so it is intentionally not reused.
  description: 'OP-40E In Floor Tow Line Conveyor Lubricator.',

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

        // ---------------------------------------------------
        // CONVEYOR CHAIN SIZE
        //
        // Website recording only confirmed "Other".
        // Legacy options are intentionally not promoted to
        // current website truth.
        // ---------------------------------------------------

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
          key: 'otherConveyorChainSize',
          label: 'Conveyor Chain Size - Other Details',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
          required: true,
        ),

        // ---------------------------------------------------
        // CHAIN MANUFACTURER
        //
        // Website recording only confirmed "Other".
        // ---------------------------------------------------

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
            required: true
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
            required: true
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
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        // Current website extraction identified this as a
        // text box, so legacy Right-to-Left / Left-to-Right
        // dropdown is intentionally not reused.
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

        // Website confirmed "Other" and conditional input.
        // Other environment options were not confirmed.
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
          label: 'Application Environment - Other Details',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemperature',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        // Exact option labels were not confirmed from the
        // website recording, therefore kept as text rather
        // than importing legacy Loaded/Unloaded values.
        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        // Current website extraction identifies this as text.
        ProductFieldData(
          key: 'conveyorStrand',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Single',
            'Double',
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
          key: 'chainPicture',
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
            'No Applicable',
            'Open Inside',
            'Open Outside',
          ],
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
          key: 'freeTrolleyWheels',
          label: 'Free Trolley Wheels',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'guideRollers',
          label: 'Guide Rollers',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'guideRollersOpenRaceStyle',
          label: 'Guide Rollers Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'No Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),

        ProductFieldData(
          key: 'guideRollersSealedStyle',
          label: 'Guide Rollers Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),

        ProductFieldData(
          key: 'openHole',
          label: 'Open Hole',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'dogActuator',
          label: 'Dog Actuator',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'pivotPoints',
          label: 'Pivot Points',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'kingPin',
          label: 'King Pin',
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
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true
        ),

        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true
        ),

        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true
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
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Required',
            '12 Hours',
            '1000 Hour'
          ],
        ),

        ProductFieldData(
          key: 'electricOnOff',
          label: 'Electric On/Off',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'pneumaticOnOff',
          label: 'Pneumatic On/Off',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'otherControllerDescription',
          label: 'Other Describe',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),

        // Website shows a selectable field here, but the
        // dropdown options were not opened in the recording.
        // Keeping it as text prevents inventing values.
        ProductFieldData(
          key: 'specialControllerOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
          required: true
        ),

        ProductFieldData(
          key: 'controllerSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          multiline: true,
          required: true
        ),
      ],
    ),

    // =======================================================
    // IN FLOOR TOWLINE: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'In Floor Towline: Measurements',
      fields: [
        // Website only visibly confirmed "Feet".
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
          hintText: 'Feet',
        ),

        ProductFieldData(
            key: 'inFloorTowlineChainDropA',
            label: 'In Floor Towline Chain Drop (A)',
            type: ProductFieldType.text,
            hintText: 'Top of Rail to Center of Chain',
            required: true,
            imagePath: AppAssets.FTL_CLS_MLFTL_A
        ),
        ProductFieldData(
            key: 'inFloorTowlinePowerTrolleyWheelB',
            label: 'In Floor Towline Power Trolley Wheel (B)',
            type: ProductFieldType.text,
            hintText: 'Diameter',
            required: true,
            imagePath: AppAssets.FTL_CLS_MLFTL_B
        ),
        ProductFieldData(
          key: 'inFloorTowlinePowerRailG',
          label: 'In Floor Towline Power Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_G,
        ),
        ProductFieldData(
          key: 'inFloorTowlinePowerRailH',
          label: 'In Floor Towline Power Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_H,
        ),
        ProductFieldData(
          key: 'inFloorTowlineRailOffsetJ',
          label: 'In Floor Towline Rail Offset (J)',
          type: ProductFieldType.text,
          hintText: 'Outside of Rail Channel to Outside of Rail Channel',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_J,
        ),
        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingS1',
          label: 'In Floor Towline Conveyor Housing (S1)',
          type: ProductFieldType.text,
          hintText: 'Depth',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_S1,
        ),
        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingT1',
          label: 'In Floor Towline Conveyor Housing (T1)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_T1,
        ),
        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingWallU1',
          label: 'In Floor Towline Conveyor Housing Wall (U1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_U1,
        ),
        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingV1',
          label: 'In Floor Towline Conveyor Housing Floor (V1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_V1,
        ),
        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingOffsetW1',
          label: 'In Floor Towline Conveyor Housing Offset (W1)',
          type: ProductFieldType.text,
          hintText: 'Outside of Housing to Center of Chain',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_W1,
        ),
        ProductFieldData(
          key: 'inFloorTowlineFloorX1',
          label: 'In Floor Towline Floor (X1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
          required: true,
          imagePath: AppAssets.FTL_CLS_MLFTL_X1,
        ),

        // Two additional dropdowns were visible in the website
        // recording, but their labels/options were not readable.
        // They are intentionally not invented here.
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Retained from the existing workflow.
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