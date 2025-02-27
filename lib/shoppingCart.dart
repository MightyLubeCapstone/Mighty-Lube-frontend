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
  bool loading = false;
  bool editLoading = false;

  List<dynamic> stateHolders = []; // either an int or a TextEdControl

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

  // X button in EditModal
  void _resetStates() {
    for (var state in stateHolders) {
      if (state["controller"] is int) {
        setState(() {
          state["controller"] = state["initial"];
        });
      } else {
        var controller = state["controller"] as TextEditingController;
        setState(() {
          controller.text = state["initial"];
        });
      }
    }
  }

  // Checkmark in EditModal
  void _submitNewData(dynamic orderID, Map<String, dynamic> newData) async {
    setState(() {
      editLoading = true;
    });
    for (var formField in stateHolders) {
      if (formField is! Map<String, dynamic>) {
        continue; // Skip if formField is not a Map (prevent crashes)
      }

      var controller = formField["controller"];
      var initial = formField["initial"];

      if (controller is int) {
        if (controller != (initial as int)) {
          newData[formField["field"]] = controller;
        }
      } else if (controller is TextEditingController) {
        if (controller.text != (initial as String)) {
          newData[formField["field"]] = controller.text;
        }
      }
    }
    bool status = await FormAPI().updateOrder(orderID, newData);
    setState(() {
      editLoading = false;
    });
    if (status == true) {
      // good snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully updated form!')),
      );
    } else {
      // other snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when updating form!')),
      );
    }
  }

  // pressing the modal, regardless of the pencil or card itself
  void _showCurrentConfiguration(dynamic orderID, bool isEditable) async {
    // ### IMPORTANT AS FUCK ### //
    List<List<String>> options = [];
    List<String> labels = [];
    Map<String, dynamic> newData = {};

    // first, grab the order info by calling GET orders/order
    Map orderInfo = await FormAPI().getOrder(orderID) as Map<String, dynamic>;
    orderInfo.remove("_id");
    setState(() {
      loading = false;
    });
    int numberOfFields = orderInfo.length; // bye bye _id :)
    for (var entry in orderInfo.entries) {
      // map iteration
      labels.add(entry.key);
      if (entry.value.runtimeType == List) {
        // dropdown addition
        List mappedOptions = entry.value as List;
        List<String> newList = []; // Create a new list
        options.add(newList); // Add it to options
        for (var option in mappedOptions) {
          // array iteration
          newList.add(option["value"]);
          if (option["isSelected"] as bool == true) {
            int optionKey = option["key"];
            stateHolders.add(
              {
                "controller": optionKey,
                "initial": optionKey,
                "field": entry.key,
              },
            );
          }
        }
      } else {
        // TextEdControl addition
        stateHolders.add(
          {
            "controller": TextEditingController(
              text: entry.value.toString(),
            ),
            "initial": entry.value.toString(),
            "field": entry.key,
          },
        ); // mind-fuck of code right here
        options.add([]); // jank-ass code to get me through the night
      }
    }

    // THEN, build the modal
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 167, 195, 234),
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Column(
                children: [
                  if (!isEditable)
                    const Text(
                      "Current configuration",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  if (isEditable)
                    Center(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => {
                              _resetStates(),
                              Navigator.of(context).pop(),
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            "      Edit configuration     ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          (editLoading == true
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  onPressed: () => {
                                    _submitNewData(orderID, newData),
                                    Navigator.of(context).pop()
                                  },
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                )),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: numberOfFields,
                      itemBuilder: (context, index) {
                        // placeholder logic...
                        if (stateHolders[index]["controller"] is int) {
                          return CommonWidgets.buildDropdownFieldProtein(
                            isEditable: isEditable,
                            labels[index],
                            options[index],
                            stateHolders[index]["controller"],
                            (value) {
                              setState(() {
                                stateHolders[index]["controller"] = value;
                              });
                            },
                          );
                        } else {
                          return CommonWidgets.buildTextField(
                            labels[index],
                            stateHolders[index]["controller"],
                            isEditable: isEditable,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
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
                          setState(() {
                            loading = true;
                          });
                          // this is the one that needs to show all their CURRENT choices...
                          _showCurrentConfiguration(product["orderID"], false);
                        },
                        child: loading == false
                            ? Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              setState(() {
                                                loading = true;
                                              }),
                                              // show modal with all possible choices, just like original page
                                              _showCurrentConfiguration(
                                                  product["orderID"], true)
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                // needs to pull up a confirmation window and then remove it
                                                // from both cartItems AND the database
                                                widget.cartItems!
                                                    .removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(), // in case internet sucko
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
