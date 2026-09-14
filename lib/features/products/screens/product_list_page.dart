import 'package:flutter/material.dart';

import '../../../core/widget/breadcrumb_bar.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/searchable_product_list.dart';

import '../../dashboard/screens/dashboard.dart';

import '../models/product_item.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final List<ProductItem> items;

  /// Full current path.
  ///
  /// Example:
  /// [
  ///   'Application',
  ///   'Industrial',
  ///   'CC5 Chain',
  /// ]
  final List<String> breadcrumbs;

  /// CustomAppBar settings
  final Widget appBarLink;
  final IconData customIcon;

  const ProductListPage({
    super.key,
    required this.title,
    required this.items,
    required this.breadcrumbs,
    required this.appBarLink,
    required this.customIcon,
  });

  @override
  State<ProductListPage> createState() =>
      _ProductListPageState();
}

class _ProductListPageState
    extends State<ProductListPage> {
  String _searchQuery = '';

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardPage(),
      ),
          (route) => false,
    );
  }

  void _openBreadcrumb(int index) {
    /*
     * Example:
     *
     * Current:
     * Application > Industrial > CC5 > Conveyor
     *
     * Current index = 3
     *
     * Industrial click index = 1
     *
     * Pop:
     * 3 - 1 = 2 pages
     */

    final int currentIndex = widget.breadcrumbs.length - 1;
    final int popCount = currentIndex - index;
    if (popCount <= 0) {
      return;
    }

    final navigator = Navigator.of(context);
    for (int i = 0; i < popCount; i++) {
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: widget.appBarLink,
        customIcon: widget.customIcon,
        // Search icon visible
        showSearch: true,
        // Search query comes here
        onSearchChanged: _onSearchChanged,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // ----------------------------------------------
              // BREADCRUMB
              // ----------------------------------------------

              BreadcrumbBar(
                items: widget.breadcrumbs,
                onHomeTap: _goHome,
                onItemTap: _openBreadcrumb,
              ),

              const SizedBox(height: 8),

              // ----------------------------------------------
              // PRODUCTS
              // ----------------------------------------------

              Expanded(
                child: SearchableProductList(
                  items: widget.items,
                  searchQuery: _searchQuery,
                  breadcrumbs: widget.breadcrumbs,
                  appBarLink: widget.appBarLink,
                  customIcon: widget.customIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}