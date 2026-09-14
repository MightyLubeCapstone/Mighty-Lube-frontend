import 'package:flutter/material.dart';

import '../../features/auth/repositories/user_repository.dart';
import '../../features/auth/screen/login_page.dart';

import 'header_logo.dart';

// dashboard pages
import '../../features/configurations/screens/configurations.dart';
import '../../features/cart/screens/drafts.dart';
import '../../features/profile/screens/profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool loading = false;

  Future<void> logoutUser() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete != true) {
      return;
    }

    setState(() {
      loading = true;
    });

    final response = await UserRepository.logout();

    if (!mounted) {
      return;
    }

    setState(() {
      loading = false;
    });

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF579AF6),
            ),
            child: HeaderLogo(
              pressable: false,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfigurationsPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.drafts),
            title: const Text('Drafts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DraftsPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),

          ListTile(
            leading: loading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator.adaptive(),
            )
                : const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: loading
                ? null
                : () {
              logoutUser();
            },
          ),
        ],
      ),
    );
  }
}