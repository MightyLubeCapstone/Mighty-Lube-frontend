import 'package:mighty_lube/features/products/data/product_details/Protein/food_grade_cleaner_op8ss_data.dart';
import 'package:mighty_lube/features/products/data/product_details/Protein/food_grade_lubrication_monitor_data.dart';

import '../../../core/constants/app_assets.dart';
import '../models/product_item.dart';


// ============================================================
// PROTEIN CATALOG
// ============================================================
//
// Protein application currently contains 2 direct products.
//
// Unlike the Industrial catalog, there is no intermediate
// category/sub-category level.
//
// Structure:
//
// Protein (2)
//   ├── Food Grade Cleaner OP-8SS
//   └── Food Grade Lubrication and Monitor
//
// Product detail files will be connected through the `detail`
// property once their configurations are created.
// ============================================================

final List<ProductItem> proteinCatalog = [

  // ==========================================================
  // 1. FOOD GRADE CLEANER OP-8SS
  // ==========================================================

  const ProductItem(
    title: 'Food Grade Cleaner OP-8SS',

    // Image asset will be connected after confirming
    // the Protein asset constant.
    imagePath: AppAssets.PROTEIN_FGCO,
    detail: proteinFoodGradeCleanerOp8ssData
  ),


  // ==========================================================
  // 2. FOOD GRADE LUBRICATION AND MONITOR
  // ==========================================================

  const ProductItem(
    title: 'Food Grade Lubrication and Monitor',

    // Image asset will be connected after confirming
    // the Protein asset constant.
    imagePath: AppAssets.PROTEIN_FGLAM,
    detail: proteinFoodGradeLubricationMonitorData
  ),
];