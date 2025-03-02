import 'package:flutter/material.dart';
import 'package:mighty_lube/LoginPage/API/apicalls.dart';
import 'package:mighty_lube/header_logo.dart' as logo;

import 'dashboard/UI/configurations.dart';
import 'dashboard/UI/drafts.dart';
import 'dashboard/UI/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
            child: logo.HeaderLogo(),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfigurationsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.drafts),
            title: const Text('Drafts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DraftsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account Details'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              ApiState().logoutUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
