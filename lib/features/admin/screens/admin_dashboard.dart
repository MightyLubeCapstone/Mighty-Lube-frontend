import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_response.dart';
import '../../../core/widget/product_configuration_form.dart';
import '../../products/service/product_catalog_resolver.dart';

import '../models/admin_models.dart';
import '../repositories/admin_repository.dart';

import '../widgets/common/admin_filter_bar.dart';
import '../widgets/common/admin_summary_cards.dart';

import '../widgets/configuration/configuration_dialogs.dart';
import '../widgets/configuration/configuration_image_gallery.dart';
import '../widgets/configuration/configuration_list.dart';

import '../widgets/users/user_cards.dart';
import '../widgets/users/user_dialogs.dart';
import '../widgets/users/user_table.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({
    super.key,
  });

  @override
  State<AdminDashboardPage> createState() =>
      _AdminDashboardPageState();
}

class _AdminDashboardPageState
    extends State<AdminDashboardPage> {
  static const Color navy =
  Color(0xFF17223B);

  static const Color background =
  Color(0xFFF4F7FB);

  static const List<String> roles = [
    'user',
    'admin',
  ];

  // =========================================================
  // DATA
  // =========================================================

  AdminConfigurationSummary _summary =
  const AdminConfigurationSummary();

  List<AdminConfiguration> _configurations = [];

  List<AdminUser> _users = [];

  // =========================================================
  // LOADING / ERROR
  // =========================================================

  bool _loadingConfigurations = true;

  bool _loadingUsers = true;

  String? _configurationError;

  String? _userError;

  // =========================================================
  // UPDATE / DELETE STATE
  // =========================================================

  final Set<String> _updatingConfigurations = {};

  final Set<String> _updatingUsers = {};

  final Set<String> _deletingConfigurations = {};

  final Set<String> _deletingUsers = {};

  // =========================================================
  // FILTERS
  // =========================================================

  AdminConfigurationFilters _configurationFilters =
  const AdminConfigurationFilters(
    adminWorkflowStatus: 'all',
  );

  AdminConfigurationFilters _userFilters =
  const AdminConfigurationFilters();

  bool _groupConfigurationsByStatus = false;

  // Selected person for the configuration list.
  // null = All People.
  String? _selectedConfigurationUserID;

  Map<String, String> get _configurationPeople {
    final configurationUserIDs = _configurations
        .map((item) => item.userID)
        .where((id) => id.trim().isNotEmpty)
        .toSet();

    final people = <String, String>{};

    // Prefer the full user record when it is available.
    for (final user in _users) {
      if (!configurationUserIDs.contains(user.userID)) {
        continue;
      }

      final name = user.name.trim();

      people[user.userID] = name.isNotEmpty
          ? name
          : user.username.trim().isNotEmpty
          ? user.username.trim()
          : user.userID;
    }

    // Fallback for configurations whose user is not present in _users.
    for (final configuration in _configurations) {
      if (configuration.userID.trim().isEmpty ||
          people.containsKey(configuration.userID)) {
        continue;
      }

      final createdBy = configuration.createdBy;

      final firstName =
          createdBy?['firstName']?.toString().trim() ?? '';
      final lastName =
          createdBy?['lastName']?.toString().trim() ?? '';
      final username =
          createdBy?['username']?.toString().trim() ?? '';

      final fullName = '$firstName $lastName'.trim();

      people[configuration.userID] = fullName.isNotEmpty
          ? fullName
          : username.isNotEmpty
          ? username
          : configuration.userID;
    }

    final entries = people.entries.toList()
      ..sort(
            (a, b) => a.value
            .toLowerCase()
            .compareTo(b.value.toLowerCase()),
      );

    return {
      for (final entry in entries) entry.key: entry.value,
    };
  }

  List<AdminConfiguration> get _visibleConfigurations {
    final selectedUserID = _selectedConfigurationUserID;

    if (selectedUserID == null || selectedUserID.isEmpty) {
      return _configurations;
    }

    return _configurations
        .where(
          (item) => item.userID == selectedUserID,
    )
        .toList();
  }

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _guardAndLoad();
  }

  // =========================================================
  // AUTH GUARD
  // =========================================================

  Future<void> _guardAndLoad() async {
    final prefs =
    await SharedPreferences.getInstance();

    final token =
    prefs.getString('sessionID');

    final role = prefs
        .getString('role')
        ?.toLowerCase();

    if (token == null || token.isEmpty) {
      await _redirectToLogin();

      return;
    }

    if (role != 'admin') {
      await _redirectForbidden();

      return;
    }

    await Future.wait([
      _loadConfigurations(),
      _loadUsers(),
    ]);
  }

  // =========================================================
  // LOAD CONFIGURATIONS
  // =========================================================

  Future<void> _loadConfigurations() async {
    if (mounted) {
      setState(() {
        _loadingConfigurations = true;
        _configurationError = null;
      });
    }

    try {
      final response =
      await AdminRepository.getConfigurations(
        filters: _configurationFilters,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null) {
        setState(() {
          _configurationError =
              response.message ??
                  'Unable to load configurations.';

          _loadingConfigurations = false;
        });

        return;
      }

      setState(() {
        _summary =
            response.data!.summary;

        _configurations =
            response.data!.data;

        _loadingConfigurations = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _configurationError =
        'Unable to load configurations.';

        _loadingConfigurations = false;
      });
    }
  }

  // =========================================================
  // LOAD USERS
  // =========================================================

  Future<void> _loadUsers() async {
    if (mounted) {
      setState(() {
        _loadingUsers = true;
        _userError = null;
      });
    }

    try {
      final response =
      await AdminRepository.getUsers(
        filters: _userFilters,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null) {
        setState(() {
          _userError =
              response.message ??
                  'Unable to load users.';

          _loadingUsers = false;
        });

        return;
      }

      setState(() {
        _users = response.data!;

        _loadingUsers = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _userError =
        'Unable to load users.';

        _loadingUsers = false;
      });
    }
  }

  // =========================================================
  // AUTH RESPONSE HANDLING
  // =========================================================

  Future<bool> _handleAuthStatus(
      int? statusCode,
      ) async {
    if (statusCode == 401) {
      await _redirectToLogin();

      return true;
    }

    if (statusCode == 403) {
      await _redirectForbidden();

      return true;
    }

    return false;
  }

  // =========================================================
  // REDIRECT TO LOGIN
  // =========================================================

  Future<void> _redirectToLogin() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('sessionID');
    await prefs.remove('role');
    await prefs.remove('username');

    if (!mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (_) => false,
    );
  }

  // =========================================================
  // FORBIDDEN
  // =========================================================

  Future<void> _redirectForbidden() async {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Administrator access is required.',
        ),
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/dashboard',
          (_) => false,
    );
  }

  // =========================================================
  // ADMIN WORKFLOW STATUS
  // =========================================================

  Future<void> _changeStatus(
      AdminConfiguration configuration,
      String? status,
      ) async {
    final currentStatus =
        configuration.adminWorkflowStatus ??
            'requested';

    const allowedStatuses = {
      'requested',
      'pending',
      'done',
    };

    if (status == null ||
        status == currentStatus ||
        !allowedStatuses.contains(status) ||
        _updatingConfigurations.contains(
          configuration.id,
        )) {
      return;
    }

    setState(() {
      _updatingConfigurations.add(
        configuration.id,
      );
    });

    try {
      final response =
      await AdminRepository
          .updateAdminWorkflowStatus(
        configurationID:
        configuration.id,
        adminWorkflowStatus: status,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null ||
          response.data!.isEmpty) {
        _message(
          response.message ??
              'Unable to update configuration status.',
          error: true,
        );

        if (response.statusCode == 404) {
          await _loadConfigurations();
        }

        return;
      }

      setState(() {
        configuration.adminWorkflowStatus =
        response.data!;

        _recalculateSummary();
      });

      _message(
        'Configuration status updated.',
      );
    } catch (_) {
      _message(
        'Unable to update configuration status.',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _updatingConfigurations.remove(
            configuration.id,
          );
        });
      }
    }
  }

  // =========================================================
  // CHANGE USER ROLE
  // =========================================================

  Future<void> _changeRole(
      AdminUser user,
      String? role,
      ) async {
    if (role == null ||
        role == user.role ||
        _updatingUsers.contains(
          user.userID,
        )) {
      return;
    }

    setState(() {
      _updatingUsers.add(
        user.userID,
      );
    });

    try {
      final response =
      await AdminRepository.updateUserRole(
        userID: user.userID,
        role: role,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success ||
          response.data == null ||
          response.data!.isEmpty) {
        _message(
          response.message ??
              'Unable to update user role.',
          error: true,
        );

        if (response.statusCode == 404) {
          await _loadUsers();
        }

        return;
      }

      setState(() {
        user.role = response.data!;
      });

      _message(
        'User role updated.',
      );
    } catch (_) {
      _message(
        'Unable to update user role.',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _updatingUsers.remove(
            user.userID,
          );
        });
      }
    }
  }

  // =========================================================
  // RECALCULATE SUMMARY
  // =========================================================

  void _recalculateSummary() {
    _summary = AdminConfigurationSummary(
      total: _configurations.length,
      requested: _configurations
          .where(
            (item) =>
        (item.adminWorkflowStatus ??
            'requested') ==
            'requested',
      )
          .length,
      pending: _configurations
          .where(
            (item) =>
        item.adminWorkflowStatus ==
            'pending',
      )
          .length,
      done: _configurations
          .where(
            (item) =>
        item.adminWorkflowStatus ==
            'done',
      )
          .length,
    );
  }

  // =========================================================
  // CONFIGURATION FILTER
  // =========================================================

  void _setConfigurationFilters(
      AdminConfigurationFilters filters,
      ) {
    setState(() {
      _configurationFilters = filters;
    });

    _loadConfigurations();
  }

  void _setGroupConfigurationsByStatus(
      bool value,
      ) {
    setState(() {
      _groupConfigurationsByStatus =
          value;
    });
  }

  // =========================================================
  // USER FILTER
  // =========================================================

  void _setUserFilters(
      AdminConfigurationFilters filters,
      ) {
    setState(() {
      _userFilters = filters;
    });

    _loadUsers();
  }

  // =========================================================
  // VIEW CONFIGURATION
  // =========================================================

  void _viewConfiguration(
      AdminConfiguration configuration,
      ) {
    showDialog<void>(
      context: context,
      builder: (_) =>
          ConfigurationDetailsDialog(
            configuration: configuration,
          ),
    );
  }

  // =========================================================
  // EDIT CONFIGURATION
  // =========================================================

  Future<void> _editConfiguration(
      AdminConfiguration configuration,
      ) async {
    try {
      final response =
      await AdminRepository.getConfiguration(
        configurationID:
        configuration.id,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!response.success ||
          response.data == null) {
        _message(
          response.message ??
              'Unable to load configuration.',
          error: true,
        );

        return;
      }

      final fullConfiguration =
      response.data!;

      final productDetail =
      ProductCatalogResolver.findById(
        fullConfiguration.productType,
      );

      if (productDetail == null) {
        _message(
          'Product form not found for '
              '${fullConfiguration.productType}.',
          error: true,
        );

        return;
      }

      final initialData =
      Map<String, dynamic>.from(
        fullConfiguration.configurationData,
      );

      initialData.remove('_id');

      if (!mounted) {
        return;
      }

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return Dialog(
            clipBehavior:
            Clip.antiAlias,
            insetPadding:
            const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                16,
              ),
            ),
            child: ConstrainedBox(
              constraints:
              const BoxConstraints(
                maxWidth: 1100,
                maxHeight: 850,
              ),
              child: Column(
                children: [
                  _buildConfigurationEditHeader(
                    dialogContext,
                    fullConfiguration:
                    fullConfiguration,
                    fallbackProductName:
                    productDetail.title,
                  ),

                  Expanded(
                    child:
                    ProductConfigurationForm(
                      product:
                      productDetail,
                      initialConfiguration:
                      initialData,
                      initialQuantity:
                      fullConfiguration
                          .numRequested,
                      onUpdate: (
                          updatedConfiguration,
                          quantity,
                          ) async {
                        final updateResponse =
                        await AdminRepository
                            .updateConfiguration(
                          configurationID:
                          fullConfiguration
                              .id,
                          changes: {
                            'configurationData':
                            updatedConfiguration,
                            'numRequested':
                            quantity,
                          },
                        );

                        if (!updateResponse
                            .success) {
                          return ApiResponse<
                              bool>.failure(
                            message:
                            updateResponse
                                .message ??
                                'Unable to update configuration.',
                            statusCode:
                            updateResponse
                                .statusCode,
                          );
                        }

                        return ApiResponse<
                            bool>.success(
                          data: true,
                          message:'Configuration updated successfully.',
                          statusCode:
                          updateResponse
                              .statusCode,
                        );
                      },
                      onUpdateSuccess:
                          () async {
                        Navigator.of(
                          dialogContext,
                        ).pop();

                        await _loadConfigurations();

                        if (!mounted) {
                          return;
                        }

                        _message(
                          'Configuration updated successfully.',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      _message(
        'Unable to load configuration.',
        error: true,
      );
    }
  }

  // =========================================================
  // CONFIGURATION EDIT HEADER
  // =========================================================

  Widget _buildConfigurationEditHeader(
      BuildContext dialogContext, {
        required AdminConfiguration
        fullConfiguration,
        required String fallbackProductName,
      }) {
    final productName =
    fullConfiguration.productName
        .trim()
        .isNotEmpty
        ? fullConfiguration.productName
        : fallbackProductName;

    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.fromLTRB(
        24,
        18,
        12,
        18,
      ),
      decoration: BoxDecoration(
        color: Theme.of(dialogContext)
            .colorScheme
            .surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(dialogContext)
                .dividerColor,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(
                dialogContext,
              )
                  .colorScheme
                  .primary
                  .withOpacity(
                0.10,
              ),
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              Icons.tune_rounded,
              color:
              Theme.of(dialogContext)
                  .colorScheme
                  .primary,
              size: 25,
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
                Text(
                  'PRODUCT CONFIGURATOR',
                  style:
                  Theme.of(dialogContext)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
                    fontWeight:
                    FontWeight.w700,
                    letterSpacing: 1.1,
                    color: Theme.of(
                      dialogContext,
                    )
                        .colorScheme
                        .primary,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  'Edit Configuration',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  Theme.of(dialogContext)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment:
                  WrapCrossAlignment
                      .center,
                  children: [
                    Text(
                      productName,
                      style: Theme.of(
                        dialogContext,
                      )
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration:
                      BoxDecoration(
                        color: Theme.of(
                          dialogContext,
                        )
                            .colorScheme
                            .primary
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
                        fullConfiguration
                            .productType,
                        style: Theme.of(
                          dialogContext,
                        )
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                          color: Theme.of(
                            dialogContext,
                          )
                              .colorScheme
                              .primary,
                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  'Update the submitted product configuration',
                  style:
                  Theme.of(dialogContext)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    color:
                    Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          TextButton.icon(
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              size: 19,
            ),
            label:
            const Text('Close'),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DELETE CONFIGURATION
  // =========================================================

  Future<void> _deleteConfiguration(
      AdminConfiguration configuration,
      ) async {
    final confirmed =
    await _confirmDelete(
      title:
      'Delete configuration?',
      message:
      '“${configuration.name}” will be permanently deleted.',
    );

    if (!confirmed || !mounted) {
      return;
    }

    setState(() {
      _deletingConfigurations.add(
        configuration.id,
      );
    });

    try {
      final response =
      await AdminRepository
          .deleteConfiguration(
        configurationID:
        configuration.id,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success) {
        _message(
          response.message ??
              'Unable to delete configuration.',
          error: true,
        );

        if (response.statusCode == 404) {
          await _loadConfigurations();
        }

        return;
      }

      setState(() {
        _configurations.removeWhere(
              (item) =>
          item.id ==
              configuration.id,
        );

        _recalculateSummary();
      });

      _message(
        'Configuration deleted.',
      );
    } catch (_) {
      _message(
        'Unable to delete configuration.',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _deletingConfigurations.remove(
            configuration.id,
          );
        });
      }
    }
  }

  // =========================================================
  // VIEW USER
  // =========================================================

  void _viewUser(
      AdminUser user,
      ) {
    showDialog<void>(
      context: context,
      builder: (_) =>
          UserDetailsDialog(
            user: user,
          ),
    );
  }

  // =========================================================
  // EDIT USER
  // =========================================================

  Future<void> _editUser(
      AdminUser user,
      ) async {
    final changes =
    await showDialog<
        Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          EditUserDialog(
            user: user,
            onResetPassword:
                (password) =>
                _resetUserPassword(
                  user,
                  password,
                ),
          ),
    );

    if (changes == null) {
      return;
    }

    try {
      final response =
      await AdminRepository.updateUser(
        userID: user.userID,
        changes: changes,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!response.success) {
        _message(
          response.message ??
              'Unable to update user.',
          error: true,
        );

        return;
      }

      await _loadUsers();

      if (!mounted) {
        return;
      }

      _message(
        'User updated.',
      );
    } catch (_) {
      _message(
        'Unable to update user.',
        error: true,
      );
    }
  }

  // =========================================================
  // RESET USER PASSWORD
  // =========================================================

  Future<String?> _resetUserPassword(
      AdminUser user,
      String password,
      ) async {
    try {
      final response =
      await AdminRepository
          .resetUserPassword(
        userID: user.userID,
        password: password,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return 'Authentication expired.';
      }

      if (!response.success) {
        return response.message ??
            'Unable to reset password.';
      }

      final prefs =
      await SharedPreferences
          .getInstance();

      final currentUsername = prefs
          .getString('username')
          ?.toLowerCase();

      final isSelf =
          currentUsername != null &&
              currentUsername ==
                  user.username
                      .toLowerCase();

      if (isSelf) {
        await prefs.remove(
          'sessionID',
        );

        await prefs.remove(
          'role',
        );

        await prefs.remove(
          'username',
        );

        if (mounted) {
          Navigator
              .pushNamedAndRemoveUntil(
            context,
            '/login',
                (_) => false,
          );
        }
      }

      return null;
    } catch (_) {
      return 'A server error occurred. Please try again.';
    }
  }

  // =========================================================
  // DELETE USER
  // =========================================================

  Future<void> _deleteUser(
      AdminUser user,
      ) async {
    final confirmed =
    await _confirmDelete(
      title: 'Delete user?',
      message:
      '“${user.name}” (${user.username}) will be permanently deleted.',
    );

    if (!confirmed || !mounted) {
      return;
    }

    setState(() {
      _deletingUsers.add(
        user.userID,
      );
    });

    try {
      final response =
      await AdminRepository.deleteUser(
        userID: user.userID,
      );

      if (await _handleAuthStatus(
        response.statusCode,
      )) {
        return;
      }

      if (!mounted) {
        return;
      }

      if (!response.success) {
        _message(
          response.message ??
              'Unable to delete user.',
          error: true,
        );

        if (response.statusCode == 404) {
          await _loadUsers();
        }

        return;
      }

      setState(() {
        _users.removeWhere(
              (item) =>
          item.userID ==
              user.userID,
        );
      });

      _message(
        'User deleted.',
      );
    } catch (_) {
      _message(
        'Unable to delete user.',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _deletingUsers.remove(
            user.userID,
          );
        });
      }
    }
  }

  // =========================================================
  // CONFIRM DELETE
  // =========================================================

  Future<bool> _confirmDelete({
    required String title,
    required String message,
  }) async {
    return await showDialog<bool>(
      context: context,
      builder: (
          dialogContext,
          ) {
        return AlertDialog(
          icon: const Icon(
            Icons
                .warning_amber_rounded,
            color: Colors.red,
            size: 42,
          ),
          title: Text(
            title,
            textAlign:
            TextAlign.center,
          ),
          content: Text(
            message,
            textAlign:
            TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton.icon(
              style:
              FilledButton
                  .styleFrom(
                backgroundColor:
                Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
              label: const Text(
                'Delete permanently',
              ),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _message(
      String message, {
        bool error = false,
      }) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error
            ? Colors.red.shade700
            : null,
      ),
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> _logout() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('sessionID');
    await prefs.remove('role');
    await prefs.remove('username');

    if (!mounted) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (_) => false,
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor:
            background,
            appBar: AppBar(
              toolbarHeight: 74,
              backgroundColor: navy,
              foregroundColor:
              Colors.white,
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/WhiteML_Logo-w-tag-vector.svg',
                    height: 48,
                    colorFilter:
                    const ColorFilter
                        .mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  if (MediaQuery.sizeOf(
                    context,
                  ).width >=
                      620)
                    const Text(
                      'Admin dashboard',
                      style: TextStyle(
                        color:
                        Colors.white,
                        fontSize: 22,
                        fontWeight:
                        FontWeight
                            .w800,
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: 'Refresh',
                  onPressed: () {
                    final index =
                        DefaultTabController
                            .of(context)
                            .index;

                    if (index == 0) {
                      _loadConfigurations();
                    } else {
                      _loadUsers();
                    }
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),

                IconButton(
                  tooltip:
                  'User dashboard',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/dashboard',
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                  ),
                ),

                IconButton(
                  tooltip: 'Logout',
                  onPressed: _logout,
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),

                const SizedBox(
                  width: 8,
                ),
              ],
              bottom:
              const TabBar(
                indicatorColor:
                Colors.white,
                labelColor:
                Colors.white,
                unselectedLabelColor:
                Colors.white70,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.tune,
                    ),
                    text:
                    'Configurations',
                  ),
                  Tab(
                    icon: Icon(
                      Icons
                          .people_outline,
                    ),
                    text: 'Users',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _configurationsTab(),
                _usersTab(),
              ],
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // CONFIGURATIONS TAB
  // =========================================================

  Widget _configurationsTab() {
    if (_loadingConfigurations) {
      return const Center(
        child:
        CircularProgressIndicator(),
      );
    }

    if (_configurationError != null) {
      return _ErrorView(
        message:
        _configurationError!,
        onRetry:
        _loadConfigurations,
      );
    }

    final compact =
    _isCompactLayout();

    return RefreshIndicator(
      onRefresh:
      _loadConfigurations,
      child: ListView(
        physics:
        const AlwaysScrollableScrollPhysics(),
        padding: _pagePadding(),
        children: [
          AdminFilterBar(
            filters:
            _configurationFilters,
            onChanged:
            _setConfigurationFilters,
            showStatusFilter: true,
            people:
            _configurationPeople,
            selectedUserID:
            _selectedConfigurationUserID,
            onPersonChanged: (userID) {
              setState(() {
                _selectedConfigurationUserID =
                    userID;
              });
            },
            groupByStatus:
            _groupConfigurationsByStatus,
            onGroupByStatusChanged:
            _setGroupConfigurationsByStatus,
          ),

          const SizedBox(
            height: 18,
          ),

          AdminSummaryCards(
            summary: _summary,
          ),

          const SizedBox(
            height: 22,
          ),

          ConfigurationList(
            items:
            _visibleConfigurations,
            users: _users,
            compact: compact,
            groupByStatus:
            _groupConfigurationsByStatus,
            updatingConfigurationIDs:
            _updatingConfigurations,
            deletingConfigurationIDs:
            _deletingConfigurations,
            imageCountFor:
            ConfigurationImageGallery
                .imageCount,
            onStatusChanged:
            _changeStatus,
            onViewConfiguration:
            _viewConfiguration,
            onViewImages:
            _showConfigurationImages,
            onEditConfiguration:
            _editConfiguration,
            onDeleteConfiguration:
            _deleteConfiguration,
            onViewUser:
            _viewUser,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // USERS TAB
  // =========================================================

  Widget _usersTab() {
    if (_loadingUsers) {
      return const Center(
        child:
        CircularProgressIndicator(),
      );
    }

    if (_userError != null) {
      return _ErrorView(
        message: _userError!,
        onRetry: _loadUsers,
      );
    }

    final compact =
    _isCompactLayout();

    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: ListView(
        physics:
        const AlwaysScrollableScrollPhysics(),
        padding: _pagePadding(),
        children: [
          AdminFilterBar(
            filters: _userFilters,
            onChanged:
            _setUserFilters,
          ),

          const SizedBox(
            height: 18,
          ),

          if (compact)
            UserCards(
              users: _users,
              roles: roles,
              updatingUserIDs:
              _updatingUsers,
              deletingUserIDs:
              _deletingUsers,
              onRoleChanged:
              _changeRole,
              onView: _viewUser,
              onEdit: _editUser,
              onDelete:
              _deleteUser,
            )
          else
            UserTable(
              users: _users,
              roles: roles,
              updatingUserIDs:
              _updatingUsers,
              deletingUserIDs:
              _deletingUsers,
              onRoleChanged:
              _changeRole,
              onView: _viewUser,
              onEdit: _editUser,
              onDelete:
              _deleteUser,
            ),
        ],),
    );
  }

  // =========================================================
  // CONFIGURATION IMAGES
  // =========================================================

  void _showConfigurationImages(
      AdminConfiguration configuration,
      ) {
    ConfigurationImageGallery.show(
      context,
      configuration,
    );
  }

  // =========================================================
  // RESPONSIVE HELPERS
  // =========================================================

  EdgeInsets _pagePadding() {
    return EdgeInsets.all(
      MediaQuery.sizeOf(context).width <
          700
          ? 12
          : 24,
    );
  }

  bool _isCompactLayout() {
    return MediaQuery.sizeOf(
      context,
    ).width <
        760;
  }
}

// ===========================================================
// ERROR VIEW
// ===========================================================

class _ErrorView
    extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;

  final VoidCallback onRetry;

  @override
  Widget build(
      BuildContext context,
      ) {
    return Center(
      child: Column(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),

          const SizedBox(
            height: 12,
          ),

          Padding(
            padding:
            const EdgeInsets
                .symmetric(
              horizontal: 24,
            ),
            child: Text(
              message,
              textAlign:
              TextAlign.center,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(
              Icons.refresh,
            ),
            label:
            const Text(
              'Try again',
            ),
          ),
        ],
      ),
    );
  }
}