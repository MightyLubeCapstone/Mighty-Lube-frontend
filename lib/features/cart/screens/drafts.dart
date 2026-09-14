import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mighty_lube/core/widget/helper_widgets.dart';
import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';

import '../../../core/network/services/draft_api_service.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';
import '../repositories/cart_repositories.dart';

class DraftsPage extends StatefulWidget {
  DraftsPage({
    super.key,
  });

  dynamic draftItems = [];

  @override
  State<DraftsPage> createState() => _DraftsPageState();
}

class _DraftsPageState extends State<DraftsPage> {
  int totalQuantities = 0;

  bool draftsLoading = false;

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
      // Drafts page should continue working
      // even if cart count API fails.
    }
  }

  Future<void> getDrafts() async {
    setState(() {
      draftsLoading = true;
    });

    widget.draftItems = await DraftApiService.getDrafts() as List;

    if (!mounted) {
      return;
    }

    setState(() {
      draftsLoading = false;
    });
  }

  Future<bool> removeDraft(
      dynamic cartID,
      ) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
          ),
          content: const Text(
            'Are you sure you want to delete this draft? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                false,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                true,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete != true) {
      return false;
    }

    final response = await DraftApiService.deleteDraft(
      draftID: cartID.toString(),
    );
    final status = response.success && response.data == true;


    if (!mounted) {
      return false;
    }

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully deleted draft!',
          ),
        ),
      );

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error when deleting draft!',
          ),
        ),
      );

      return false;
    }
  }

  Future<bool> restoreDraft(
      dynamic cartID,
      ) async {
    bool? confirmRestore = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Restore',
          ),
          content: const Text(
            "Are you sure you want to use this draft? This action will append this draft's contents to your current cart.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                false,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                true,
              ),
              child: const Text(
                'Use draft',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmRestore != true) {
      return false;
    }

    final response = await DraftApiService.restoreDraft(
      draftID: cartID.toString(),
    );
    final status = response.success && response.data == true;

    if (!mounted) {
      return false;
    }

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully restored draft!',
          ),
        ),
      );

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error when restoring draft!',
          ),
        ),
      );

      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    getOrders();

    getDrafts();
  }

  void _showDraftInfo(
      int index,
      ) {
    dynamic cart = widget.draftItems[index]['cart'];

    int totalNumRequested = 0;

    for (var order in cart) {
      totalNumRequested += order['numRequested'] as int;
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
                      'Draft Information',
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
                      'Date Saved: \n${DateFormat.yMMMMd().format(DateTime.parse(widget.draftItems[index]['dateSaved']).toLocal())}',
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
                      'Number of items in saved draft: \n$totalNumRequested',
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
      body: Center(
        child: draftsLoading == true
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: widget.draftItems!.isEmpty
                  ? _buildEmptyDraftView()
                  : ListView.builder(
                itemCount: widget.draftItems!.length,
                itemBuilder: (
                    context,
                    index,
                    ) {
                  return GestureDetector(
                    onTap: () => {
                      _showDraftInfo(
                        index,
                      ),
                    },
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
                                widget.draftItems[index]
                                ['draftTitle'] ??
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
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    bool status =
                                    await removeDraft(
                                      widget.draftItems[index]
                                      ['cartID'],
                                    );

                                    if (status) {
                                      setState(() {
                                        widget.draftItems.removeAt(
                                          index,
                                        );
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart_checkout,
                                    color: Colors.green,
                                  ),
                                  onPressed: () async {
                                    bool status =
                                    await restoreDraft(
                                      widget.draftItems[index]
                                      ['cartID'],
                                    );

                                    if (status) {
                                      setState(() {
                                        dynamic cart =
                                        widget.draftItems[index]
                                        ['cart'];

                                        for (var order in cart) {
                                          totalQuantities +=
                                          order['numRequested']
                                          as int;
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
            ),
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
      Icon(
        Icons.all_inbox_sharp,
        size: 80,
        color: Colors.grey.shade400,
      ),
      const SizedBox(
        height: 16,
      ),
      const Text(
        'Saved Carts',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        'No carts found',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
      ),
      const SizedBox(
        height: 240,
      ),
    ],
  );
}