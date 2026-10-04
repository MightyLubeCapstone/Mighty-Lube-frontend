import '../data/application_catalog.dart';
import '../models/product_detail_data.dart';
import '../models/product_item.dart';

class ProductCatalogResolver {
  ProductCatalogResolver._();

  // =========================================================
  // FIND PRODUCT DETAIL BY PRODUCT ID
  // =========================================================
  //
  // Backend cart stores:
  //
  // productType: "CC5_CL"
  //
  // Product definitions store:
  //
  // ProductDetailData(
  //   id: "CC5_CL",
  //   ...
  // )
  //
  // Therefore:
  //
  // cart.productType
  //        ↓
  // ProductDetailData.id
  //
  // =========================================================

  static ProductDetailData? findById(
      String productId,
      ) {
    final normalizedProductId = productId.trim();

    if (normalizedProductId.isEmpty) {
      return null;
    }

    return _findInItems(
      applicationCatalog,
      normalizedProductId,
    );
  }

  // =========================================================
  // RECURSIVE SEARCH
  // =========================================================
  //
  // applicationCatalog
  //
  // ├── Industrial
  // │    └── categories
  // │         └── subcategories
  // │              └── final product
  //
  // ├── Protein
  // │    └── final products
  //
  // └── Technician
  //      └── final product
  //
  // Search continues recursively until a ProductItem with
  // matching ProductDetailData.id is found.
  // =========================================================

  static ProductDetailData? _findInItems(
      List<ProductItem> items,
      String productId,
      ) {
    for (final item in items) {
      // -------------------------------------------------------
      // FINAL PRODUCT
      // -------------------------------------------------------

      final detail = item.detail;

      if (detail != null &&
          detail.id.trim() == productId) {
        return detail;
      }

      // -------------------------------------------------------
      // CATEGORY / SUBCATEGORY
      // -------------------------------------------------------

      final children = item.children;

      if (children == null || children.isEmpty) {
        continue;
      }

      final result = _findInItems(
        children,
        productId,
      );

      if (result != null) {
        return result;
      }
    }

    // ---------------------------------------------------------
    // PRODUCT NOT FOUND
    // ---------------------------------------------------------

    return null;
  }
}