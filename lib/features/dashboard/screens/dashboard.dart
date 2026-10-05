import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/login_page.dart';
import 'package:mighty_lube/features/configurations/repositories/configuration_repository.dart';

import '../../admin/screens/admin_dashboard.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';
import '../../cart/repositories/cart_repositories.dart';
import '../../cart/screens/shopping_page.dart';
import '../../profile/screens/profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color _navy = Color(0xFF17223B);
  static const Color _background = Color(0xFFF4F7FB);
  static const Color _border = Color(0xFFE5EAF1);

  bool loading = true;
  bool isAdmin = false;

  bool configurationsExpanded = false;
  bool configurationsLoading = false;

  String name = 'User';

  int totalQuantities = 0;

  List<dynamic> configurations = [];

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _loadDashboard();
  }

  // =========================================================
  // LOAD DASHBOARD
  // =========================================================

  Future<void> _loadDashboard() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }

    try {
      await Future.wait([
        _loadUserInfo(),
        _loadOrders(),
        _loadAdminStatus(),
        _loadConfigurations(),
      ]);
    } catch (e) {
      if (kDebugMode) {
        print('Dashboard load error: $e');
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      loading = false;
    });
  }

  // =========================================================
  // LOAD USER INFO
  // =========================================================

  Future<void> _loadUserInfo() async {
    try {
      final response = await UserRepository.getUserInfo();

      if (!mounted) {
        return;
      }

      if (response.success && response.data != null) {
        final data = response.data!;

        final firstName =
            data['firstName']?.toString().trim() ?? '';

        final username =
            data['username']?.toString().trim() ?? '';

        setState(() {
          if (firstName.isNotEmpty) {
            name = firstName;
          } else if (username.isNotEmpty) {
            name = username;
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('User info error: $e');
      }
    }
  }

  // =========================================================
  // LOAD ADMIN STATUS
  // =========================================================

  Future<void> _loadAdminStatus() async {
    try {
      final admin =
      await UserRepository.isCurrentUserAdmin();

      if (!mounted) {
        return;
      }

      setState(() {
        isAdmin = admin;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Admin status error: $e');
      }

      if (!mounted) {
        return;
      }

      setState(() {
        isAdmin = false;
      });
    }
  }

  // =========================================================
  // LOAD CART
  // =========================================================

  Future<void> _loadOrders() async {
    try {
      final response =
      await CartRepository.getOrders();

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null) {
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

      setState(() {
        totalQuantities = total;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Cart load error: $e');
      }
    }
  }

  // =========================================================
  // LOAD SUBMITTED CONFIGURATIONS
  // =========================================================

  Future<void> _loadConfigurations() async {
    if (mounted) {
      setState(() {
        configurationsLoading = true;
      });
    }

    try {
      final response =
      await ConfigurationRepository.getConfigurations();

      // =======================================================
      // DEBUG CONFIGURATION RESPONSE
      // =======================================================

      if (kDebugMode) {
        print('==========================================');
        print('GET CONFIGURATIONS RESPONSE');
        print('==========================================');

        print('SUCCESS: ${response.success}');
        print('MESSAGE: ${response.message}');
        print('DATA TYPE: ${response.data.runtimeType}');
        print('DATA: ${response.data}');

        if (response.data != null) {
          print('TOTAL CONFIGURATIONS: ${response.data!.length}');

          for (int i = 0; i < response.data!.length; i++) {
            final item = response.data![i];

            print('------------------------------------------');
            print('CONFIGURATION [$i]');
            print('TYPE: ${item.runtimeType}');
            print('RAW DATA: $item');

            if (item is Map) {
              print('KEYS: ${item.keys.toList()}');

              item.forEach((key, value) {
                print(
                  '[$i] $key = $value '
                      '(type: ${value.runtimeType})',
                );
              });
            }
          }
        }

        print('==========================================');
      }

      if (!mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          configurations =
              response.data ?? <dynamic>[];

          configurationsLoading = false;
        });
      } else {
        setState(() {
          configurations = <dynamic>[];
          configurationsLoading = false;
        });
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('==========================================');
        print('GET CONFIGURATIONS ERROR');
        print('ERROR: $e');
        print('STACK TRACE: $stackTrace');
        print('==========================================');
      }

      if (!mounted) {
        return;
      }

      setState(() {
        configurations = <dynamic>[];
        configurationsLoading = false;
      });
    }
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> logoutUser() async {
    final bool? confirmLogout =
    await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirm logout',
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(false);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(true);
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmLogout != true) {
      return;
    }

    setState(() {
      loading = true;
    });

    final response =
    await UserRepository.logout();

    if (!mounted) {
      return;
    }

    setState(() {
      loading = false;
    });

    if (response.success &&
        response.data == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully logged out!',
          ),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const LoginPage(),
        ),
            (route) => false,
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          response.message ??
              'Error when logging out!',
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGATION
  // =========================================================

  void _openNewConfiguration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const ApplicationCatalogPage(),
      ),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const ProfilePage(),
      ),
    );
  }

  void _openAdminDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const AdminDashboardPage(),
      ),
    );
  }

  // =========================================================
  // CONFIGURATION EXPAND / COLLAPSE
  // =========================================================

  void _toggleConfigurations() {
    setState(() {
      configurationsExpanded =
      !configurationsExpanded;
    });
  }

  // =========================================================
  // SHOW SUBMITTED CONFIGURATION INFO
  // =========================================================

  void _showConfigurationInfo(
      Map<String, dynamic> configuration,
      ) {
    final configurationName =
        configuration['configurationName']
            ?.toString()
            .trim() ??
            '';

    final productName =
        configuration['productName']
            ?.toString()
            .trim() ??
            '';

    final productType =
        configuration['productType']
            ?.toString()
            .trim() ??
            '';

    final quantity =
        int.tryParse(
          configuration['quantity']?.toString() ?? '0',
        ) ??
            0;

    final status =
        configuration['status']
            ?.toString()
            .trim() ??
            '';

    final submittedAt = _formatConfigurationDate(
      configuration['submittedAt'],
    );

    final createdAt = _formatConfigurationDate(
      configuration['createdAt'],
    );

    final updatedAt = _formatConfigurationDate(
      configuration['updatedAt'],
    );

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                8,
                22,
                28,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Submitted Configuration',
                              style: TextStyle(
                                color: _navy,
                                fontSize: 20,
                                fontWeight:
                                FontWeight.w800,
                              ),
                            ),
                            if (productName.isNotEmpty) ...[
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                productName,
                                style: TextStyle(
                                  color:
                                  Colors.grey.shade600,
                                  fontSize: 14,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(
                            sheetContext,
                          ).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  _buildInfoRow(
                    icon: Icons.inventory_2_outlined,
                    label: 'Product',
                    value: productName.isEmpty
                        ? 'Not available'
                        : productName,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.tag_rounded,
                    label: 'Product ID',
                    value: productType.isEmpty
                        ? 'Not available'
                        : productType,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.description_outlined,
                    label: 'Configuration Name',
                    value: configurationName.isEmpty
                        ? 'Not available'
                        : configurationName,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.numbers_rounded,
                    label: 'Quantity',
                    value: quantity.toString(),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Status',
                    value: status.isEmpty
                        ? 'Not available'
                        : _capitalizeFirst(status),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.send_outlined,
                    label: 'Submitted',
                    value: submittedAt,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Created',
                    value: createdAt,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _buildInfoRow(
                    icon: Icons.update_rounded,
                    label: 'Last Updated',
                    value: updatedAt,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _capitalizeFirst(String value) {
    final text = value.trim();

    if (text.isEmpty) {
      return text;
    }

    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  String _formatConfigurationDate(dynamic rawDate) {
    final value =
        rawDate?.toString().trim() ?? '';

    if (value.isEmpty) {
      return 'Not available';
    }

    final parsed = DateTime.tryParse(value);

    if (parsed == null) {
      return value;
    }

    final localDate = parsed.toLocal();

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[localDate.month - 1];

    final hour12 =
    localDate.hour == 0
        ? 12
        : localDate.hour > 12
        ? localDate.hour - 12
        : localDate.hour;

    final minute =
    localDate.minute.toString().padLeft(2, '0');

    final period =
    localDate.hour >= 12 ? 'PM' : 'AM';

    return '$month ${localDate.day}, '
        '${localDate.year} • '
        '$hour12:$minute $period';
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _background,
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: _navy,
            size: 22,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 14,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: CustomAppBar(
        link: const ApplicationCatalogPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: loading ? const Center(child: CircularProgressIndicator.adaptive(),)
          : RefreshIndicator(
        onRefresh: _loadDashboard,
        child: LayoutBuilder(
          builder: (
              context,
              constraints,
              ) {
            final width =
                constraints.maxWidth;

            final isMobile =
                width < 700;

            return SingleChildScrollView(
              physics:
              const AlwaysScrollableScrollPhysics(),
              padding:
              EdgeInsets.symmetric(
                horizontal:
                isMobile ? 16 : 28,
                vertical:
                isMobile ? 20 : 28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(
                    maxWidth: 1180,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      _buildWelcomeSection(
                        isMobile,
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      if (isAdmin) ...[
                        _buildAdminCard(
                          isMobile,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],

                      _buildPrimaryAction(
                        isMobile,
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      _buildSectionTitle(
                        'My Account',
                        'Manage your configurations and account.',
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      _buildConfigurationsCard(
                        isMobile,
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      _buildProfileCard(),

                      const SizedBox(
                        height: 28,
                      ),

                      _buildAccountSection(
                        isMobile,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // WELCOME
  // =========================================================

  Widget _buildWelcomeSection(
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: _border,
        ),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(
              0,
              6,
            ),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildWelcomeContent(),
          const SizedBox(
            height: 18,
          ),
          _buildLogoutButton(),
        ],
      )
          : Row(
        children: [
          Expanded(
            child:
            _buildWelcomeContent(),
          ),
          const SizedBox(
            width: 24,
          ),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildWelcomeContent() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name',
          style: const TextStyle(
            color: _navy,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          isAdmin
              ? 'Manage your configurations, account, and administrative workspace.'
              : 'Manage your product configurations and account from one place.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return OutlinedButton.icon(
      onPressed: logoutUser,
      icon: const Icon(
        Icons.logout_rounded,
        size: 19,
      ),
      label: const Text(
        'Logout',
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor:
        Colors.red.shade700,
        side: BorderSide(
          color: Colors.red.shade100,
        ),
        padding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
      ),
    );
  }

  // =========================================================
  // ADMIN CARD
  // =========================================================

  Widget _buildAdminCard(
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 18 : 22,
      ),
      decoration: BoxDecoration(
        color: _navy,
        borderRadius:
        BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
            _navy.withOpacity(0.16),
            blurRadius: 20,
            offset: const Offset(
              0,
              8,
            ),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildAdminInformation(),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: double.infinity,
            child:
            _buildAdminButton(),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child:
            _buildAdminInformation(),
          ),
          const SizedBox(
            width: 24,
          ),
          _buildAdminButton(),
        ],
      ),
    );
  }

  Widget _buildAdminInformation() {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
            Colors.white.withOpacity(
              0.12,
            ),
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons
                .admin_panel_settings_outlined,
            color: Colors.white,
            size: 27,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'ADMINISTRATION',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight:
                  FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                  FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Review customer configurations, workflow status, and users.',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(0.75),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdminButton() {
    return FilledButton.icon(
      onPressed: _openAdminDashboard,
      icon: const Icon(
        Icons.arrow_forward_rounded,
      ),
      label: const Text(
        'Open Admin Dashboard',
      ),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: _navy,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
    );
  }

  // =========================================================
  // NEW CONFIGURATION
  // =========================================================

  Widget _buildPrimaryAction(
      bool isMobile,
      ) {
    return SizedBox(
      width:
      isMobile ? double.infinity : 280,
      child: FilledButton.icon(
        onPressed: _openNewConfiguration,
        icon: const Icon(
          Icons.add_rounded,
        ),
        label: const Text(
          'New Configuration',
        ),
        style: FilledButton.styleFrom(
          backgroundColor: _navy,
          foregroundColor: Colors.white,
          padding:
          const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 17,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget _buildSectionTitle(
      String title,
      String subtitle,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _navy,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // MY CONFIGURATIONS - EXPANDABLE
  // =========================================================

  Widget _buildConfigurationsCard(
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: configurationsExpanded
              ? _navy.withOpacity(0.20)
              : _border,
        ),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleConfigurations,
              borderRadius:
              BorderRadius.circular(16),
              child: Padding(
                padding:
                const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      alignment:
                      Alignment.center,
                      decoration:
                      BoxDecoration(
                        color: _navy
                            .withOpacity(0.07),
                        borderRadius:
                        BorderRadius
                            .circular(13),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: _navy,
                        size: 25,
                      ),
                    ),

                    const SizedBox(
                      width: 15,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Row(
                            children: [
                              const Flexible(
                                child: Text(
                                  'My Configurations',
                                  style:
                                  TextStyle(
                                    color:
                                    _navy,
                                    fontSize:
                                    16,
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              Container(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 9,
                                  vertical: 4,
                                ),
                                decoration:
                                BoxDecoration(
                                  color: _navy
                                      .withOpacity(
                                    0.08,
                                  ),
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  '${configurations.length}',
                                  style:
                                  const TextStyle(
                                    color:
                                    _navy,
                                    fontSize:
                                    12,
                                    fontWeight:
                                    FontWeight
                                        .w800,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            configurations.isEmpty
                                ? 'No submitted configurations yet.'
                                : configurations.length == 1
                                ? '1 submitted configuration'
                                : '${configurations.length} submitted configurations',
                            style:
                            TextStyle(
                              color: Colors
                                  .grey
                                  .shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    AnimatedRotation(
                      turns:
                      configurationsExpanded
                          ? 0.5
                          : 0,
                      duration:
                      const Duration(
                        milliseconds: 200,
                      ),
                      child: Icon(
                        Icons
                            .keyboard_arrow_down_rounded,
                        color: Colors
                            .grey.shade600,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (configurationsExpanded) ...[
            const Divider(
              height: 1,
              color: _border,
            ),

            if (configurationsLoading)
              const Padding(
                padding:
                EdgeInsets.all(30),
                child:
                CircularProgressIndicator
                    .adaptive(),
              )
            else if (configurations.isEmpty)
              _buildEmptyConfigurations()
            else
              _buildConfigurationsList(
                isMobile,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyConfigurations() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        children: [
          Icon(
            Icons
                .inventory_2_outlined,
            size: 42,
            color: Colors.grey.shade400,
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            'No submitted configurations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _navy,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            'Your submitted configurations will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          OutlinedButton.icon(
            onPressed:
            _openNewConfiguration,
            icon: const Icon(
              Icons.add_rounded,
            ),
            label: const Text(
              'New Configuration',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationsList(
      bool isMobile,
      ) {
    return Padding(
      padding: EdgeInsets.all(
        isMobile ? 12 : 16,
      ),
      child: Column(
        children: [
          for (int index = 0;
          index <
              configurations.length;
          index++) ...[
            _buildConfigurationItem(
              configurations[index],
              index,
              isMobile,
            ),

            if (index !=
                configurations.length - 1)
              const SizedBox(
                height: 10,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildConfigurationItem(
      dynamic rawConfiguration,
      int index,
      bool isMobile,
      ) {
    if (rawConfiguration is! Map) {
      return const SizedBox.shrink();
    }

    final configuration =
    Map<String, dynamic>.from(
      rawConfiguration,
    );

    final productName =
        configuration['productName']
            ?.toString()
            .trim() ??
            '';

    final productType =
        configuration['productType']
            ?.toString()
            .trim() ??
            '';

    final configurationName =
        configuration['configurationName']
            ?.toString()
            .trim() ??
            '';

    final quantity =
        int.tryParse(
          configuration['quantity']?.toString() ?? '0',
        ) ??
            0;

    final submittedAt = _formatConfigurationDate(
      configuration['submittedAt'],
    );

    final displayName =
    productName.isNotEmpty
        ? productName
        : configurationName.isNotEmpty
        ? configurationName
        : 'Configuration ${index + 1}';

    final details = Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: _navy,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),

        if (productType.isNotEmpty) ...[
          const SizedBox(
            height: 5,
          ),
          Text(
            'Product ID: $productType',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],

        const SizedBox(
          height: 8,
        ),

        Wrap(
          spacing: 12,
          runSpacing: 7,
          children: [
            _buildSmallInfo(
              Icons.numbers_rounded,
              'Quantity: $quantity',
            ),
            _buildSmallInfo(
              Icons.calendar_today_outlined,
              'Submitted: $submittedAt',
            ),
          ],
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(
          0xFFFAFBFC,
        ),
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color: _border,
        ),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF0FDF4,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    11,
                  ),
                ),
                child: const Icon(
                  Icons
                      .check_circle_outline_rounded,
                  color: Color(
                    0xFF15803D,
                  ),
                  size: 22,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: details,
              ),
            ],
          ),

          const SizedBox(
            height: 14,
          ),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                _showConfigurationInfo(
                  configuration,
                );
              },
              icon: const Icon(
                Icons.visibility_outlined,
                size: 17,
              ),
              label: const Text(
                'View',
              ),
              style:
              OutlinedButton.styleFrom(
                foregroundColor: _navy,
                padding:
                const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      )
          : Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(
                0xFFF0FDF4,
              ),
              borderRadius:
              BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons
                  .check_circle_outline_rounded,
              color: Color(
                0xFF15803D,
              ),
              size: 22,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: details,
          ),

          const SizedBox(
            width: 16,
          ),

          OutlinedButton.icon(
            onPressed: () {
              _showConfigurationInfo(
                configuration,
              );
            },
            icon: const Icon(
              Icons.visibility_outlined,
              size: 17,
            ),
            label: const Text(
              'View',
            ),
            style:
            OutlinedButton.styleFrom(
              foregroundColor: _navy,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInfo(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.grey.shade500,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PROFILE CARD
  // =========================================================

  Widget _buildProfileCard() {
    return Material(
      color: Colors.white,
      borderRadius:
      BorderRadius.circular(16),
      child: InkWell(
        onTap: _openProfile,
        borderRadius:
        BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding:
          const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(16),
            border: Border.all(
              color: _border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                alignment:
                Alignment.center,
                decoration:
                BoxDecoration(
                  color: _navy
                      .withOpacity(0.07),
                  borderRadius:
                  BorderRadius
                      .circular(13),
                ),
                child: const Icon(
                  Icons
                      .person_outline_rounded,
                  color: _navy,
                  size: 25,
                ),
              ),

              const SizedBox(
                width: 15,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 16,
                        fontWeight:
                        FontWeight
                            .w700,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Manage your account and contact information.',
                      style: TextStyle(
                        color: Colors
                            .grey.shade600,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              Icon(
                Icons
                    .arrow_forward_ios_rounded,
                size: 16,
                color:
                Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // CART SECTION
  // =========================================================

  Widget _buildAccountSection(
      bool isMobile,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 18 : 22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: _border,
        ),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildCartInformation(),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child:
            OutlinedButton.icon(
              onPressed:
              _openNewConfiguration,
              icon: const Icon(
                Icons
                    .add_shopping_cart_rounded,
              ),
              label: const Text(
                'Add Configuration',
              ),
            ),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child:
            _buildCartInformation(),
          ),
          const SizedBox(
            width: 20,
          ),
          OutlinedButton.icon(
            onPressed:
            _openNewConfiguration,
            icon: const Icon(
              Icons
                  .add_shopping_cart_rounded,
            ),
            label: const Text(
              'Add Configuration',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartInformation() {
    return GestureDetector(
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ShoppingPage(),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
              _navy.withOpacity(0.07),
              borderRadius:
              BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: _navy,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Cart',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  totalQuantities == 1
                      ? '1 item currently in your cart'
                      : '$totalQuantities items currently in your cart',
                  style: TextStyle(
                    color:
                    Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}