import 'package:flutter/material.dart';
import '../../features/products/models/product_item.dart';
import '../../features/products/screens/product_list_page.dart';
import '../../features/products/screens/product_detail_page.dart';
import 'product_card.dart';

class SearchableProductList extends StatelessWidget {
  final List<ProductItem> items;

  final String searchQuery;

  final List<String> breadcrumbs;

  final Widget appBarLink;
  final IconData customIcon;

  const SearchableProductList({
    super.key,
    required this.items,
    required this.searchQuery,
    required this.breadcrumbs,
    required this.appBarLink,
    required this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    final query = searchQuery.trim().toLowerCase();

    final filteredItems = items.where((item) {
      if (query.isEmpty) {
        return true;
      }
      return item.title.toLowerCase().contains(query);}).toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No product found',
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredItems.length,

      itemBuilder: (context, index,) {
        final item = filteredItems[index];

        return ProductCard(
          title: item.title,
          imagePath: item.imagePath,
          onTap: () {
            _openItem(
              context,
              item,
            );
          },
        );
      },
    );
  }

  void _openItem(
      BuildContext context,
      ProductItem item,
      ) {
    // ========================================================
    // CHILD CATEGORY
    // ========================================================

    if (item.hasChildren) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ProductListPage(
                title: item.title,
                items: item.children!,
                breadcrumbs: [
                  ...breadcrumbs,
                  item.title,
                ],
                appBarLink: appBarLink,
                customIcon: customIcon,
              ),
        ),
      );

      return;
    }

    // ========================================================
    // NEW REUSABLE PRODUCT
    // ========================================================

    if (item.hasDetail) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ProductDetailPage(
                product:
                item.detail!,

                breadcrumbs: [
                  ...breadcrumbs,
                  item.title,
                ],

                appBarLink:
                appBarLink,

                customIcon:
                customIcon,
              ),
        ),
      );

      return;
    }
  }
}