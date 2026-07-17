import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SessionObserver extends NavigatorObserver {
  final Future<bool> Function() checkSession;

  SessionObserver({required this.checkSession});

  @override
  void didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      if (previousRoute.settings.name == "/create_account" ||
          previousRoute.settings.name == "/login") {
        return;
      }
    }
    if (route.settings.name == "/create_account" ||
        route.settings.name == "/forgot_password") {
      return;
    }

    bool isValid = await checkSession();
    if (!isValid) {
      if (navigatorKey.currentContext != null &&
          previousRoute?.settings.name != "/login") {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
              content: Text('Your session has expired, please login again!')),
        );
      }
      navigatorKey.currentState?.pushReplacementNamed('/login');
    }
  }
}

String get baseUrl {
  return const String.fromEnvironment(
    'API_HOST',
    defaultValue: 'http://localhost:8080',
  );
}

/// API root used by the role-based admin endpoints.
/// Production builds can use:
/// `--dart-define=API_HOST=https://configurator-67eol.sevalla.app`
String get apiBaseUrl => '$baseUrl/api';
