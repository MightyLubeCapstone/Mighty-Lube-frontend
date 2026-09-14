import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData inFloorTowLineMightyLubeData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'IFT_IFTL',
  title: 'Mighty Lube In Floor Tow Line',
  imagePath: AppAssets.inFloorTowLineMainProduct,
  // Old Flutter description was placeholder content for
  // another product, so it is intentionally not reused.
  description: 'Mighty Lube In Floor Tow Line.',

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
        // Website recording only confirmed "Other".
        // Legacy options are intentionally not promoted to
        // current website truth.
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
          label: 'Conveyor Chain Size - Other Details',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
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
          options: [
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherChainManufacturer',
          label: 'Chain Manufacturer - Other Details',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'chainManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet / minute',
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
        ),

        // Current website extraction identified this as a
        // text box, so legacy Right-to-Left / Left-to-Right
        // dropdown is intentionally not reused.
        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.text,
        ),

        // Website confirmed "Other" and conditional input.
        // Other environment options were not confirmed.
        ProductFieldData(
          key: 'applicationEnvironment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherApplicationEnvironment',
          label: 'Application Environment - Other Details',
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

        // Exact option labels were not confirmed from the
        // website recording, therefore kept as text rather
        // than importing legacy Loaded/Unloaded values.
        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.text,
          required: true,
        ),

        // Current website extraction identifies this as text.
        ProductFieldData(
          key: 'conveyorStrand',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.text,
        ),

        // ---------------------------------------------------
        // WEBSITE ALSO CONTAINS:
        //
        // I Have A Plant Layout To Attach
        // I Have The Required Pictures Of Each Chain To Attach
        //
        // Generic ProductConfigurationForm currently supports
        // text/dropdowns but not file attachment inputs.
        // These are intentionally not represented here yet.
        // ---------------------------------------------------
      ],
    ),

    // =======================================================
    // CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'power',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase: (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // NEW / EXISTING MONITORING SYSTEM
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoring',
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
      id: 'specifications',
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
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'sliderPlates',
          label: 'Slider Plates',
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
          key: 'rollerChains',
          label: 'Roller Chains',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'bushings',
          label: 'Bushings',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'riderPlates',
          label: 'Rider Plates',
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
          key: 'caterpillarDrive',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'caterpillarDriveQuantity',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
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
          key: 'externalLubrication',
          label: 'External Lubrication',
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
        ProductFieldData(
          key: 'lubricationFromSideOfChain',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'lubricationFromTopOfChain',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.dropdown,
          options: [
            '10 Gallon',
            '65 Gallon',
          ],
        ),
        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'conveyorChainClean',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
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
    // ADDITIONAL OPTIONS AVAILABLE
    // =======================================================

    ProductConfigurationSection(
      id: 'additionalOptions',
      title: 'Additional Options Available',
      fields: [
        ProductFieldData(
          key: 'washDown',
          label: 'Wash Down',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =======================================================
    // IN FLOOR TOWLINE MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'In Floor Towline: Measurements',
      fields: [
        // Website only visibly confirmed "Feet".
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
          hintText: 'Outside of Rail Channel to Outside of Rail Channel',
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
          key: 'inFloorTowlineConveyorHousingOffsetW1',
          label: 'In Floor Towline Conveyor Housing Offset (W1)',
          type: ProductFieldType.text,
          hintText: 'Outside of Housing to Center of Chain',
        ),
        ProductFieldData(
          key: 'inFloorTowlineFloorX1',
          label: 'In Floor Towline Floor (X1)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
        ),

        // Two additional dropdowns were visible in the website
        // recording, but their labels/options were not readable.
        // They are intentionally not invented here.
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    // =======================================================

    ProductConfigurationSection(
      id: 'technician',
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