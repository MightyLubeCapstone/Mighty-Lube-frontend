
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Core navigation
import 'core/navigation/app_entry_router.dart';
import 'core/navigation/sessionObserver.dart';

// App version management
import 'features/app_version/manager/app_version_manager.dart';
import 'features/app_version/widget/app_update_dialog.dart';

// Login pages
import 'features/application/screens/application_catalog_page.dart';
import 'features/auth/screen/create_account.dart';
import 'features/auth/screen/forgot_password.dart';
import 'features/auth/screen/login_page.dart';

// Dashboard pages
import 'features/dashboard/screens/dashboard.dart';
import 'features/configurations/screens/configurations.dart';
import 'features/cart/screens/drafts.dart';
import 'features/profile/screens/profile.dart';

// Admin pages
import 'features/admin/screens/admin_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print('🔥🔥🔥 MAIN.DART EXECUTED 🔥🔥🔥');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppVersionManager _appVersionManager =
  const AppVersionManager();

  bool _versionCheckStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _versionCheckStarted) return;

      _versionCheckStarted = true;
      _checkAppVersion();
    });
  }

  // =========================================================
  // CHECK APP VERSION AT STARTUP
  // =========================================================

  Future<void> _checkAppVersion() async {
    debugPrint('[APP VERSION] Startup check initiated.');
    debugPrint('[APP VERSION] kIsWeb: $kIsWeb');
    debugPrint(
      '[APP VERSION] Target platform: $defaultTargetPlatform',
    );

    // Mobile update popup only.
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      debugPrint(
        '[APP VERSION] Update popup skipped: unsupported platform.',
      );
      return;
    }

    try {
      // Force fresh check instead of reusing a cached result.
      final result = await _appVersionManager.checkForUpdates(
        forceRefresh: true,
      );

      debugPrint(
        '[APP VERSION] Installed version: ${result.installedVersion}',
      );
      debugPrint(
        '[APP VERSION] Frontend version: ${result.frontendVersion}',
      );
      debugPrint(
        '[APP VERSION] Backend version: ${result.backendVersion}',
      );
      debugPrint(
        '[APP VERSION] Error: ${result.errorMessage ?? "none"}',
      );

      final info = result.versionInfo;

      if (info == null) {
        debugPrint(
          '[APP VERSION] No valid version information received.',
        );
        return;
      }

      debugPrint(
        '[APP VERSION] Latest version: ${info.latestVersion}',
      );
      debugPrint(
        '[APP VERSION] Update enabled: ${info.updateEnabled}',
      );
      debugPrint(
        '[APP VERSION] Update available: ${info.updateAvailable}',
      );
      debugPrint(
        '[APP VERSION] Update type: ${info.updateType}',
      );
      debugPrint(
        '[APP VERSION] Force update: ${info.forceUpdate}',
      );
      debugPrint(
        '[APP VERSION] Valid store URL: ${info.hasValidStoreUrl}',
      );
      debugPrint(
        '[APP VERSION] Should show update: ${result.shouldShowUpdate}',
      );

      if (!mounted) {
        debugPrint(
          '[APP VERSION] Widget unmounted before popup.',
        );
        return;
      }

      if (!result.shouldShowUpdate) {
        debugPrint(
          '[APP VERSION] Popup skipped because conditions were not met.',
        );
        return;
      }

      final navigator = navigatorKey.currentState;
      final dialogContext = navigator?.overlay?.context;

      if (dialogContext == null || !dialogContext.mounted) {
        debugPrint(
          '[APP VERSION] Popup skipped: Navigator context unavailable.',
        );
        return;
      }

      debugPrint('[APP VERSION] Showing update popup.');

      await AppUpdateDialog.show(
        dialogContext,
        versionInfo: info,
      );

      debugPrint('[APP VERSION] Update popup closed.');
    } catch (error, stackTrace) {
      debugPrint('[APP VERSION] Unexpected error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,

      // =====================================================
      // SESSION OBSERVER
      // =====================================================

      navigatorObservers: [
        SessionObserver(),
      ],

      initialRoute: '/',

      routes: {
        // ===================================================
        // LOGIN PAGES
        // ===================================================

        '/': (context) => const AppEntryRouter(),
        '/login': (context) => const LoginPage(),
        '/create_account': (context) =>
        const CreateAccountPage(),
        '/forgot_password': (context) =>
        const ForgotPasswordPage(),

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

        '/application': (context) =>
        const ApplicationCatalogPage(),

        // ===================================================
        // INDUSTRIAL PAGE
        // Keeping this route commented out as in original.
        // ===================================================

        // '/industrial': (context) => const IndustrialHome(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
