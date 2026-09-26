import '../../../core/constants/app_assets.dart';
import '../models/product_item.dart';
import 'product_details/Technician/technician_notes_data.dart';

// ============================================================
// TECHNICIAN CATALOG
// ============================================================
//
// Technician application contains 1 direct product:
//
// Technician (1)
//   └── Technician Notes
//
// There is no intermediate category or sub-category.
// ============================================================

final List<ProductItem> technicianCatalog = [
  // ==========================================================
  // TECHNICIAN NOTES
  // ==========================================================

  ProductItem(
    title: 'Technician Notes',
    imagePath: AppAssets.applicationTechnician,
    detail: technicianNotesData,
  ),
];