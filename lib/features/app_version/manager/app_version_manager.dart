
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/app_version_model.dart';
import '../services/app_version_api_service.dart';

/// Result of a version check.
/// Failed requests never block application startup.
class AppVersionCheckResult {
  final String installedVersion;
  final String? errorMessage;
  final AppVersionModel? versionInfo;
  final bool supportsStoreUpdates;

  const AppVersionCheckResult({
    required this.installedVersion,
    this.errorMessage,
    this.versionInfo,
    this.supportsStoreUpdates = false,
  });

  // =========================================================
  // UPDATE STATUS
  // =========================================================

  bool get shouldShowUpdate =>
      supportsStoreUpdates &&
          (versionInfo?.shouldShowUpdate ?? false);

  bool get isRequiredUpdate =>
      shouldShowUpdate &&
          (versionInfo?.isRequiredUpdate ?? false);

  // =========================================================
  // VERSION DISPLAY
  //
  // FS Version always comes from the installed app.
  // =========================================================

  String get frontendVersion => installedVersion;

  String get backendVersion {
    final version = versionInfo?.backendVersion.trim();

    if (version != null && version.isNotEmpty) {
      return version;
    }

    return AppVersionModel.unavailableBackendVersion;
  }
}

/// Manages application version information.
///
/// Android/iOS:
/// - Compares installed version against server latestVersion.
/// - Supports optional and required updates.
///
/// Web:
/// - Fetches display-only version information.
/// - Never triggers a mobile store update popup.
///
/// Desktop:
/// - Uses local version only.
///
/// Results are cached to avoid repeated requests.
/// Use forceRefresh: true for a fresh startup check.
class AppVersionManager {
  const AppVersionManager({
    this.apiService = const AppVersionApiService(),
  });

  final AppVersionApiService apiService;

  static AppVersionCheckResult? _cachedResult;
  static Future<AppVersionCheckResult>? _pendingRequest;

  // =========================================================
  // CHECK FOR UPDATES
  // =========================================================

  Future<AppVersionCheckResult> checkForUpdates({
    bool forceRefresh = false,
  }) {
    if (!forceRefresh && _cachedResult != null) {
      return Future.value(_cachedResult!);
    }

    if (_pendingRequest != null) {
      return _pendingRequest!;
    }

    final request = _fetchVersionInformation();

    _pendingRequest = request;

    return request.then((result) {
      if (result.versionInfo != null) {
        _cachedResult = result;
      }

      return result;
    }).whenComplete(() {
      _pendingRequest = null;
    });
  }

  // =========================================================
  // FETCH VERSION INFORMATION
  // =========================================================

  Future<AppVersionCheckResult> _fetchVersionInformation() async {
    String installedVersion = 'Unknown';

    try {
      final packageInfo = await PackageInfo.fromPlatform();

      installedVersion = packageInfo.version.trim();

      if (installedVersion.isEmpty) {
        installedVersion = 'Unknown';
      }

      // =====================================================
      // WEB: DISPLAY ONLY
      // =====================================================

      if (kIsWeb) {
        final response = await apiService.getDisplayVersion(
          platform: 'web',
        );

        if (!response.success || response.data == null) {
          return AppVersionCheckResult(
            installedVersion: installedVersion,
            errorMessage: response.message ??
                'Version information unavailable.',
          );
        }

        final versionInfo = AppVersionModel.fromJson(
          response.data!,
        );

        return AppVersionCheckResult(
          installedVersion: installedVersion,
          versionInfo: versionInfo,
          supportsStoreUpdates: false,
        );
      }

      // =====================================================
      // DESKTOP: NO MOBILE UPDATE CHECK
      // =====================================================

      if (defaultTargetPlatform != TargetPlatform.android &&
          defaultTargetPlatform != TargetPlatform.iOS) {
        return AppVersionCheckResult(
          installedVersion: installedVersion,
        );
      }

      // =====================================================
      // ANDROID / IOS: VERSION CHECK
      // =====================================================

      final platform =
      defaultTargetPlatform == TargetPlatform.android
          ? 'android'
          : 'ios';

      final response = await apiService.checkVersion(
        platform: platform,
        installedVersion: installedVersion,
      );

      if (!response.success || response.data == null) {
        return AppVersionCheckResult(
          installedVersion: installedVersion,
          errorMessage: response.message ??
              'Version check unavailable.',
        );
      }

      final serverVersionInfo = AppVersionModel.fromJson(
        response.data!,
      );

      // IMPORTANT:
      // The installed version from PackageInfo is authoritative.
      // Do not use the server's echoed currentVersion for
      // deciding whether an update is available.

      final versionInfo = AppVersionModel(
        platform: platform,
        currentVersion: installedVersion,
        backendVersion: serverVersionInfo.backendVersion,
        frontendVersion: serverVersionInfo.frontendVersion,
        latestVersion: serverVersionInfo.latestVersion,
        minimumSupportedVersion:
        serverVersionInfo.minimumSupportedVersion,
        updateEnabled: serverVersionInfo.updateEnabled,
        updateAvailable: serverVersionInfo.updateAvailable,
        forceUpdate: serverVersionInfo.forceUpdate,
        updateType: serverVersionInfo.updateType,
        title: serverVersionInfo.title,
        message: serverVersionInfo.message,
        releaseNotes: serverVersionInfo.releaseNotes,
        storeUrl: serverVersionInfo.storeUrl,
      );

      debugPrint(
        '[APP VERSION] Installed FS Version: $installedVersion',
      );
      debugPrint(
        '[APP VERSION] Server Latest Version: '
            '${versionInfo.latestVersion}',
      );
      debugPrint(
        '[APP VERSION] Newer Version: '
            '${versionInfo.hasNewerVersion}',
      );
      debugPrint(
        '[APP VERSION] Update Enabled: '
            '${versionInfo.updateEnabled}',
      );
      debugPrint(
        '[APP VERSION] Show Update: '
            '${versionInfo.shouldShowUpdate}',
      );
      debugPrint(
        '[APP VERSION] Required Update: '
            '${versionInfo.isRequiredUpdate}',
      );

      return AppVersionCheckResult(
        installedVersion: installedVersion,
        versionInfo: versionInfo,
        supportsStoreUpdates: true,
      );
    } catch (error) {
      debugPrint('App version request skipped: $error');

      return AppVersionCheckResult(
        installedVersion: installedVersion,
        errorMessage: 'Version information unavailable.',
      );
    }
  }

  // =========================================================
  // CLEAR CACHE
  // =========================================================

  static void clearCache() {
    _cachedResult = null;
  }
}
