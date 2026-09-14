import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mighty_lube/core/widget/custom_app_bar.dart';
import 'package:mighty_lube/core/widget/custom_drawer.dart';
import 'package:mighty_lube/core/widget/helper_widgets.dart';

import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/cart/repositories/draft_repository.dart';
import 'package:mighty_lube/features/configurations/repositories/configuration_repository.dart';

import '../repositories/cart_repositories.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  dynamic cartItems = [];

  int totalQuantities = 0;

  bool cartLoading = false;
  bool orderLoading = false;
  bool editLoading = false;
  bool deleteLoading = false;

  // =========================================================
  // VALIDATE TEXT FIELD
  // =========================================================

  void _validateTextField(
      String value,
      int index,
      dynamic stateHolders,
      ) {
    if (stateHolders[index]["required"] == false) {
      return;
    }

    setState(() {
      if (value.trim().isEmpty) {
        stateHolders[index]["error"] =
        'This field is required.';
      } else if (stateHolders[index]["isNum"] == true) {
        if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(value)) {
          stateHolders[index]["error"] =
          'Please enter a valid number.';
        } else {
          stateHolders[index]["error"] = null;
        }
      } else {
        stateHolders[index]["error"] = null;
      }
    });
  }

  // =========================================================
  // VALIDATE CONFIGURATION
  // =========================================================

  bool _validateNewInfo(
      List<dynamic> stateHolders,
      ) {
    for (var field in stateHolders) {
      if (field["error"] != null) {
        return false;
      }
    }

    return true;
  }

  // =========================================================
  // GET CART CONFIGURATIONS
  // =========================================================

  void getOrders() async {
    setState(() {
      cartLoading = true;
    });

    final response =
    await CartRepository.getOrders();

    if (!mounted) {
      return;
    }

    if (response.success) {
      cartItems =
          response.data ?? [];
    } else {
      cartItems = [];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message ??
                'Error when loading cart!',
          ),
        ),
      );
    }

    totalQuantities = 0;

    for (var configuration in cartItems) {
      final dynamic quantity =
      configuration["quantity"];

      if (quantity is int) {
        totalQuantities += quantity;
      } else {
        totalQuantities +=
            int.tryParse(
              quantity?.toString() ?? '0',
            ) ??
                0;
      }
    }

    setState(() {
      cartLoading = false;
    });
  }

  // =========================================================
  // SAVE CART AS DRAFT
  // =========================================================

  Future<bool> saveDraft() async {
    if (cartItems == null ||
        cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No configurations available to save as draft.',
          ),
        ),
      );

      return false;
    }

    // =========================================================
    // COLLECT CONFIGURATION IDS
    // =========================================================

    final List<String> configurationIDs = [];

    for (var item in cartItems) {
      if (item is! Map) {
        continue;
      }

      final dynamic configurationID =
      item["configurationID"];

      if (configurationID == null) {
        continue;
      }

      final String normalizedID =
      configurationID
          .toString()
          .trim();

      if (normalizedID.isEmpty) {
        continue;
      }

      configurationIDs.add(
        normalizedID,
      );
    }

    if (configurationIDs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to find configuration IDs.',
          ),
        ),
      );

      return false;
    }

    String? draftName =
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller =
        TextEditingController();

        return AlertDialog(
          title: const Text(
            "Enter Draft Name",
          ),
          content: TextField(
            controller: controller,
            decoration:
            const InputDecoration(
              hintText: "Draft Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(controller.text),
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Color(0xFF579AF6),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (draftName == null ||
        draftName.trim().isEmpty) {
      return false;
    }

    if (!mounted) {
      return false;
    }

    bool? confirmSave =
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Save?",
          ),
          content: const Text(
            "Are you sure you want to save these configurations as a draft? They will be removed from your cart, but can be retrieved from the Drafts page.",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(false),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(true),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Color(0xFF579AF6),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmSave != true) {
      return false;
    }

    setState(() {
      cartLoading = true;
    });

    final response =
    await DraftRepository.saveDraft(
      draftTitle: draftName.trim(),
      configurationIDs:
      configurationIDs,
    );

    if (!mounted) {
      return false;
    }

    setState(() {
      cartLoading = false;
    });

    final bool status =
        response.success &&
            response.data == true;

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully saved configurations to drafts!',
          ),
        ),
      );

      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message ??
              'Error when saving draft!',
        ),
      ),
    );

    return false;
  }

  // =========================================================
  // FINALIZE / SUBMIT CONFIGURATIONS
  //
  // Backend:
  //
  // PUT /api/configurations
  //
  // {
  //   "configurationIDs": [...]
  // }
  //
  // Backend changes:
  //
  // status = submitted
  // adminStatus = requested
  // =========================================================

  Future<bool> finalize() async {
    if (cartItems == null ||
        cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No configurations available to finalize.',
          ),
        ),
      );

      return false;
    }

    final List<String> configurationIDs = [];

    for (var item in cartItems) {
      if (item is! Map) {
        continue;
      }

      final dynamic configurationID =
      item["configurationID"];

      if (configurationID == null) {
        continue;
      }

      final String normalizedID =
      configurationID
          .toString()
          .trim();

      if (normalizedID.isEmpty) {
        continue;
      }

      configurationIDs.add(
        normalizedID,
      );
    }

    if (configurationIDs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to find configuration IDs.',
          ),
        ),
      );

      return false;
    }

    final bool? confirmFinalize =
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Finalize?",
          ),
          content: const Text(
            "Are you sure you want to finalize and submit these configurations?",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(false),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(true),
              child: const Text(
                "Finalize",
                style: TextStyle(
                  color: Color(0xFF579AF6),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmFinalize != true) {
      return false;
    }

    if (!mounted) {
      return false;
    }

    setState(() {
      cartLoading = true;
    });

    final response =
    await ConfigurationRepository.finalize(
      configurationIDs:
      configurationIDs,
    );

    if (!mounted) {
      return false;
    }

    setState(() {
      cartLoading = false;
    });

    final bool status =
        response.success &&
            response.data == true;

    if (status) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Success',
            ),
            content: const Text(
              'Successfully sent configuration to the team!',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                const Text('OK'),
              ),
            ],
          );
        },
      );

      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message ??
              'Error when finalizing configuration!',
        ),
      ),
    );

    return false;
  }

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    getOrders();
  }

  // =========================================================
  // RESET EDIT MODAL
  // =========================================================

  void _resetStates(
      List<dynamic> stateHolders,
      dynamic numRequested,
      ) {
    for (var state in stateHolders) {
      if (state["controller"] is int) {
        setState(() {
          state["controller"] =
          state["initial"];
        });
      } else {
        var controller =
        state["controller"]
        as TextEditingController;

        setState(() {
          controller.text =
          state["initial"];
        });
      }
    }

    numRequested["controller"] =
    numRequested["initial"];

    setState(() {});
  }

  // =========================================================
  // UPDATE CART CONFIGURATION
  // =========================================================

  Future<bool> _submitNewData(
      dynamic configurationID,
      Map<String, dynamic> newData,
      List<dynamic> stateHolders,
      dynamic numRequested,
      ) async {
    if (!_validateNewInfo(
      stateHolders,
    )) {
      return false;
    }

    setState(() {
      editLoading = true;
    });

    for (var formField
    in stateHolders) {
      if (formField
      is! Map<String, dynamic>) {
        continue;
      }

      var controller =
      formField["controller"];

      var initial =
      formField["initial"];

      if (controller is int) {
        if (controller != initial) {
          newData[
          formField["field"]] =
              controller;
        }
      } else if (controller
      is TextEditingController) {
        if (controller.text !=
            initial.toString()) {
          newData[
          formField["field"]] =
              controller.text;
        }
      }
    }

    final int numRequestedValue =
    numRequested["controller"]
    is int
        ? numRequested[
    "controller"]
        : int.tryParse(
      numRequested[
      "controller"]
          .toString(),
    ) ??
        1;

    final response =
    await CartRepository.updateOrder(
      configurationID:
      configurationID,
      newData: newData,
      numRequested:
      numRequestedValue,
    );

    if (!mounted) {
      return false;
    }

    setState(() {
      editLoading = false;
    });

    final bool status =
        response.success &&
            response.data == true;

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully updated form!',
          ),
        ),
      );

      getOrders();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message ??
                'Error when updating form!',
          ),
        ),
      );
    }

    return status;
  }

  // =========================================================
  // BUILD CONFIGURATION FIELD
  // =========================================================

  int setEntryData(
      dynamic stateHolders,
      List<List<String>> options,
      List<String> labels,
      MapEntry<dynamic, dynamic> entry,
      ) {
    labels.add(
      entry.key,
    );

    if (entry.value.runtimeType ==
        List &&
        entry.value.isNotEmpty &&
        entry.value[0]["value"]
            .runtimeType !=
            List) {
      List mappedOptions =
      entry.value as List;

      List<String> newList = [];

      options.add(
        newList,
      );

      bool hasSelected = false;

      for (var option
      in mappedOptions) {
        newList.add(
          option["value"],
        );

        if (option["isSelected"]
        as bool ==
            true) {
          hasSelected = true;

          int optionKey =
          option["key"];

          stateHolders.add(
            {
              "controller":
              optionKey,
              "initial":
              optionKey,
              "field":
              entry.key,
            },
          );
        }
      }

      if (!hasSelected &&
          mappedOptions.isNotEmpty) {
        stateHolders.add(
          {
            "controller":
            mappedOptions[0]
            ["key"],
            "initial":
            mappedOptions[0]
            ["key"],
            "field":
            entry.key,
          },
        );
      }
    } else if (entry.value
        .runtimeType !=
        List &&
        entry.value.runtimeType !=
            int &&
        entry.value is Map &&
        entry.value["value"] ==
            null) {
      entry.value.remove("_id");

      labels.remove(
        entry.key,
      );

      return setStateData(
        stateHolders,
        options,
        labels,
        entry.value,
      );
    } else {
      if (entry.value is int) {
        stateHolders.add(
          {
            "controller":
            TextEditingController(
              text:
              entry.value
                  .toString(),
            ),
            "initial":
            entry.value
                .toString(),
            "field":
            entry.key,
          },
        );
      } else {
        stateHolders.add(
          {
            "controller":
            TextEditingController(
              text:
              entry.value[
              "value"]
                  .toString(),
            ),
            "initial":
            entry.value[
            "value"]
                .toString(),
            "field":
            entry.key,
            "required":
            entry.value[
            "required"],
            "isString":
            entry.value[
            "isString"],
            "isNum":
            entry.value[
            "isNum"],
            "error": null,
          },
        );
      }

      options.add([]);
    }

    return 1;
  }

  // =========================================================
  // BUILD CONFIGURATION STATE
  // =========================================================

  int setStateData(
      dynamic stateHolders,
      List<List<String>> options,
      List<String> labels,
      Map orderInfo,
      ) {
    int numberOfFields = 0;

    for (var entry
    in orderInfo.entries) {
      numberOfFields +=
          setEntryData(
            stateHolders,
            options,
            labels,
            entry,
          );
    }

    return numberOfFields;
  }

  // =========================================================
  // SHOW CONFIGURATION
  // =========================================================

  void _showCurrentConfiguration(
      dynamic configurationID,
      bool isEditable,
      int numRequested,
      ) async {
    try {
      dynamic stateHolders = [];

      dynamic numRequestedState = {
        "controller": numRequested,
        "initial": numRequested,
      };

      List<List<String>> options =
      [];

      List<String> labels = [];

      Map<String, dynamic>
      newData = {};

      final response =
      await CartRepository.getOrder(
        configurationID:
        configurationID,
      );

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null) {
        setState(() {
          orderLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message ??
                  'Error when loading configuration!',
            ),
          ),
        );

        return;
      }

      final Map<String, dynamic>
      configuration =
      Map<String, dynamic>.from(
        response.data as Map,
      );

      final dynamic rawConfigurationData =
      configuration[
      "configurationData"];

      if (rawConfigurationData
      is! Map) {
        setState(() {
          orderLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Configuration data is missing.',
            ),
          ),
        );

        return;
      }

      Map<String, dynamic>
      configurationData =
      Map<String, dynamic>.from(
        rawConfigurationData,
      );

      configurationData.remove(
        "_id",
      );

      setState(() {
        orderLoading = false;
      });

      int numberOfFields =
      setStateData(
        stateHolders,
        options,
        labels,
        configurationData,
      );

      if (!mounted) {
        return;
      }

      showModalBottomSheet(
        backgroundColor:
        const Color(
          0xFF579AF6,
        ),
        showDragHandle: true,
        context: context,
        isScrollControlled: true,
        shape:
        const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(
            top:
            Radius.circular(15),
          ),
        ),
        builder: (context) {
          return Padding(
            padding:
            EdgeInsets.only(
              bottom:
              MediaQuery.of(context)
                  .viewInsets
                  .bottom,
            ),
            child:
            SingleChildScrollView(
              child: Container(
                color:
                const Color(
                  0xffffffff,
                ),
                padding:
                const EdgeInsets
                    .fromLTRB(
                  20.0,
                  5.0,
                  20.0,
                  0,
                ),
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    if (!isEditable)
                      const Padding(
                        padding:
                        EdgeInsets
                            .fromLTRB(
                          0,
                          20.0,
                          0,
                          0.0,
                        ),
                        child: Text(
                          "Current configuration",
                          style:
                          TextStyle(
                            fontSize:
                            20,
                            fontWeight:
                            FontWeight
                                .bold,
                            color:
                            Colors
                                .black87,
                          ),
                        ),
                      ),

                    if (isEditable)
                      Flexible(
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .fromLTRB(
                            0,
                            20.0,
                            0,
                            0.0,
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            children: [
                              IconButton(
                                onPressed:
                                    () {
                                  _resetStates(
                                    stateHolders,
                                    numRequestedState,
                                  );

                                  Navigator.of(
                                      context)
                                      .pop();
                                },
                                icon:
                                const Icon(
                                  Icons
                                      .cancel,
                                  color:
                                  Colors
                                      .red,
                                  size:
                                  40.0,
                                ),
                              ),

                              const Text(
                                "   Edit configuration?   ",
                                style:
                                TextStyle(
                                  fontSize:
                                  20,
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  color:
                                  Colors
                                      .black87,
                                ),
                              ),

                              editLoading
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                onPressed:
                                    () async {
                                  bool valid =
                                  await _submitNewData(
                                    configurationID,
                                    newData,
                                    stateHolders,
                                    numRequestedState,
                                  );

                                  if (valid &&
                                      mounted) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context)
                                        .pop();
                                  }
                                },
                                icon:
                                const Icon(
                                  Icons
                                      .check_circle,
                                  color:
                                  Colors
                                      .green,
                                  size:
                                  40.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    if (isEditable)
                      CommonWidgets
                          .buildCounter(
                        numRequestedState[
                        "controller"],
                        callback:
                            (int newNumRequested) =>
                        {
                          setState(
                                () {
                              numRequestedState[
                              "controller"] =
                                  newNumRequested;
                            },
                          )
                        },
                      ),

                    CommonWidgets
                        .buildSectionDivider(),

                    const SizedBox(
                      height: 20,
                    ),

                    ConstrainedBox(
                      constraints:
                      BoxConstraints(
                        maxHeight:
                        MediaQuery.of(
                          context,
                        ).size.height *
                            0.5,
                      ),
                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                        numberOfFields,
                        itemBuilder:
                            (
                            context,
                            index,
                            ) {
                          if (stateHolders[
                          index]
                          ["controller"]
                          is int) {
                            return CommonWidgets
                                .buildDropdownFieldError(
                              isEditable:
                              isEditable,
                              labels[
                              index],
                              options[
                              index],
                              stateHolders[
                              index]
                              [
                              "controller"],
                                  (value) {
                                setState(
                                      () {
                                    stateHolders[index]
                                    [
                                    "controller"] =
                                        value;
                                  },
                                );
                              },
                            );
                          }

                          return CommonWidgets
                              .buildTextField(
                            labels[
                            index],
                            stateHolders[
                            index]
                            [
                            "controller"],
                            isEditable:
                            isEditable,
                            errorText:
                            stateHolders[
                            index]
                            [
                            "error"],
                            callback:
                                (value) =>
                            {
                              _validateTextField(
                                value,
                                index,
                                stateHolders,
                              ),
                            },
                          );
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
    } catch (error) {
      if (mounted) {
        setState(() {
          orderLoading = false;
        });
      }

      if (kDebugMode) {
        print(
          "Error rendering the modal: $error",
        );
      }
    }
  }

  // =========================================================
  // DELETE CART CONFIGURATION
  // =========================================================

  Future<bool> removeOrder(
      dynamic configurationID,
      ) async {
    bool? confirmDelete =
    await showDialog<bool>(
      context: context,
      builder:
          (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Deletion",
          ),
          content: const Text(
            "Are you sure you want to delete this configuration? This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(false),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(true),
              child: const Text(
                "Delete",
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

    setState(() {
      deleteLoading = true;
    });

    final response =
    await CartRepository.deleteOrder(
      configurationID:
      configurationID,
    );

    if (!mounted) {
      return false;
    }

    setState(() {
      deleteLoading = false;
    });

    final bool status =
        response.success &&
            response.data == true;

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully deleted configuration!',
          ),
        ),
      );

      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message ??
              'Error when deleting configuration!',
        ),
      ),
    );

    return false;
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    double left =
        MediaQuery.of(context)
            .size
            .width *
            0.23;

    return Scaffold(
      appBar: CustomAppBar(
        link:
        const ApplicationCatalogPage(),
        customIcon:
        Icons.description,
        reload: false,
        cartItemCount:
        totalQuantities,
      ),

      drawer:
      const CustomDrawer(),

      body: cartLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : Column(
        children: [
          Expanded(
            child:
            cartItems.isEmpty
                ? Padding(
              padding:
              EdgeInsets
                  .fromLTRB(
                left,
                0,
                0,
                100,
              ),
              child:
              Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Icon(
                    Icons
                        .shopping_cart_outlined,
                    size:
                    80,
                    color:
                    Colors
                        .grey
                        .shade400,
                  ),
                  const Text(
                    "No products in the cart.",
                    style:
                    TextStyle(
                      fontSize:
                      18,
                      color:
                      Colors
                          .black,
                    ),
                  ),
                ],
              ),
            )
                : ListView
                .builder(
              itemCount:
              cartItems
                  .length,
              itemBuilder:
                  (
                  context,
                  index,
                  ) {
                final product =
                cartItems[
                index];

                final dynamic
                configurationID =
                product[
                "configurationID"];

                final String
                productName =
                    product[
                    "productName"]
                        ?.toString() ??
                        "Unknown Product";

                final int
                quantity =
                product[
                "quantity"]
                is int
                    ? product[
                "quantity"]
                    : int.tryParse(
                  product["quantity"]?.toString() ??
                      '1',
                ) ??
                    1;

                return GestureDetector(
                  onTap:
                      () {
                    setState(
                          () {
                        orderLoading =
                        true;
                      },
                    );

                    _showCurrentConfiguration(
                      configurationID,
                      false,
                      quantity,
                    );
                  },
                  child:
                  Card(
                    margin:
                    const EdgeInsets
                        .symmetric(
                      vertical:
                      8,
                      horizontal:
                      16,
                    ),
                    elevation:
                    3,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          10),
                    ),
                    child:
                    Padding(
                      padding:
                      const EdgeInsets.all(
                          12),
                      child:
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(8),
                            child:
                            Image.asset(
                              imageList[productName] ??
                                  "assets/Industrial.png",
                              width:
                              60,
                              height:
                              60,
                              fit:
                              BoxFit.cover,
                              errorBuilder:
                                  (
                                  context,
                                  error,
                                  stackTrace,
                                  ) =>
                                  Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 30,
                                    ),
                                  ),
                            ),
                          ),

                          const SizedBox(
                            width:
                            12,
                          ),

                          Expanded(
                            child:
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                  2,
                                ),

                                Text(
                                  'Number requested: $quantity',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                ),

                                if (product["configurationName"] != null &&
                                    product["configurationName"]
                                        .toString()
                                        .trim()
                                        .isNotEmpty)
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(
                                      top: 2,
                                    ),
                                    child:
                                    Text(
                                      product["configurationName"].toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              if (!orderLoading)
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(
                                          () {
                                        orderLoading = true;
                                      },
                                    );

                                    _showCurrentConfiguration(
                                      configurationID,
                                      true,
                                      quantity,
                                    );
                                  },
                                ),

                              if (orderLoading)
                                const CircularProgressIndicator(),

                              if (deleteLoading)
                                const CircularProgressIndicator(),

                              if (!deleteLoading)
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final bool success =
                                    await removeOrder(
                                      configurationID,
                                    );

                                    if (!success ||
                                        !mounted) {
                                      return;
                                    }

                                    setState(
                                          () {
                                        cartItems.removeAt(
                                          index,
                                        );

                                        totalQuantities -=
                                            quantity;

                                        if (totalQuantities <
                                            0) {
                                          totalQuantities =
                                          0;
                                        }
                                      },
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

          if (cartItems.isNotEmpty)
            Container(
              padding:
              const EdgeInsets
                  .symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black
                        .withValues(
                      alpha:
                      0.1,
                    ),
                    blurRadius:
                    5,
                    spreadRadius:
                    2,
                    offset:
                    const Offset(
                      0,
                      -2,
                    ),
                  ),
                ],
              ),
              child:
              Column(
                mainAxisSize:
                MainAxisSize
                    .min,
                children: [
                  const SizedBox(
                    height:
                    10,
                  ),

                  Container(
                    width:
                    double
                        .infinity,
                    decoration:
                    BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                      gradient:
                      const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.lightBlueAccent,
                        ],
                        begin:
                        Alignment.topLeft,
                        end:
                        Alignment.bottomRight,
                      ),
                    ),
                    child:
                    TextButton(
                      onPressed:
                          () async {
                        final bool
                        success =
                        await saveDraft();

                        if (!success ||
                            !mounted) {
                          return;
                        }

                        setState(
                              () {
                            cartItems =
                            [];
                            totalQuantities =
                            0;
                          },
                        );
                      },
                      child:
                      const Text(
                        "SAVE CONFIGURATION",
                        style:
                        TextStyle(
                          fontSize:
                          16,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:
                    15,
                  ),

                  Container(
                    width:
                    double
                        .infinity,
                    decoration:
                    BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                      gradient:
                      const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.lightBlueAccent,
                        ],
                        begin:
                        Alignment.topLeft,
                        end:
                        Alignment.bottomRight,
                      ),
                    ),
                    child:
                    TextButton(
                      onPressed:
                          () async {
                        final bool
                        success =
                        await finalize();

                        if (!success ||
                            !mounted) {
                          return;
                        }

                        setState(
                              () {
                            cartItems =
                            [];
                            totalQuantities =
                            0;
                          },
                        );
                      },
                      child:
                      const Text(
                        "FINALIZE CONFIGURATION",
                        style:
                        TextStyle(
                          fontSize:
                          16,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height:
                    20,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}