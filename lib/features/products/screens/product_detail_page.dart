import 'package:flutter/material.dart';

import 'package:mighty_lube/core/widget/custom_app_bar.dart';
import 'package:mighty_lube/core/widget/breadcrumb_bar.dart';
import 'package:mighty_lube/core/widget/product_details_section.dart';
import 'package:mighty_lube/core/widget/product_configuration_form.dart';
import 'package:mighty_lube/features/dashboard/screens/dashboard.dart';
import '../../../core/widget/custom_drawer.dart';
import '../models/product_detail_data.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailData product;

  final List<String> breadcrumbs;

  final Widget appBarLink;
  final IconData customIcon;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.breadcrumbs,
    required this.appBarLink,
    required this.customIcon,
  });

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState
    extends State<ProductDetailPage> {
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
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
    final currentIndex =
        widget.breadcrumbs.length - 1;

    final popCount =
        currentIndex - index;

    if (popCount <= 0) {
      return;
    }

    final navigator =
    Navigator.of(context);

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
        showSearch: false,
      ),

      drawer: const CustomDrawer(),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: BreadcrumbBar(
              items: widget.breadcrumbs,
              onHomeTap: _goHome,
              onItemTap: _openBreadcrumb,
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                // DETAILS
                ProductDetailsSection(
                  title: widget.product.title,
                  imagePath: widget.product.imagePath,
                  description: widget.product.description,
                ),

                // CONFIGURATION
                ProductConfigurationForm(
                  product: widget.product,
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: _onTabChanged,

        type: BottomNavigationBarType.fixed,

        backgroundColor:
        const Color.fromARGB(
          202,
          215,
          217,
          223,
        ),

        selectedItemColor:
        Colors.blueAccent,

        unselectedItemColor:
        const Color.fromARGB(
          255,
          68,
          66,
          66,
        ),

        items: const [
          BottomNavigationBarItem(
            icon:
            Icon(Icons.info_outline),
            label: 'Details',
          ),

          BottomNavigationBarItem(
            icon:
            Icon(Icons.tune),
            label: 'Configuration',
          ),
        ],
      ),
    );
  }
}