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
  bool deleteLoading = false;

  void getOrders() async {
    widget.cartItems = await FormAPI().getOrders();
    for (var order in widget.cartItems) {
      totalQuantities += order["quantity"] as int;
    }
    setState(() {});
  }

  Future<bool> saveDraft(String draftTitle) async {
    bool status = await FormAPI().saveDraft(draftTitle);
    if (status == true) {
      // good snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully moved form!')),
      );
      return true;
    } else {
      // other snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when moving form!')),
      );
      return false;
    }
  }

  Future<bool> finalize(String configurationName) async {
    bool status = await FormAPI().finalize(configurationName);
    if (status == true) {
      // good snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully moved form!')),
      );
      return true;
    } else {
      // other snackbar thingy
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when moving form!')),
      );
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch orders
    getOrders();
  }

  // X button in EditModal
  void _resetStates(List<dynamic> stateHolders) {
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
  void _submitNewData(
      dynamic orderID, Map<String, dynamic> newData, List<dynamic> stateHolders) async {
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
    List<dynamic> stateHolders = []; // either an int or a TextEdControl
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
      backgroundColor: const Color(0xFF579AF6),
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
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0),
              child: Column(
                children: [
                  if (!isEditable)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
                      child: Text(
                        "Current configuration",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  if (isEditable)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
                      child: Center(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => {
                                _resetStates(stateHolders),
                                Navigator.of(context).pop(),
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                            const Text(
                              "    Edit configuration    ",
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
                                      _submitNewData(orderID, newData, stateHolders),
                                      Navigator.of(context).pop()
                                    },
                                    icon: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 40.0,
                                    ),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  CommonWidgets.buildSectionDivider(),
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

  Future<bool> removeOrder(dynamic orderID) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to delete this order? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel deletion
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm deletion
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmDelete != true) return false; // Exit if user cancels

    setState(() {
      deleteLoading = true;
    });

    bool status = await FormAPI().deleteOrder(orderID);

    setState(() {
      deleteLoading = false;
    });

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted order!')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when deleting order!')),
      );
      return false;
    }
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
                                            onPressed: () => {
                                              setState(() {
                                                loading = true;
                                              }),
                                              // show modal with all possible choices, just like original page
                                              _showCurrentConfiguration(product["orderID"], true)
                                            },
                                          ),
                                          if (deleteLoading == true)
                                            const CircularProgressIndicator(),
                                          if (deleteLoading == false)
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                setState(() {
                                                  // needs to pull up a confirmation window and then remove it
                                                  // from both cartItems AND the database
                                                  Future<bool> status =
                                                      removeOrder(product["orderID"]);
                                                  status.then((success) {
                                                    if (success) {
                                                      widget.cartItems!.removeAt(index);
                                                      totalQuantities--;
                                                    }
                                                  });
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
                      List<dynamic> orders = [];
                      for (var order in widget.cartItems!) {
                        orders.add(order["orderID"]);
                      }
                      saveDraft("Saved draft #1").then((success) => {
                            setState(() {
                              widget.cartItems = [];
                            })
                          });
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Finalize Configuration logic
                      List<dynamic> orders = [];
                      for (var order in widget.cartItems!) {
                        orders.add(order["orderID"]);
                      }
                      finalize("Config #1").then((success) => {
                            setState(() {
                              widget.cartItems = [];
                            })
                          });
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
