import 'package:flutter/material.dart';

import '../../features/auth/repositories/user_repository.dart';
import '../../features/auth/screen/login_page.dart';

// =========================================================
// LOGOUT
//
// Shared by the drawer and the top bar: asks to confirm,
// logs out, then clears the stack and opens Login.
//
// onLoading lets the caller show a spinner while the
// logout request runs.
// =========================================================

Future<void> confirmAndLogout(
    BuildContext context, {
      ValueChanged<bool>? onLoading,
    }) async {
  final bool? confirmLogout = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Confirm logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(false),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(true),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );

  if (confirmLogout != true || !context.mounted) {
    return;
  }

  onLoading?.call(true);

  final response = await UserRepository.logout();

  if (!context.mounted) {
    return;
  }

  onLoading?.call(false);

  if (response.success && response.data == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out!'),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
          (route) => false,
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message ?? 'Error when logging out!',
        ),
      ),
    );
  }
}
