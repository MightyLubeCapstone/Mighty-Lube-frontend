// just flutter pages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// login in pages
import 'loginPage/UI/createAccount.dart';
import 'loginPage/UI/forgotPassword.dart';
import 'loginPage/UI/loginPage.dart';

// dashboard pages
import 'dashboard/UI/dashboard.dart';
import 'dashboard/UI/configurations.dart';
import 'dashboard/UI/drafts.dart';
import 'dashboard/UI/profile.dart';

// protien pages
import 'protien/FGLM/UI/FGLM.dart';
import 'protien/FGCO/UI/FGCO.dart';

// application pages
import 'application/UI/applicationHome.dart';

// api imports
import 'loginPage/API/app_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the initial route to any of the pages by changing the value here
      initialRoute:
          '/dashboard', // Change this to '/createAccount', '/forgotPassword', or '/dashboard' to start at a different page

      routes: {
        // login pages
        '/login': (context) => const LoginPage(),
        '/createAccount': (context) => const CreateAccountPage(),
        '/forgotPassword': (context) => const ForgotPasswordPage(),

        // dashboard pages
        '/dashboard': (context) => const DashboardPage(),
        '/configurations': (context) => const ConfigurationsPage(),
        '/drafts': (context) => const DraftsPage(),
        '/profile': (context) => const ProfilePage(),

        // protien pages
        '/FGLM': (context) => const FGLMPage(),
        '/FGCO': (context) => const FGCOPage(),

        // application pages
        '/application': (context) => const ApplicationPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
