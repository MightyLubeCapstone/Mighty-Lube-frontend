
class AppVersionModel {
  // =========================================================
  // VERSION INFORMATION
  // =========================================================

  final String platform;
  final String currentVersion;
  final String backendVersion;
  final String? frontendVersion;
  final String? latestVersion;
  final String? minimumSupportedVersion;

  // =========================================================
  // UPDATE CONFIGURATION
  // =========================================================

  final bool updateEnabled;
  final bool updateAvailable;
  final bool forceUpdate;
  final String updateType;

  // =========================================================
  // UPDATE DIALOG CONTENT
  // =========================================================

  final String? title;
  final String? message;
  final String releaseNotes;
  final String? storeUrl;

  static const String unavailableBackendVersion = 'Unavailable';

  const AppVersionModel({
    required this.platform,
    required this.currentVersion,
    required this.backendVersion,
    this.frontendVersion,
    this.latestVersion,
    this.minimumSupportedVersion,
    required this.updateEnabled,
    required this.updateAvailable,
    required this.forceUpdate,
    required this.updateType,
    this.title,
    this.message,
    required this.releaseNotes,
    this.storeUrl,
  });

  // =========================================================
  // FROM JSON
  // =========================================================

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    String readString(String key, [String fallback = '']) {
      final value = json[key];

      if (value is String) {
        return value.trim();
      }

      return fallback;
    }

    String? readOptionalString(String key) {
      final value = readString(key);
      return value.isEmpty ? null : value;
    }

    bool readBool(String key) {
      return json[key] == true;
    }

    final configuredUpdateType = readString(
      'updateType',
      'none',
    ).toLowerCase();

    final normalizedUpdateType = const {
      'none',
      'optional',
      'required',
    }.contains(configuredUpdateType)
        ? configuredUpdateType
        : 'none';

    return AppVersionModel(
      platform: readString('platform'),
      currentVersion: readString('currentVersion'),
      backendVersion: readString(
        'backendVersion',
        unavailableBackendVersion,
      ),
      frontendVersion: readOptionalString('frontendVersion'),
      latestVersion: readOptionalString('latestVersion'),
      minimumSupportedVersion:
      readOptionalString('minimumSupportedVersion'),
      updateEnabled: readBool('updateEnabled'),
      updateAvailable: readBool('updateAvailable'),
      forceUpdate: readBool('forceUpdate'),
      updateType: normalizedUpdateType,
      title: readOptionalString('title'),
      message: readOptionalString('message'),
      releaseNotes: readString('releaseNotes'),
      storeUrl: readOptionalString('storeUrl'),
    );
  }

  // =========================================================
  // VERSION COMPARISON
  //
  // Returns:
  //  1 = first version is newer
  //  0 = versions are equal
  // -1 = first version is older
  //
  // Returns null for invalid version strings.
  //
  // Examples:
  // 3.0.3 > 3.0.2
  // 3.0.2 = 3.0.2
  // 3.0.2 < 3.0.3
  // 3.0.10 > 3.0.9
  // =========================================================

  static int? compareVersions(
      String firstVersion,
      String secondVersion,
      ) {
    final first = _parseVersion(firstVersion);
    final second = _parseVersion(secondVersion);

    if (first == null || second == null) {
      return null;
    }

    final maxLength = first.length > second.length
        ? first.length
        : second.length;

    for (var index = 0; index < maxLength; index++) {
      final firstPart =
      index < first.length ? first[index] : 0;

      final secondPart =
      index < second.length ? second[index] : 0;

      if (firstPart > secondPart) {
        return 1;
      }

      if (firstPart < secondPart) {
        return -1;
      }
    }

    return 0;
  }

  static List<int>? _parseVersion(String version) {
    final normalized = version.trim();

    if (normalized.isEmpty) {
      return null;
    }

    // Supports versions such as 3.0.2 or 3.0.2+15.
    // Build number is not used for version-name comparison.
    final versionName = normalized.split('+').first;

    if (!RegExp(r'^\d+(?:\.\d+)*$').hasMatch(versionName)) {
      return null;
    }

    final parts = <int>[];

    for (final part in versionName.split('.')) {
      final parsed = int.tryParse(part);

      if (parsed == null) {
        return null;
      }

      parts.add(parsed);
    }

    return parts;
  }

  // =========================================================
  // CHECK WHETHER SERVER HAS A NEWER VERSION
  //
  // currentVersion = installed application version
  // latestVersion = latest frontend version from backend
  // =========================================================

  bool get hasNewerVersion {
    final latest = latestVersion;

    if (latest == null || latest.trim().isEmpty) {
      return false;
    }

    final comparison = compareVersions(
      latest,
      currentVersion,
    );

    return comparison != null && comparison > 0;
  }

  // =========================================================
  // UPDATE VALIDATION
  //
  // Popup only when:
  // 1. Updates are enabled
  // 2. Server has a newer frontend version
  // 3. Update type is optional or required
  // 4. Store URL is valid
  //
  // We intentionally do not trust updateAvailable alone.
  // =========================================================

  bool get shouldShowUpdate {
    return updateEnabled &&
        hasNewerVersion &&
        (updateType == 'optional' ||
            updateType == 'required' ||
            forceUpdate) &&
        hasValidStoreUrl;
  }

  // =========================================================
  // REQUIRED UPDATE
  //
  // Either required updateType or forceUpdate makes
  // the update mandatory.
  // =========================================================

  bool get isRequiredUpdate {
    return shouldShowUpdate &&
        (updateType == 'required' || forceUpdate);
  }

  // =========================================================
  // OPTIONAL UPDATE
  // =========================================================

  bool get isOptionalUpdate {
    return shouldShowUpdate && !isRequiredUpdate;
  }

  // =========================================================
  // RELEASE NOTES
  // =========================================================

  bool get hasReleaseNotes {
    return releaseNotes.trim().isNotEmpty;
  }

  // =========================================================
  // STORE URL VALIDATION
  // =========================================================

  bool get hasValidStoreUrl {
    final url = storeUrl;

    if (url == null || url.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(url);

    return uri != null &&
        uri.scheme == 'https' &&
        uri.host.isNotEmpty;
  }

  // =========================================================
  // FRONTEND VERSION DISPLAY
  //
  // For the login/signup FS Version label, prefer the
  // installed application version supplied as fallback.
  // =========================================================

  String displayFrontendVersion(String localFallbackVersion) {
    return localFallbackVersion;
  }

  // =========================================================
  // TO JSON
  // =========================================================

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'currentVersion': currentVersion,
      'backendVersion': backendVersion,
      'frontendVersion': frontendVersion,
      'latestVersion': latestVersion,
      'minimumSupportedVersion': minimumSupportedVersion,
      'updateEnabled': updateEnabled,
      'updateAvailable': updateAvailable,
      'forceUpdate': forceUpdate,
      'updateType': updateType,
      'title': title,
      'message': message,
      'releaseNotes': releaseNotes,
      'storeUrl': storeUrl,
    };
  }
}
