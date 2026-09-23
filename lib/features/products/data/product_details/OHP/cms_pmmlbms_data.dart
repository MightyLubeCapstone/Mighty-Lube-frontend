import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadPortableMultiLineMonitoringSystemData =
ProductDetailData(
  id: 'OHP_PML',
  title: 'Portable (Multi-Line) Mighty Lube® Monitoring System',
  imagePath: AppAssets.ohprlbCmsPmlms,
  description: 'The Next Generation Portable chain wear monitoring system has a lightweight frame and battery power to allow customers to easily move the unit from one conveyor to another. The user-friendly software comes preloaded on a Windows tablet and provides link by link as well as 10-foot data. ',
  configurationSections: [

    // ============================================================
    // GENERAL INFORMATION
    // ============================================================

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
          label: 'Other – Conveyor Chain Size',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
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
          key: 'otherChainManufacturer',
          label: 'Other – Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'chainManufacturer',
          visibleWhenValue: 'Other',
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
            'Meter',
            'Millimeter',
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
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter'
          ],
        ),

        ProductFieldData(
            key: 'indexingOrVariableSpeedConditions',
            label: 'Indexing or Variable Speed Conditions',
            type: ProductFieldType.text,
            required: true
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
          key: 'otherApplicationEnvironment',
          label: 'Other – Application Environment',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label: 'Is the temperature at the planned lubrication system location below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),


        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorMovement',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // ============================================================
    // CUSTOMER POWER UTILITIES
    // ============================================================

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltageSinglePhase',
          label: 'Operating Voltage - Single Phase: (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // ============================================================
    // MONITORING FEATURES REQUESTED
    // ============================================================

    ProductConfigurationSection(
      id: 'monitoringFeaturesRequested',
      title: 'Monitoring Features Requested',
      fields: [
        ProductFieldData(
          key: 'paintMarkerSystem',
          label: 'Paint Marker System',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // ============================================================
    // CONVEYOR SPECIFICATIONS
    // ============================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'isConveyorClean',
          label: 'Is the conveyor clean?',
          required: true,
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // ============================================================
    // OVERHEAD POWER RAIL MEASUREMENTS
    // ============================================================

    ProductConfigurationSection(
      id: 'overheadPowerRailMeasurements',
      title: 'Overhead Power Rail Measurements',
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
          hintText: 'Feet',
        ),

        ProductFieldData(
          key: 'chainDrop',
          label: 'Chain Drop (A)',
          hintText: 'Rail to Center of Chain',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'powerTrolleyWheelDiameter',
          label: 'Overhead Power MonoRail Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'powerRailWidth',
          label: 'Overhead Power MonoRail Power Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'powerRailHeight',
          label: 'Overhead Power MonoRail Power Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
        ),
      ],
    ),

    // ============================================================
    // TECHNICIAN NOTE
    // ============================================================

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