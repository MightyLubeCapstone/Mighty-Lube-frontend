import 'package:flutter/material.dart';

import 'product_detail_data.dart';

class ProductItem {
  final String title;
  final String imagePath;

  /// Category/subcategory
  final List<ProductItem>? children;

  /// New reusable final product.
  final ProductDetailData? detail;

  const ProductItem({
    required this.title,
    required this.imagePath,
    this.children,
    this.detail,
  });

  bool get hasChildren => children != null &&
          children!.isNotEmpty;

  bool get hasDetail =>
      detail != null;
}