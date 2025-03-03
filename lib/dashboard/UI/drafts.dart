import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/application_home.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/helper_widgets.dart';

class DraftsPage extends StatefulWidget {
  DraftsPage({super.key});
  dynamic draftItems = [];

  @override
  State<DraftsPage> createState() => _DraftsPageState();
}

class _DraftsPageState extends State<DraftsPage> {
  int totalQuantities = 0;
  bool draftsLoading = false;

  void getOrders() async {
    dynamic cartItems = await CartAPI().getOrders();
    for (var order in cartItems) {
      totalQuantities += order["quantity"] as int;
    }
    setState(() {});
  }

  void getDrafts() async {
    setState(() {
      draftsLoading = true;
    });
    widget.draftItems = await DraftAPI().getDrafts() as List;
    setState(() {
      draftsLoading = false;
    });
  }

  Future<bool> removeDraft(dynamic cartID) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to delete this draft? This action cannot be undone."),
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

    bool status = await DraftAPI().deleteDraft(cartID);

    if (!mounted) return false;
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted draft!')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when deleting draft!')),
      );
      return false;
    }
  }

  Future<bool> restoreDraft(dynamic cartID) async {
    bool? confirmRestore = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Restore"),
          content: const Text("Are you sure you want to use this draft? This action will"
              "overwrite your current cart contents and cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel deletion
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm deletion
              child: const Text("Use draft", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );

    if (confirmRestore != true) return false; // Exit if user cancels

    bool status = await CartAPI().restoreDraft(cartID);

    if (!mounted) return false;
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully restored draft!')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when restoring draft!')),
      );
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // fetch orders
    getOrders();
    getDrafts();
  }

  void _showDraftInfo(int index) {
    dynamic cart = widget.draftItems[index]["cart"];
    int totalNumRequested = 0;
    for (var order in cart) {
      totalNumRequested += order["numRequested"] as int;
    }
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
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0.0),
                    child: Text(
                      "Draft Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  CommonWidgets.buildSectionDivider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
                    child: Text(
                      "Date Saved: \n${DateFormat.yMMMMd().format(DateTime.parse(widget.draftItems[index]["dateSaved"]).toLocal())}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
                    child: Text(
                      "Number of items in saved draft: \n$totalNumRequested",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
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
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: (draftsLoading == true)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: widget.draftItems!.isEmpty
                        ? _buildEmptyDraftView()
                        : ListView.builder(
                            itemCount: widget.draftItems!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => {
                                  // display small modal from bottom with all small info
                                  _showDraftInfo(index)
                                },
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
                                        Expanded(
                                          child: Text(
                                            widget.draftItems[index]["draftTitle"] ??
                                                "Unknown draft",
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
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () async {
                                                // delete from drafts
                                                // needs to pull up a confirmation window and then remove it
                                                // from both cartItems AND the database
                                                bool status = await removeDraft(
                                                    widget.draftItems[index]["cartID"]);
                                                if (status) {
                                                  setState(() {
                                                    widget.draftItems.removeAt(index);
                                                  });
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.shopping_cart_checkout,
                                                  color: Colors.green),
                                              onPressed: () async {
                                                // send to cart (replaces what is in there)
                                                bool status = await restoreDraft(
                                                  widget.draftItems[index]["cartID"],
                                                );
                                                if (status) {
                                                  setState(() {
                                                    dynamic cart = widget.draftItems[index]["cart"];
                                                    totalQuantities = 0;
                                                    for (var order in cart) {
                                                      totalQuantities +=
                                                          order["numRequested"] as int;
                                                    }
                                                  });
                                                }
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
                  )
                ],
              ),
      ),
    );
  }
}

Widget _buildEmptyDraftView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Add an Icon for better visual context
      Icon(
        Icons.shopping_cart_outlined,
        size: 80,
        color: Colors.grey.shade400,
      ),
      const SizedBox(height: 16),
      // Main Heading
      const Text(
        'Saved Carts',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      // Subheading
      Text(
        'No cart found',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
      ),
      const SizedBox(height: 240),
    ],
  );
}
