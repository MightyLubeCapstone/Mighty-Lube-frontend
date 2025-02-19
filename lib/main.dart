// just flutter pages
import 'package:flutter/material.dart';
import 'package:mighty_lube/shoppingCart.dart';

// login in pages
import 'LoginPage/UI/createAccount.dart';
import 'LoginPage/UI/forgotPassword.dart';
import 'LoginPage/UI/loginPage.dart';

// dashboard pages
import 'dashboard/UI/dashboard.dart';
import 'dashboard/UI/configurations.dart';
import 'dashboard/UI/drafts.dart';
import 'dashboard/UI/profile.dart';

// protien pages
import 'protien/FGLM/UI/FGLM.dart';
import 'protien/FGCO/UI/FGCO.dart';
import 'protien/protienHome.dart';

// application pages
import 'application/UI/applicationHome.dart';

// industrial pages
import 'industrialHome.dart';


// api imports

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
          '/shopping', // Change this to '/createAccount', '/forgotPassword', or '/dashboard' to start at a different page

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
        '/protienHome': (context) => const ProteinHome(),
        '/FGLM': (context) => const FGLMPage(),
        '/FGCO': (context) => const FGCOPage(),

        // application pages
        '/application': (context) => const ApplicationPage(),

        //industrial page
        '/industrial': (context) => const IndustrialHome(),

        '/shopping': (context) => ShoppingPage(cartItems: myCartItems, showAlternativeUI: true),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}


