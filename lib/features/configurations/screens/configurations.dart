import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mighty_lube/core/widget/helper_widgets.dart';
import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/configurations/repositories/configuration_repository.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';
import '../../cart/repositories/cart_repositories.dart';

class ConfigurationsPage extends StatefulWidget {
  dynamic configurationItems = [];

  ConfigurationsPage({
    super.key,
  });

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  int totalQuantities = 0;

  bool configLoading = false;

  Future<void> getOrders() async {
    try {
      final response = await CartRepository.getOrders();

      if (!response.success || response.data == null) {
        return;
      }

      int total = 0;

      for (final order in response.data!) {
        if (order is Map) {
          total += int.tryParse(
            order['quantity']?.toString() ?? '0',
          ) ??
              0;
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        totalQuantities = total;
      });
    } catch (_) {
      // Configurations page should continue working
      // even if cart count API fails.
    }
  }

  void getConfigurations() async {
    setState(() {
      configLoading = true;
    });

    widget.configurationItems =
    await ConfigurationRepository.getConfigurations() as List;

    setState(() {
      configLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getOrders();

    getConfigurations();
  }

  void _showConfigInfo(
      int index,
      ) {
    dynamic cart = widget.configurationItems[index]['cart'];

    int numOrders = 0;

    for (var order in cart) {
      numOrders += order['numRequested'] as int;
    }

    showModalBottomSheet(
      backgroundColor: const Color(0xFF579AF6),
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            15,
          ),
        ),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10.0,
                5.0,
                10.0,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      20.0,
                      20.0,
                      0,
                      0.0,
                    ),
                    child: Text(
                      'Configuration Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  CommonWidgets.buildSectionDivider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      0.0,
                      0,
                      0.0,
                    ),
                    child: Text(
                      'Date Saved: \n${DateFormat.yMMMMd().format(DateTime.parse(widget.configurationItems[index]['dateOrdered']).toLocal())}',
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
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      0.0,
                      0,
                      0.0,
                    ),
                    child: Text(
                      'Number of items in configuration: \n$numOrders',
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
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationCatalogPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: configLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child: widget.configurationItems!.isEmpty
                ? buildDefaultView(
              context,
            )
                : ListView.builder(
              itemCount: widget.configurationItems!.length,
              itemBuilder: (
                  context,
                  index,
                  ) {
                return GestureDetector(
                  onTap: () => {},
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        12,
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.configurationItems[index]
                              ['configurationName'] ??
                                  'Unknown draft',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: Colors.lightBlueAccent,
                                ),
                                onPressed: () {
                                  _showConfigInfo(
                                    index,
                                  );
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

Widget buildDefaultView(
    BuildContext context,
    ) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.fromLTRB(
      screenWidth * 0.1,
      0,
      0,
      0,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'No configurations have been made yet.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ApplicationCatalogPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF579AF6),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          child: const Text(
            'Browse Products',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}