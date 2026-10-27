import 'package:flutter/material.dart';

import 'header_logo.dart';
import 'logout_action.dart';

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

  Future<void> logoutUser() {
    return confirmAndLogout(
      context,
      onLoading: (value) {
        if (mounted) {
          setState(() {
            loading = value;
          });
        }
      },
    );
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