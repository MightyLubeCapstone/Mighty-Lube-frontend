import 'package:flutter/material.dart';

import 'package:mighty_lube/features/products/data/application_catalog.dart';
import 'package:mighty_lube/features/products/screens/product_list_page.dart';

class ApplicationCatalogPage extends StatelessWidget {
  const ApplicationCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductListPage(
      title: 'Application',
      items: applicationCatalog,
      breadcrumbs: const [
        'Application',
      ],
      appBarLink: const ApplicationCatalogPage(),
      customIcon: Icons.description,
    );
  }
}