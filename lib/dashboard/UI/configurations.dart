import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:mighty_lube/helper_widgets.dart';

class ConfigurationsPage extends StatefulWidget {
  dynamic configurationItems = [];
  ConfigurationsPage({super.key});

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  int totalQuantities = 0;

  void getOrders() async {
    dynamic cartItems = await FormAPI().getOrders();
    for (var order in cartItems) {
      totalQuantities += order["quantity"] as int;
    }
    setState(() {});
  }

  void getConfigurations() async {
    widget.configurationItems = await FormAPI().getConfigurations() as List;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // fetch orders
    getOrders();
    getConfigurations();
  }

  void _showConfigInfo(int index) {
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
                      "Configuration Information",
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
                      "Date Saved: \n${DateFormat.yMMMMd().format(DateTime.parse(widget.configurationItems[index]["dateOrdered"]).toLocal())}",
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
                      "Number of items in configuration: \n${widget.configurationItems[index]["cart"].length}",
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
      body: Column(
        children: [
          Expanded(
            child: widget.configurationItems!.isEmpty
                ? buildDefaultView(context)
                : ListView.builder(
                    itemCount: widget.configurationItems!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {},
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
                                    widget.configurationItems[index]["configurationName"] ??
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
                                      icon: const Icon(Icons.remove_red_eye_rounded,
                                          color: Colors.lightBlueAccent),
                                      onPressed: () {
                                        // display small modal from bottom with all small info
                                        _showConfigInfo(index);
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
        ],
      ),
    );
  }
}

Widget buildDefaultView(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.1, 0, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'No configurations have been made yet.',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ApplicationPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF579AF6),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Browse Products',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
