import 'package:flutter/material.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/drawer.dart';

class ShoppingPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final bool showAlternativeUI;
  final String emptyCartMessage;

  const ShoppingPage({
    super.key,
    required this.cartItems,
    this.showAlternativeUI = false,
    this.emptyCartMessage = "Your cart is currently empty.",
  });

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {

  void _showProductDetails(Map<String, dynamic> product, {bool isEditing = false}) {
  TextEditingController nameController = TextEditingController(text: product["name"]);
  TextEditingController detailsController = TextEditingController(
      text: (product["details"] as List<dynamic>?)?.join(", ") ?? "");
  int quantity = product["quantity"] ?? 1; // Default quantity if not set

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centered Title
                Center(
                  child: Text(
                    isEditing ? "Edit Product" : product["name"] ?? "Unknown Product",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),

              // Image & Quantity Row
                Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product Image (Aligned Left)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      product["image"] ?? "assets/default_product.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                  ),
                  
                  // Add spacing
                  const SizedBox(width: 16),

                  // Vertical Divider
                  Container(
                    width: 1.5, // Adjust thickness
                    height: 60, // Adjust height
                    color: Colors.grey[400], // Divider color
                  ),

                  // Add spacing after divider
                  const SizedBox(width: 16),

                  // Quantity Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Quantity", style: TextStyle(fontSize: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (isEditing)
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setModalState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            if (isEditing)
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setModalState(() {
                                    quantity++;
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                
                const SizedBox(height: 10),

                // Edit Mode Fields
                if (isEditing) ...[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Product Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: detailsController,
                    decoration: const InputDecoration(labelText: "Details (comma-separated)"),
                  ),
                ] else ...[
                  const Divider(),
                  ...?product["details"]?.map(
                    (detail) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(detail, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],

                const SizedBox(height: 15),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isEditing)
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            isEditing = false;
                          });
                        },
                        child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          // Save Edited Data
                          setState(() {
                            product["name"] = nameController.text;
                            product["details"] =
                                detailsController.text.split(",").map((e) => e.trim()).toList();
                            product["quantity"] = quantity; // Save quantity
                          });
                          Navigator.pop(context); // Close modal
                        } else {
                          setModalState(() {
                            isEditing = true; // Switch to edit mode
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEditing ? Colors.green : Colors.blue,
                      ),
                      child: Text(isEditing ? "Save" : "Edit"),
                    ),
                    if (!isEditing)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.cartItems.remove(product);
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text("Delete"),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    },
  );
}

  
  void _editProduct(Map<String, dynamic> product) {
    final TextEditingController nameController = TextEditingController(text: product["name"]);
    final TextEditingController detailsController = TextEditingController(
        text: (product["details"] as List<dynamic>?)?.join(", ") ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: "Details (comma-separated)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                product["name"] = nameController.text;
                product["details"] = detailsController.text.split(",").map((e) => e.trim()).toList();
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(
      link: ApplicationPage(),
      customIcon: Icons.description,
    ),
    drawer: const CustomDrawer(),
    body: Column(
      children: [
        Expanded(
  child: widget.cartItems.isEmpty
      ? const Center(
          child: Text(
            "No products in the cart.",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        )
      : ListView.builder(
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final product = widget.cartItems[index];

            return GestureDetector(
              onTap: () => _showProductDetails(product), // Opens the bottom modal
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image (Aligned Left)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product["image"] ?? "assets/default_product.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Product Name Only
                      Expanded(
                        child: Text(
                          product["name"] ?? "Unknown Product",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Edit & Delete Icons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showProductDetails(product, isEditing: true),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                widget.cartItems.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
),

        // Bottom Buttons (Only Show if Cart is Not Empty)
if (widget.cartItems.isNotEmpty)
  Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Subtle shadow
          blurRadius: 5,
          spreadRadius: 2,
          offset: const Offset(0, -2), // Shadow at the top only
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement Save Configuration logic
            print("Save Configuration clicked");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF579AF6), // Blue button
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "SAVE CONFIGURATION",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement Finalize Configuration logic
            print("Finalize Configuration clicked");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF579AF6), // Blue button
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "FINALIZE CONFIGURATION",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  ),

      ],
    ),
  );
}


}

// Fake Data for Testing
List<Map<String, dynamic>> myCartItems = [
  {
    "name": "Industrial Lubricant",
    "image": "assets/lubricant.png",
    "details": ["High performance", "500ml", "Long-lasting"],
    "quantity": 2
  },
  {
    "name": "Hydraulic Fluid",
    "image": "assets/hydraulic.png",
    "details": ["Synthetic blend", "1L", "Anti-wear protection"],
    "quantity": 1
  },
  {
    "name": "Grease Cartridge",
    "image": "assets/grease.png",
    "details": ["Lithium-based", "500g", "Extreme pressure resistance"],
    "quantity": 3
  },
];

// Example Navigator Call
void navigateToShoppingPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ShoppingPage(
        cartItems: myCartItems,  // Using fake data
        showAlternativeUI: true, // Showing alternative view
      ),
    ),
  );
}
