import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData etipo8074Data = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================
  id: 'ETI_807',
  title: 'Overhead Non-Powered Mighty Lube Chain Cleaners 8074-B, 8075-B',
  imagePath: AppAssets.etipoChainCleaners8074,
  description: 'Overhead non-powered Mighty Lube chain cleaner configuration for 8074-B and 8075-B systems.',
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
        // Latest website field.
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
        // OTHER CHAIN MANUFACTURER
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
            'mm Millimeters',
          ],
        ),

        // ---------------------------------------------------
        // CONVEYOR SPEED
        // Latest website field.
        // Old Flutter did not contain the actual speed value.
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
            'Feet/Minute',
            'Meters/Minute',
          ],
        ),

        // ---------------------------------------------------
        // APPLICATION ENVIRONMENT
        // Latest website field.
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
    // Existing app-specific field.
    // Kept optional.
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