import 'package:flutter/material.dart';

class RelatedProductsSection extends StatefulWidget {
  const RelatedProductsSection({super.key});

  @override
  State<RelatedProductsSection> createState() => _RelatedProductsSectionState();
}

class _RelatedProductsSectionState extends State<RelatedProductsSection> {
  // List of image URLs and their respective titles
  final List<Map<String, String>> products = [
    {
      'title': 'Greaser Power Chain',
      'image':
          'assets/greaser_power_chain.png', // Replace with your image paths
    },
    {
      'title': 'OP-52/OP-53',
      'image': 'assets/op52_op53.png',
    },
    {
      'title': 'Multi Line Monitoring + Lubrication',
      'image': 'assets/multi_line.png',
    },
    {
      'title': 'Power Brush Cleaning System',
      'image': 'assets/power_brush.png',
    },
  ];

  // Current selected product
  late Map<String, String> selectedProduct;

  @override
  void initState() {
    super.initState();
    selectedProduct = products[0]; // Default to the first product
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 360,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    'Explore Related Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Display selected image
                GestureDetector(
                  onTap: () {
                    // Navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: selectedProduct,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      selectedProduct['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdown menu
                DropdownButton<Map<String, String>>(
                  value: selectedProduct,
                  isExpanded: true,
                  items: products.map((product) {
                    return DropdownMenuItem(
                      value: product,
                      child: Text(product['title']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProduct = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Product detail page
class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              product['image']!,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
