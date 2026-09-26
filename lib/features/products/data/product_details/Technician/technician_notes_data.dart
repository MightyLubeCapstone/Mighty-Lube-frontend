import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData technicianNotesData = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'TECHNICIAN_NOTES',

  title: 'Technician Notes',

  imagePath: AppAssets.applicationTechnician,

  description:
  'Please enter any relevant technical notes into the configurator '
      'to ensure the accuracy and specificity of your configuration. '
      'This information is crucial for tailoring the system to meet '
      'your exact needs and requirement.',

  configurationSections: [
    // =========================================================
    // TECHNICIAN NOTES
    // =========================================================

    ProductConfigurationSection(
      id: 'technicianNotes',
      title: 'Technician Notes',
      fields: [
        // -----------------------------------------------------
        // Notes
        //
        // Free-form multiline field where the technician can
        // enter any additional technical information required
        // for the configuration.
        // -----------------------------------------------------

        ProductFieldData(
          key: 'notes',
          label: 'Notes',
          type: ProductFieldType.text,
          multiline: true,
          required: true,
        ),
      ],
    ),
  ],
);