import 'package:flutter/material.dart';

import '../../models/admin_models.dart';

// ===========================================================
// USER DETAILS DIALOG
// ===========================================================

class UserDetailsDialog extends StatelessWidget {
  const UserDetailsDialog({
    super.key,
    required this.user,
  });

  final AdminUser user;

  @override
  Widget build(BuildContext context) {
    return _AdminDetailsDialog(
      icon: Icons.manage_accounts_outlined,
      title: user.name,
      subtitle: 'User information and account role.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _EditorSectionTitle(
            icon: Icons.badge_outlined,
            title: 'User information',
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (
                context,
                constraints,
                ) {
              final width = _compactFieldWidth(
                constraints.maxWidth,
              );

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _detailField(
                    'First name',
                    user.firstName,
                    Icons.person_outline,
                    width,
                  ),
                  _detailField(
                    'Last name',
                    user.lastName,
                    Icons.person_outline,
                    width,
                  ),
                  _detailField(
                    'Username',
                    user.username,
                    Icons.alternate_email,
                    width,
                  ),
                  _detailField(
                    'Email',
                    user.email,
                    Icons.email_outlined,
                    width,
                  ),
                  _detailField(
                    'Phone',
                    user.phone,
                    Icons.phone_outlined,
                    width,
                  ),
                  _detailField(
                    'Company',
                    user.company,
                    Icons.business_outlined,
                    width,
                  ),
                  _detailField(
                    'Country',
                    user.country,
                    Icons.public,
                    width,
                  ),
                  _detailField(
                    'Created',
                    _friendlyDate(
                      user.createdAt,
                    ),
                    Icons.add_circle_outline,
                    width,
                  ),
                  _detailField(
                    'Updated',
                    _friendlyDate(
                      user.updatedAt,
                    ),
                    Icons.update,
                    width,
                  ),
                  _detailField(
                    'Role',
                    _titleCase(
                      user.role,
                    ),
                    Icons.admin_panel_settings_outlined,
                    width,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// EDIT USER DIALOG
// ===========================================================

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({
    super.key,
    required this.user,
    required this.onResetPassword,
  });

  final AdminUser user;

  final Future<String?> Function(
      String password,
      ) onResetPassword;

  @override
  State<EditUserDialog> createState() =>
      _EditUserDialogState();
}

class _EditUserDialogState
    extends State<EditUserDialog> {
  final _formKey =
  GlobalKey<FormState>();

  final _passwordFormKey =
  GlobalKey<FormState>();

  late final Map<
      String,
      TextEditingController> _fields;

  final _password =
  TextEditingController();

  final _confirmPassword =
  TextEditingController();

  bool _passwordHidden = true;

  bool _confirmPasswordHidden = true;

  bool _resettingPassword = false;

  String? _passwordMessage;

  bool _passwordError = false;

  @override
  void initState() {
    super.initState();

    _fields = {
      'firstName':
      TextEditingController(
        text: widget.user.firstName,
      ),
      'lastName':
      TextEditingController(
        text: widget.user.lastName,
      ),
      'username':
      TextEditingController(
        text: widget.user.username,
      ),
      'email':
      TextEditingController(
        text: widget.user.email,
      ),
      'phoneNumber':
      TextEditingController(
        text: widget.user.phone,
      ),
      'companyName':
      TextEditingController(
        text: widget.user.company,
      ),
      'country':
      TextEditingController(
        text: widget.user.country,
      ),
    };
  }

  @override
  void dispose() {
    for (final controller
    in _fields.values) {
      controller.dispose();
    }

    _password.dispose();

    _confirmPassword.dispose();

    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    Navigator.pop(
      context,
      _fields.map(
            (
            key,
            value,
            ) =>
            MapEntry(
              key,
              value.text.trim(),
            ),
      ),
    );
  }

  Future<void>
  _resetPassword() async {
    if (!_passwordFormKey
        .currentState!
        .validate()) {
      return;
    }

    setState(() {
      _resettingPassword = true;
      _passwordMessage = null;
      _passwordError = false;
    });

    final error =
    await widget.onResetPassword(
      _password.text,
    );

    if (!mounted) {
      return;
    }

    if (error != null) {
      setState(() {
        _resettingPassword = false;
        _passwordError = true;
        _passwordMessage = error;
      });

      return;
    }

    setState(() {
      _resettingPassword = false;

      _password.clear();

      _confirmPassword.clear();

      _passwordMessage =
      'Password reset successfully. Existing sessions were signed out.';

      _passwordError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AdminEditDialog(
      icon: Icons.manage_accounts_outlined,
      title: 'Edit user',
      subtitle:
      'Manage profile information and account security.',
      onSave: _save,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const _EditorSectionTitle(
              icon: Icons.badge_outlined,
              title: 'User information',
            ),

            const SizedBox(
              height: 6,
            ),

            const Text(
              'Update this user’s personal, contact, and company details.',
              style: TextStyle(
                color:
                Color(0xFF64748B),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            LayoutBuilder(
              builder: (
                  context,
                  constraints,
                  ) {
                final fieldWidth =
                _compactFieldWidth(
                  constraints.maxWidth,
                );

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _userField(
                      'firstName',
                      'First name',
                      Icons.person_outline,
                      fieldWidth,
                      required: true,
                    ),
                    _userField(
                      'lastName',
                      'Last name',
                      Icons.person_outline,
                      fieldWidth,
                      required: true,
                    ),
                    _userField(
                      'username',
                      'Username',
                      Icons.alternate_email,
                      fieldWidth,
                      required: true,
                    ),
                    _userField(
                      'email',
                      'Email',
                      Icons.email_outlined,
                      fieldWidth,
                      required: true,
                    ),
                    _userField(
                      'phoneNumber',
                      'Phone',
                      Icons.phone_outlined,
                      fieldWidth,
                    ),
                    _userField(
                      'companyName',
                      'Company',
                      Icons.business_outlined,
                      fieldWidth,
                    ),
                    _userField(
                      'country',
                      'Country',
                      Icons.public,
                      fieldWidth,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(
              height: 28,
            ),

            const Divider(),

            const SizedBox(
              height: 18,
            ),

            _passwordSection(),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PASSWORD RESET
  // =========================================================

  Widget _passwordSection() {
    return Form(
      key: _passwordFormKey,
      child: Container(
        padding:
        const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:
          const Color(0xFFFFFBEB),
          borderRadius:
          BorderRadius.circular(14),
          border: Border.all(
            color:
            const Color(0xFFFDE68A),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const _EditorSectionTitle(
              icon:
              Icons.password_outlined,
              title: 'Reset password',
            ),

            const SizedBox(
              height: 6,
            ),

            const Text(
              'No old password or security PIN is required. All existing sessions for this user will be signed out.',
              style: TextStyle(
                color:
                Color(0xFF78716C),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextFormField(
              controller: _password,
              obscureText:
              _passwordHidden,
              decoration:
              InputDecoration(
                labelText:
                'New password',
                prefixIcon:
                const Icon(
                  Icons.lock_outline,
                ),
                border:
                const OutlineInputBorder(),
                filled: true,
                fillColor:
                Colors.white,
                suffixIcon:
                IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordHidden =
                      !_passwordHidden;
                    });
                  },
                  icon: Icon(
                    _passwordHidden
                        ? Icons
                        .visibility_outlined
                        : Icons
                        .visibility_off_outlined,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.length < 8) {
                  return 'Password must contain at least 8 characters.';
                }

                return null;
              },
            ),

            const SizedBox(
              height: 14,
            ),

            TextFormField(
              controller:
              _confirmPassword,
              obscureText:
              _confirmPasswordHidden,
              decoration:
              InputDecoration(
                labelText:
                'Confirm new password',
                prefixIcon:
                const Icon(
                  Icons
                      .lock_reset_outlined,
                ),
                border:
                const OutlineInputBorder(),
                filled: true,
                fillColor:
                Colors.white,
                suffixIcon:
                IconButton(
                  onPressed: () {
                    setState(() {
                      _confirmPasswordHidden =
                      !_confirmPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _confirmPasswordHidden
                        ? Icons
                        .visibility_outlined
                        : Icons
                        .visibility_off_outlined,
                  ),
                ),
              ),
              validator: (value) {
                if (value !=
                    _password.text) {
                  return 'Passwords do not match.';
                }

                return null;
              },
            ),

            if (_passwordMessage !=
                null) ...[
              const SizedBox(
                height: 12,
              ),

              Row(
                children: [
                  Icon(
                    _passwordError
                        ? Icons
                        .error_outline
                        : Icons
                        .check_circle,
                    size: 20,
                    color:
                    _passwordError
                        ? Colors.red
                        : Colors.green,
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      _passwordMessage!,
                      style: TextStyle(
                        color:
                        _passwordError
                            ? Colors
                            .red
                            .shade700
                            : Colors
                            .green
                            .shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(
              height: 16,
            ),

            Align(
              alignment:
              Alignment.centerRight,
              child:
              FilledButton.icon(
                style:
                FilledButton.styleFrom(
                  backgroundColor:
                  const Color(
                    0xFFB45309,
                  ),
                ),
                onPressed:
                _resettingPassword
                    ? null
                    : _resetPassword,
                icon:
                _resettingPassword
                    ? const SizedBox
                    .square(
                  dimension:
                  16,
                  child:
                  CircularProgressIndicator(
                    strokeWidth:
                    2,
                  ),
                )
                    : const Icon(
                  Icons
                      .lock_reset,
                ),
                label: Text(
                  _resettingPassword
                      ? 'Resetting password…'
                      : 'Update password',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // USER FIELD
  // =========================================================

  Widget _userField(
      String key,
      String label,
      IconData icon,
      double width, {
        bool required = false,
      }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: _fields[key],
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border:
          const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
          if (value == null ||
              value
                  .trim()
                  .isEmpty) {
            return '$label is required.';
          }

          return null;
        }
            : null,
      ),
    );
  }
}

// ===========================================================
// DETAILS DIALOG SHELL
// ===========================================================

class _AdminDetailsDialog
    extends StatelessWidget {
  const _AdminDetailsDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;

  final String title;

  final String subtitle;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen =
    MediaQuery.sizeOf(context);

    final compact =
        screen.width < 560;

    return Dialog(
      insetPadding: EdgeInsets.all(
        compact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height -
              (compact ? 24 : 48),
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            Container(
              padding:
              EdgeInsets.fromLTRB(
                compact ? 16 : 24,
                compact ? 16 : 20,
                8,
                compact ? 14 : 18,
              ),
              decoration:
              const BoxDecoration(
                color:
                Color(0xFFF1F5FF),
                borderRadius:
                BorderRadius.vertical(
                  top:
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  if (!compact) ...[
                    CircleAvatar(
                      backgroundColor:
                      const Color(
                        0xFF2563EB,
                      ),
                      foregroundColor:
                      Colors.white,
                      child: Icon(icon),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                  ],

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          TextStyle(
                            fontSize:
                            compact
                                ? 18
                                : 21,
                            fontWeight:
                            FontWeight
                                .w800,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          subtitle,
                          style:
                          const TextStyle(
                            color:
                            Color(
                              0xFF64748B,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () =>
                        Navigator.pop(
                          context,
                        ),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child:
              SingleChildScrollView(
                padding:
                EdgeInsets.all(
                  compact ? 14 : 24,
                ),
                child: child,
              ),
            ),

            const Divider(
              height: 1,
            ),

            Padding(
              padding:
              EdgeInsets.all(
                compact ? 12 : 16,
              ),
              child: Align(
                alignment:
                Alignment.centerRight,
                child:
                FilledButton.icon(
                  onPressed: () =>
                      Navigator.pop(
                        context,
                      ),
                  icon: const Icon(
                    Icons.check,
                  ),
                  label:
                  const Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// EDIT DIALOG SHELL
// ===========================================================

class _AdminEditDialog
    extends StatelessWidget {
  const _AdminEditDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onSave,
    required this.child,
  });

  final IconData icon;

  final String title;

  final String subtitle;

  final VoidCallback onSave;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen =
    MediaQuery.sizeOf(context);

    final compact =
        screen.width < 560;

    return Dialog(
      insetPadding: EdgeInsets.all(
        compact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height -
              (compact ? 24 : 48),
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            Container(
              padding:
              EdgeInsets.fromLTRB(
                compact ? 16 : 24,
                compact ? 16 : 20,
                8,
                compact ? 14 : 18,
              ),
              decoration:
              const BoxDecoration(
                color:
                Color(0xFFF1F5FF),
                borderRadius:
                BorderRadius.vertical(
                  top:
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  if (!compact) ...[
                    CircleAvatar(
                      backgroundColor:
                      const Color(
                        0xFF2563EB,
                      ),
                      foregroundColor:
                      Colors.white,
                      child: Icon(icon),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                  ],

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          TextStyle(
                            fontSize:
                            compact
                                ? 18
                                : 21,
                            fontWeight:
                            FontWeight
                                .w800,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          subtitle,
                          style:
                          const TextStyle(
                            color:
                            Color(
                              0xFF64748B,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () =>
                        Navigator.pop(
                          context,
                        ),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child:
              SingleChildScrollView(
                padding:
                EdgeInsets.all(
                  compact ? 14 : 24,
                ),
                child: child,
              ),
            ),

            const Divider(
              height: 1,
            ),

            Padding(
              padding:
              EdgeInsets.all(
                compact ? 12 : 16,
              ),
              child: Wrap(
                alignment:
                WrapAlignment.end,
                spacing: 10,
                runSpacing: 8,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(
                          context,
                        ),
                    child: const Text(
                      'Cancel',
                    ),
                  ),

                  FilledButton.icon(
                    onPressed: onSave,
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    label: const Text(
                      'Save changes',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// COMMON USER DIALOG WIDGETS
// ===========================================================

class _EditorSectionTitle
    extends StatelessWidget {
  const _EditorSectionTitle({
    required this.icon,
    required this.title,
  });

  final IconData icon;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color:
          const Color(0xFF2563EB),
        ),

        const SizedBox(
          width: 8,
        ),

        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight:
            FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

Widget _detailField(
    String label,
    dynamic value,
    IconData icon,
    double width,
    ) {
  return SizedBox(
    width: width,
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border:
        const OutlineInputBorder(),
      ),
      child: SelectableText(
        value?.toString().isEmpty ??
            true
            ? '—'
            : value.toString(),
        maxLines: 3,
      ),
    ),
  );
}

// ===========================================================
// HELPERS
// ===========================================================

double _compactFieldWidth(
    double maxWidth,
    ) {
  if (maxWidth < 520) {
    return maxWidth;
  }

  return ((maxWidth - 24) / 3)
      .clamp(
    190.0,
    240.0,
  );
}

String _titleCase(
    String value,
    ) {
  if (value.trim().isEmpty) {
    return value;
  }

  return value
      .split(' ')
      .where(
        (part) => part.isNotEmpty,
  )
      .map(
        (part) =>
    '${part[0].toUpperCase()}'
        '${part.substring(1).toLowerCase()}',
  )
      .join(' ');
}

String _friendlyDate(
    dynamic raw,
    ) {
  if (raw == null) {
    return '—';
  }

  final date = raw is DateTime
      ? raw
      : DateTime.tryParse(
    raw.toString(),
  );

  if (date == null) {
    return '—';
  }

  final local = date.toLocal();

  String twoDigits(int value) {
    return value
        .toString()
        .padLeft(2, '0');
  }

  return '${twoDigits(local.month)}/'
      '${twoDigits(local.day)}/'
      '${local.year} '
      '${twoDigits(local.hour)}:'
      '${twoDigits(local.minute)}';
}