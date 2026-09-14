// import 'package:flutter/material.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// class SessionObserver extends NavigatorObserver {
//   final Future<bool> Function() checkSession;
//
//   SessionObserver({required this.checkSession});
//
//   @override
//   void didPush(Route route, Route? previousRoute) async {
//     super.didPush(route, previousRoute);
//     if (previousRoute != null) {
//       if (previousRoute.settings.name == "/create_account" ||
//           previousRoute.settings.name == "/login") {
//         return;
//       }
//     }
//     if (route.settings.name == "/create_account" ||
//         route.settings.name == "/forgot_password") {
//       return;
//     }
//
//     bool isValid = await checkSession();
//     if (!isValid) {
//       if (navigatorKey.currentContext != null &&
//           previousRoute?.settings.name != "/login") {
//         ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
//           const SnackBar(
//               content: Text('Your session has expired, please login again!')),
//         );
//       }
//       navigatorKey.currentState?.pushReplacementNamed('/login');
//     }
//   }
// }
//
// // const String localBaseUrl = 'http://localhost:8080';
// // const String productionBaseUrl = 'https://configurator-67eol.sevalla.app';
//
// // String get baseUrl {
// //   return String.fromEnvironment(
// //     'API_HOST',
// //     // defaultValue: kReleaseMode ? productionBaseUrl : localBaseUrl,
// //     defaultValue: ApiEndpoints.apiBaseUrl,
// //   );
// // }
//
// /// API root used by the role-based admin endpoints.
// /// Release builds use [productionBaseUrl] by default.
// /// Any build can override the host with `--dart-define=API_HOST=...`.
// // String get apiBaseUrl => '$baseUrl/api';
