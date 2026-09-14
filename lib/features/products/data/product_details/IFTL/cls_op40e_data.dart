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
        // ---------------------------------------------------
        // Name of Conveyor System
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
        ),

        // ---------------------------------------------------
        // Conveyor Chain Size
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

        ProductFieldData(
          key: 'otherConveyorChainSize',
          label: 'Other Conveyor Chain Size',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
        ),

        // ---------------------------------------------------
        // Chain Manufacturer
        //
        // Only "Other" was confirmed from the current
        // website recording. Legacy Flutter options are not
        // treated as current website options.
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

        // ---------------------------------------------------
        // Conveyor Length
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
        ),

        // Only Feet was confirmed in the website recording.
        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.text,
          hintText: 'Feet',
        ),

        // ---------------------------------------------------
        // Conveyor Speed
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
        ),

        // Only Feet / minute was confirmed in the recording.
        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.text,
          hintText: 'Feet / minute',
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
        // Application Environment
        // ---------------------------------------------------

        ProductFieldData(
          key: 'applicationEnvironment',
          label: 'Application Environment',
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

        // ---------------------------------------------------
        // Temperature
        // ---------------------------------------------------

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

        // ---------------------------------------------------
        // Loaded / Unloaded
        //
        // Website confirms this is a dropdown, but the exact
        // option labels were not clearly opened in recording.
        // Keeping as text avoids inventing options.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.text,
          required: true,
        ),

        // ---------------------------------------------------
        // Conveyor Swing / Sway
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),

        // ---------------------------------------------------
        // Single / Double Strand
        //
        // Dropdown was visible, but its options were not opened.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorStrand',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.text,
        ),

        // ---------------------------------------------------
        // WEBSITE ATTACHMENTS
        //
        // The current website also contains:
        //
        // I Have A Plant Layout To Attach
        // I Have The Required Pictures Of Each Chain To Attach
        //
        // These are intentionally not added here because the
        // reusable ProductConfigurationForm currently does not
        // support file attachment fields.
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

        // Website shows a selectable field here, but the
        // dropdown options were not opened in the recording.
        // Keeping it as text prevents inventing values.
        ProductFieldData(
          key: 'specialControllerOptions',
          label:
          'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
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
    // IN FLOOR TOWLINE: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'In Floor Towline: Measurements',
      fields: [
        // Only Feet was visibly confirmed.
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.text,
          hintText: 'Feet',
        ),

        ProductFieldData(
          key: 'inFloorTowlineChainDropA',
          label: 'In Floor Towline Chain Drop (A)',
          type: ProductFieldType.text,
          hintText: 'Top of Rail to Center of Chain',
        ),

        ProductFieldData(
          key: 'inFloorTowlinePowerTrolleyWheelB',
          label: 'In Floor Towline Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
        ),

        ProductFieldData(
          key: 'inFloorTowlinePowerRailG',
          label: 'In Floor Towline Power Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'inFloorTowlinePowerRailH',
          label: 'In Floor Towline Power Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
        ),

        ProductFieldData(
          key: 'inFloorTowlineRailOffsetJ',
          label: 'In Floor Towline Rail Offset (J)',
          type: ProductFieldType.text,
          hintText:
          'Outside of Rail Channel to Outside of Rail Channel',
        ),

        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingS1',
          label: 'In Floor Towline Conveyor Housing (S1)',
          type: ProductFieldType.text,
          hintText: 'Depth',
        ),

        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingT1',
          label: 'In Floor Towline Conveyor Housing (T1)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingWallU1',
          label: 'In Floor Towline Conveyor Housing Wall (U1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
        ),

        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingFloorV1',
          label: 'In Floor Towline Conveyor Housing Floor (V1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
        ),

        ProductFieldData(
          key: 'inFloorTowlineConveyorHousingOffsetW1',
          label: 'In Floor Towline Conveyor Housing Offset (W1)',
          type: ProductFieldType.text,
          hintText: 'Outside of Housing to Center of Chain',
        ),

        ProductFieldData(
          key: 'inFloorTowlineFloorX1',
          label: 'In Floor Towline Floor (X1)',
          type: ProductFieldType.text,
        ),
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