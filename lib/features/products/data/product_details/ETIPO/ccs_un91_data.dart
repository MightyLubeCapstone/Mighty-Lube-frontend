import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData etipoUn91Data = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'ETI_91',
  title: 'Overhead Non-Powered Mighty Lube Rail Cleaners UN91, RW91',
  imagePath: AppAssets.etipoRailCleanersUn91,
  description: 'Overhead non-powered Mighty Lube rail cleaner configuration for UN91 and RW91 systems.',

  // =========================================================
  // CONFIGURATION
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
        // NAME OF CONVEYOR SYSTEM
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),

        // ---------------------------------------------------
        // CONVEYOR CHAIN SIZE
        //
        // Options confirmed directly from latest website.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'chainSize',
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

        // ---------------------------------------------------
        // OTHER CHAIN SIZE
        //
        // Website shows this field only when Other is selected.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'otherChainSize',
          label: 'Other Chain Size',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Enter conveyor chain size',
          visibleWhenFieldKey: 'chainSize',
          visibleWhenValue: 'Other',
        ),

        // ---------------------------------------------------
        // CHAIN MANUFACTURER
        //
        // Options confirmed directly from latest website.
        // ---------------------------------------------------

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

        // ---------------------------------------------------
        // OTHER MANUFACTURER
        // ---------------------------------------------------

        ProductFieldData(
          key: 'otherIndustrialChainManufacturer',
          label: 'Other Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Enter chain manufacturer',
          visibleWhenFieldKey:
          'industrialChainManufacturer',
          visibleWhenValue: 'Other',
        ),

        // ---------------------------------------------------
        // CONVEYOR LENGTH
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: true,
        ),

        // ---------------------------------------------------
        // CONVEYOR LENGTH UNIT
        // ---------------------------------------------------

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

        // ---------------------------------------------------
        // CONVEYOR SPEED
        //
        // This field was missing from old Flutter.
        // Latest website clearly contains:
        // Conveyor Speed (Min/Max)
        // ---------------------------------------------------

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
          required: true,
        ),

        // ---------------------------------------------------
        // CONVEYOR SPEED UNIT
        // ---------------------------------------------------

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

        // ---------------------------------------------------
        // APPLICATION ENVIRONMENT
        //
        // Latest website marks this field with *.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Ambient',
            'Caustic',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),

        // ---------------------------------------------------
        // OTHER APPLICATION ENVIRONMENT
        //
        // Latest website shows an additional textbox when
        // Other is selected.
        // ---------------------------------------------------

        ProductFieldData(
          key: 'otherAppEnviroment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Describe application environment',
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Other',
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Not shown on current website recording.
    // Kept as optional because this application currently
    // supports technician notes across configurations.
    // =======================================================

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