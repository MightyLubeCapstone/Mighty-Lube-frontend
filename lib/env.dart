import 'package:flutter/material.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SessionObserver extends NavigatorObserver {
  final Future<bool> Function() checkSession;

  SessionObserver({required this.checkSession});

  @override
  void didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);

    bool isValid = await checkSession();
    if (!isValid) {
      navigatorKey.currentState?.pushReplacementNamed('/login');
    }
  }
}



String get baseUrl {
  //return 'https://mighty-lube-backend.azurewebsites.net';
  return 'http://10.0.2.2:8000';
}
