import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:mighty_lube/features/configurations/screens/configurations.dart';
import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/login_page.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';
import '../../cart/repositories/cart_repositories.dart';
import '../../profile/screens/profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool loading = false;

  String name = 'error';

  int totalQuantities = 0;

  Future<void> getOrders() async {
    try {
      setState(() {
        loading = true;
      });

      final response = await CartRepository.getOrders();

      if (!mounted) {
        return;
      }

      if (!response.success || response.data == null) {
        setState(() {
          loading = false;
        });

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

        loading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getName();

    getOrders();
  }

  Future<void> logoutUser() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm logout',
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(
                context,
              ).pop(
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
              onPressed: () => Navigator.of(
                context,
              ).pop(
                true,
              ),
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
          content: Text(
            'Successfully logged out!',
          ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
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

  Future<String> getName() async {
    try {
      setState(() {
        loading = true;
      });

      final response = await UserRepository.getUserInfo();

      if (!mounted) {
        return 'Error fetching name';
      }

      setState(() {
        loading = false;
      });

      if (response.success && response.data != null) {
        final data = response.data!;

        final username = data['username']?.toString();

        if (username != null && username.trim().isNotEmpty) {
          setState(() {
            name = username;
          });

          return name;
        }
      }

      return name;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (mounted) {
        setState(() {
          loading = false;
        });
      }

      return 'Error fetching name';
    }
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
      body: loading == true
          ? const Center(
        child: CircularProgressIndicator.adaptive(),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    'Hello $name, ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '(not $name? )',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      '(Log out)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      logoutUser();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text.rich(
              TextSpan(
                text: 'From your account dashboard you can view your ',
                style: const TextStyle(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: 'recent configurations',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfigurationsPage(),
                          ),
                        );
                      },
                  ),
                  const TextSpan(
                    text: ', manage your ',
                  ),

                  // LEAVE THIS SPACING ALONE!!
                  // I FOUND A SPECIAL LEVEL UP PAGE THAT I'M NOT GONNA TOUCH RN
                  // ANTHONY DIDN"T SAY ANYTHING ABOUT THIS SO MAYBE IT'S NOT SUPPOSED TO BE HERE?
                  TextSpan(
                    text: 'billing address',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (kDebugMode) {
                          print(
                            'Navigate to billing address',
                          );
                        }
                      },
                  ),

                  const TextSpan(
                    text: ', and ',
                  ),
                  TextSpan(
                    text: 'edit your password and account details.',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}