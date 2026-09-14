// // just flutter pages
// import 'package:flutter/material.dart';
// import 'package:mighty_lube/api.dart';
// import 'package:mighty_lube/env.dart';
//
// // login in pages
// import 'features/auth/screen/create_account.dart';
// import 'features/auth/screen/forgot_password.dart';
// import 'features/auth/screen/login_page.dart';
// import 'package:mighty_lube/LoginPage/UI/home.dart';
//
// // dashboard pages
// import 'dashboard/UI/dashboard.dart';
// import 'dashboard/UI/configurations.dart';
// import 'dashboard/UI/drafts.dart';
// import 'dashboard/UI/profile.dart';
//
// // protien pages
// import 'protien/FGLM/UI/FGLM.dart';
// import 'protien/FGCO/UI/FGCO.dart';
// import 'protien/protein_home.dart';
//
// // application pages
// import 'application/UI/applicationHome.dart';
//
// // industrial pages
// import 'industrial_home.dart';
// import 'admin/UI/admin_dashboard.dart';
//
// void main() {
//   runApp(const MainApp());
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       // this checks the session any time that the navigator is used (aka all the time pretty much)
//       navigatorObservers: [SessionObserver(checkSession: UserAPI().checkSession)],
//       // Set the initial route to any of the pages by changing the value here
//       initialRoute: '/', // Change this to '/createAccount', '/forgotPassword', or '/dashboard' to start at a different page
//
//       routes: {
//         // login pages
//         '/': (context) => const Home(),
//         '/login': (context) => const LoginPage(),
//         '/create_account': (context) => const CreateAccountPage(),
//         '/forgot_password': (context) => const ForgotPasswordPage(),
//
//         // dashboard pages
//         '/dashboard': (context) => const DashboardPage(),
//         '/configurations': (context) => ConfigurationsPage(),
//         '/drafts': (context) => DraftsPage(),
//         '/profile': (context) => const ProfilePage(),
//         '/admin': (context) => const AdminDashboardPage(),
//
//         // protien pages
//         '/protein_home': (context) => const ProteinHome(),
//         '/FGLM': (context) => const FGLMPage(),
//         '/FGCO': (context) => const FGCOPage(),
//
//         // application pages
//         '/application': (context) => const ApplicationPage(),
//
//         //industrial page
//         '/industrial': (context) => const IndustrialHome(),
//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }



// just flutter pages
import 'package:flutter/material.dart';

// core
import 'core/navigation/app_entry_router.dart';
import 'core/navigation/sessionObserver.dart';

// login pages
import 'features/application/screens/application_catalog_page.dart';
import 'features/auth/screen/create_account.dart';
import 'features/auth/screen/forgot_password.dart';
import 'features/auth/screen/login_page.dart';

// dashboard pages
import 'features/dashboard/screens/dashboard.dart';
import 'features/configurations/screens/configurations.dart';
import 'features/cart/screens/drafts.dart';
import 'features/profile/screens/profile.dart';

// protien pages
import 'protien/FGLM/UI/FGLM.dart';
import 'protien/FGCO/UI/FGCO.dart';
import 'protien/protein_home.dart';

// application pages

// admin pages
import 'features/admin/screens/admin_dashboard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,

      // =====================================================
      // SESSION OBSERVER
      //
      // SessionObserver now internally uses UserRepository
      // to validate the current user session.
      // =====================================================

      navigatorObservers: [
        SessionObserver(),
      ],

      // Set the initial route to any of the pages
      initialRoute: '/',

      routes: {
        // ===================================================
        // LOGIN PAGES
        // ===================================================

        '/': (context) => const AppEntryRouter(),
        '/login': (context) => const LoginPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),

        // ===================================================
        // DASHBOARD PAGES
        // ===================================================

        '/dashboard': (context) => const DashboardPage(),
        '/configurations': (context) => ConfigurationsPage(),
        '/drafts': (context) => DraftsPage(),
        '/profile': (context) => const ProfilePage(),
        '/admin': (context) => const AdminDashboardPage(),


        // ===================================================
        // APPLICATION PAGES
        // ===================================================

        '/application': (context) => const ApplicationCatalogPage(),

        // ===================================================
        // INDUSTRIAL PAGE
        //
        // Keeping this route for now so existing navigation
        // does not break. We can remove/replace IndustrialHome
        // after checking all references.
        // ===================================================

        // '/industrial': (context) => const IndustrialHome(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}