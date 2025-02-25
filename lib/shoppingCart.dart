import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/helper_widgets.dart';

class ShoppingPage extends StatefulWidget {
  dynamic cartItems = [];
  final bool showAlternativeUI;
  final String emptyCartMessage;

  ShoppingPage({
    super.key,
    this.showAlternativeUI = false,
    this.emptyCartMessage = "Your cart is currently empty.",
  });

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int totalQuantities = 0;
  void getOrders() async {
    widget.cartItems = await FormAPI().getOrders();
    for (var order in widget.cartItems) {
      totalQuantities += order["quantity"] as int;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // fetch orders
    getOrders();
  }

  void _showCurrentConfiguration(bool isEditable) {
    // ### IMPORTANT AS FUCK ### //
    List<int?> dropdownStateHolders = List.filled(20, 1);
    List<TextEditingController> textStateHolders = [
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder"),
      TextEditingController(text: "Placeholder")
    ];
    // first, grab the order info by calling GET orders/order (unimplemented atm :|)
    // dummy data :D
    int numberOfFields = 10;
    List<String> labels = [
      "label1",
      "label2",
      "label3",
      "label4",
      "label5",
      "label6",
      "label7",
      "label8",
      "label9",
      "label10"
    ];
    List<String> options = ["Option 1", "Option 2", "Option 3"];

    // THEN, build the modal
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Column(
              children: [
                const Text(
                  "Your current configuration",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: numberOfFields,
                    itemBuilder: (context, index) {
                      // placeholder logic...
                      if (index % 2 == 0) {
                        return CommonWidgets.buildDropdownFieldProtein(
                          isEditable: isEditable,
                          labels[index],
                          options,
                          dropdownStateHolders[index],
                          (value) {
                            setState(() {
                              dropdownStateHolders[index] = value;
                            });
                          },
                        );
                      } else {
                        return CommonWidgets.buildTextField(
                          labels[index],
                          textStateHolders[index],
                          isEditable: isEditable,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationPage(),
        customIcon: Icons.description,
        reload: false,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems!.isEmpty
                ? const Center(
                    child: Text(
                      "No products in the cart.",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems!.length,
                    itemBuilder: (context, index) {
                      final product = widget.cartItems![index];

                      return GestureDetector(
                        onTap: () {
                          // this is the one that needs to show all their CURRENT choices...
                          _showCurrentConfiguration(false);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
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
                                    product["image"] ??
                                        "assets/default_product.png",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                          Icons.image_not_supported,
                                          size: 30),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

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
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () => {
                                        // show modal with all possible choices, just like original page
                                        _showCurrentConfiguration(true)
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          // needs to pull up a confirmation window and then remove it
                                          // from both cartItems AND the database
                                          widget.cartItems!.removeAt(index);
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
          if (widget.cartItems!.isNotEmpty)
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
List<dynamic> myCartItems = [
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

// // Example Navigator Call
// void navigateToShoppingPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ShoppingPage(
//         cartItems: myCartItems, // Using fake data
//         showAlternativeUI: true, // Showing alternative view
//       ),
//     ),
//   );
// }
