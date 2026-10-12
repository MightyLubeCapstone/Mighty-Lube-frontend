
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/app_version_model.dart';

class AppUpdateDialog extends StatefulWidget {
  final AppVersionModel versionInfo;

  const AppUpdateDialog({
    super.key,
    required this.versionInfo,
  });

  // =========================================================
  // SHOW UPDATE DIALOG
  // =========================================================

  static Future<void> show(
      BuildContext context, {
        required AppVersionModel versionInfo,
      }) async {
    if (!context.mounted || !versionInfo.shouldShowUpdate) {
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: !versionInfo.isRequiredUpdate,
      builder: (dialogContext) {
        return AppUpdateDialog(versionInfo: versionInfo);
      },
    );
  }

  @override
  State<AppUpdateDialog> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  bool _isOpeningStore = false;
  String? _storeError;

  AppVersionModel get versionInfo => widget.versionInfo;

  bool get isRequired => versionInfo.isRequiredUpdate;

  // =========================================================
  // SHOW STORE ERROR POPUP
  // =========================================================

  Future<void> _showStoreErrorPopup(String message) async {
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Unavailable'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // OPEN STORE URL FROM BACKEND
  // =========================================================

  Future<void> _openStore() async {
    if (_isOpeningStore) return;

    debugPrint('========== APP UPDATE ==========');
    debugPrint('Server Store URL: ${versionInfo.storeUrl}');
    debugPrint('Latest Version: ${versionInfo.latestVersion}');
    debugPrint('================================');

    final storeUrl = versionInfo.storeUrl?.trim();
    final uri = storeUrl == null ? null : Uri.tryParse(storeUrl);

    if (uri == null ||
        uri.scheme != 'https' ||
        uri.userInfo.isNotEmpty ||
        uri.host.isEmpty ||
        !versionInfo.hasValidStoreUrl) {
      await _showStoreErrorPopup(
        'App store link is currently unavailable. '
            'Please try again later.',
      );
      return;
    }

    // Only allow official Apple and Google store domains.
    final host = uri.host.toLowerCase();

    final isOfficialStore =
        host == 'apps.apple.com' ||
            host == 'play.google.com';

    if (!isOfficialStore) {
      await _showStoreErrorPopup(
        'The app store link is invalid. Please try again later.',
      );
      return;
    }

    setState(() {
      _isOpeningStore = true;
      _storeError = null;
    });

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        await _showStoreErrorPopup(
          'Unable to open the app store. Please try again later.',
        );
      }
    } catch (_) {
      if (mounted) {
        await _showStoreErrorPopup(
          'Unable to open the app store. Please try again later.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isOpeningStore = false;
        });
      }
    }
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = isRequired
        ? 'Update Required'
        : (versionInfo.title ?? 'Update Available');

    final message = isRequired
        ? 'A new version of Mighty Lube is required to continue '
        'using the application. Please install the latest '
        'version to proceed.'
        : (versionInfo.message ??
        'A new version of Mighty Lube is available. '
            'Would you like to update now?');

    return PopScope(
      canPop: !isRequired,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              isRequired
                  ? Icons.system_update_alt
                  : Icons.new_releases_outlined,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                // VERSION INFORMATION
                if (versionInfo.latestVersion != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'New Version: ${versionInfo.latestVersion}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],

                // RELEASE NOTES
                if (versionInfo.hasReleaseNotes) ...[
                  const SizedBox(height: 20),
                  const Text(
                    "What's New",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    versionInfo.releaseNotes,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],

                // STORE ERROR
                if (_storeError != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _storeError!,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // =====================================================
        // ACTION BUTTONS
        // =====================================================

        actions: [
          if (!isRequired)
            TextButton(
              onPressed: _isOpeningStore
                  ? null
                  : () => Navigator.of(context).pop(),
              child: const Text('Later'),
            ),

          ElevatedButton.icon(
            onPressed: _isOpeningStore ? null : _openStore,
            icon: _isOpeningStore
                ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
                : const Icon(Icons.system_update_alt),
            label: Text(
              _isOpeningStore ? 'Opening...' : 'Update Now',
            ),
          ),
        ],
      ),
    );
  }
}
