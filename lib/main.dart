// just flutter pages
import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/env.dart';

// login in pages
import 'LoginPage/UI/create_account.dart';
import 'LoginPage/UI/forgot_password.dart';
import 'LoginPage/UI/login_page.dart';
import 'package:mighty_lube/LoginPage/UI/home.dart';
import 'package:mighty_lube/LoginPage/UI/enter_otp.dart';

// dashboard pages
import 'dashboard/UI/dashboard.dart';
import 'dashboard/UI/configurations.dart';
import 'dashboard/UI/drafts.dart';
import 'dashboard/UI/profile.dart';

// protien pages
import 'protien/FGLM/UI/FGLM.dart';
import 'protien/FGCO/UI/FGCO.dart';
import 'protien/protein_home.dart';

// application pages
import 'application/UI/application_home.dart';

// industrial pages
import 'industrial_home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      // this checks the session any time that the navigator is used (aka all the time pretty much)
      navigatorObservers: [
        SessionObserver(checkSession: UserAPI().checkSession)
      ],
      // Set the initial route to any of the pages by changing the value here
      initialRoute:
          '/', // Change this to '/createAccount', '/forgotPassword', or '/dashboard' to start at a different page

      routes: {
        // login pages
        '/': (context) => const Home(),
        '/login': (context) => const LoginPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),

        // dashboard pages
        '/dashboard': (context) => const DashboardPage(),
        '/configurations': (context) => ConfigurationsPage(),
        '/drafts': (context) => DraftsPage(),
        '/profile': (context) => const ProfilePage(),

        // protien pages
        '/protein_home': (context) => const ProteinHome(),
        '/FGLM': (context) => const FGLMPage(),
        '/FGCO': (context) => const FGCOPage(),

        // application pages
        '/application': (context) => const ApplicationPage(),

        //industrial page
        '/industrial': (context) => const IndustrialHome(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
