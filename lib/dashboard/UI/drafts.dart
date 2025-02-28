import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/helper_widgets.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Increased height for a larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 100, // Increased width for a larger logo
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
}

class DraftsPage extends StatefulWidget {
  DraftsPage({super.key});
  List<dynamic> draftItems = [];

  @override
  State<DraftsPage> createState() => _DraftsPageState();
}

class _DraftsPageState extends State<DraftsPage> {
  int totalQuantities = 0;
  int numDrafts = 0;

  void getOrders() async {
    dynamic cartItems = await FormAPI().getOrders();
    for (var order in cartItems) {
      totalQuantities += order["quantity"] as int;
    }
    setState(() {});
  }

  void getDrafts() async {
    widget.draftItems = await FormAPI().getDrafts() as List;
    numDrafts = widget.draftItems.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // fetch orders
    getOrders();
    getDrafts();
  }

  void _showDraftInfo(int index) {
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
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
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
                  Text(
                    "Date Saved: \n${widget.draftItems[index]["dateSaved"].toString()}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Number of items in saved draft: \n${widget.draftItems[index]["cart"].length}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: (numDrafts == 0)
                  ? _buildEmptyDraftView()
                  : ListView.builder(
                      itemCount: numDrafts,
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
                                      widget.draftItems[index]["draftTitle"] ?? "Unknown draft",
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
                                        onPressed: () => {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.shopping_cart_checkout,
                                            color: Colors.green),
                                        onPressed: () {},
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
      const SizedBox(height: 24),
    ],
  );
}
