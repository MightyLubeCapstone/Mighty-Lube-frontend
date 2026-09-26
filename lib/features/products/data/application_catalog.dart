import 'package:mighty_lube/features/products/data/protein_catalog.dart';
import 'package:mighty_lube/features/products/data/technician_catalog.dart';

import '../../../core/constants/app_assets.dart';
import '../models/product_item.dart';
import 'industrial_catalog.dart';

final List<ProductItem> applicationCatalog = [
  // ----------------------------------------------------------
  // INDUSTRIAL
  // ----------------------------------------------------------

  ProductItem(
    title: 'Industrial (76)',
    imagePath: AppAssets.applicationIndustrial,
    // Important:
    // destination nahi.
    // Generic children navigation use hogi.
    children: industrialCatalog,
  ),

  // ----------------------------------------------------------
  // PROTEIN
  // ----------------------------------------------------------

  ProductItem(
    title: 'Protein (2)',
    imagePath: AppAssets.applicationProtein,
    children: proteinCatalog
  ),

  // ----------------------------------------------------------
  // TECHNICIAN
  // ----------------------------------------------------------

  ProductItem(
    title: 'Technician (1)',
    imagePath: AppAssets.applicationTechnician,
    children: technicianCatalog
  ),
];