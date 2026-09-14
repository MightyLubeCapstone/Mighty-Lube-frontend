import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../features/auth/repositories/user_repository.dart';

class AppEntryRouter extends StatefulWidget {
  const AppEntryRouter({super.key});

  @override
  State<AppEntryRouter> createState() => _AppEntryRouterState();
}

class _AppEntryRouterState extends State<AppEntryRouter> {
  @override
  void initState() {
    super.initState();
    _resolveDestination();
  }

  Future<void> _resolveDestination() async {
    try {
      final sessionResponse = await UserRepository.checkSession();

      if (!mounted) {
        return;
      }

      final isSessionValid =
          sessionResponse.success &&
              sessionResponse.data == true;

      if (!isSessionValid) {
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );

        return;
      }

      final isAdmin =
      await UserRepository.isCurrentUserAdmin();

      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        isAdmin
            ? '/admin'
            : '/dashboard',
      );
    } catch (error) {
      if (kDebugMode) {
        print(
          'AppEntryRouter error: $error',
        );
      }

      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        '/login',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}