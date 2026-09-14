import 'package:flutter/material.dart';

import '../../features/auth/repositories/user_repository.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SessionObserver extends NavigatorObserver {
  SessionObserver();

  @override
  void didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);

    if (previousRoute != null) {
      if (previousRoute.settings.name == '/create_account' ||
          previousRoute.settings.name == '/login') {
        return;
      }
    }

    if (route.settings.name == '/create_account' ||
        route.settings.name == '/forgot_password') {
      return;
    }

    final response = await UserRepository.checkSession();

    final isValid = response.success && response.data == true;

    if (!isValid) {
      if (navigatorKey.currentContext != null &&
          previousRoute?.settings.name != '/login') {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(
          const SnackBar(
            content: Text(
              'Your session has expired, please login again!',
            ),
          ),
        );
      }

      navigatorKey.currentState?.pushReplacementNamed('/login');
    }
  }
}