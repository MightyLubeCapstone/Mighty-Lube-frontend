import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RememberedAccount {
  final String username;
  final DateTime lastUsedAt;

  const RememberedAccount({
    required this.username,
    required this.lastUsedAt,
  });

  factory RememberedAccount.fromJson(Map<String, dynamic> json) {
    final rawLastUsedAt = json['lastUsedAt']?.toString();

    return RememberedAccount(
      username: json['username']?.toString().trim() ?? '',
      lastUsedAt:
      DateTime.tryParse(rawLastUsedAt ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'lastUsedAt': lastUsedAt.toIso8601String(),
    };
  }
}

class RememberedAccountService {
  RememberedAccountService._();

  static const String _storageKey = 'remembered_accounts';

  // Keep the list small and useful.
  static const int _maxRememberedAccounts = 5;

  // =========================================================
  // GET REMEMBERED ACCOUNTS
  // =========================================================

  static Future<List<RememberedAccount>> getAccounts() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final rawValue = preferences.getString(_storageKey);

      if (rawValue == null || rawValue.trim().isEmpty) {
        return <RememberedAccount>[];
      }

      final decoded = jsonDecode(rawValue);

      if (decoded is! List) {
        return <RememberedAccount>[];
      }

      final accounts = <RememberedAccount>[];

      for (final item in decoded) {
        if (item is! Map) {
          continue;
        }

        final account = RememberedAccount.fromJson(
          Map<String, dynamic>.from(item),
        );

        if (account.username.isEmpty) {
          continue;
        }

        accounts.add(account);
      }

      accounts.sort(
            (a, b) => b.lastUsedAt.compareTo(a.lastUsedAt),
      );

      return accounts;
    } catch (_) {
      return <RememberedAccount>[];
    }
  }

  // =========================================================
  // REMEMBER ACCOUNT
  //
  // IMPORTANT:
  // Password is NEVER stored here.
  // =========================================================

  static Future<void> rememberAccount({
    required String username,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();

    if (normalizedUsername.isEmpty) {
      return;
    }

    final accounts = await getAccounts();

    // Remove an older copy of the same account.
    accounts.removeWhere(
          (account) =>
      account.username.trim().toLowerCase() ==
          normalizedUsername,
    );

    // Most recently used account goes first.
    accounts.insert(
      0,
      RememberedAccount(
        username: normalizedUsername,
        lastUsedAt: DateTime.now(),
      ),
    );

    if (accounts.length > _maxRememberedAccounts) {
      accounts.removeRange(
        _maxRememberedAccounts,
        accounts.length,
      );
    }

    await _saveAccounts(accounts);
  }

  // =========================================================
  // REMOVE ONE REMEMBERED ACCOUNT
  //
  // This does NOT delete the backend user.
  // It only forgets the account on this device/browser.
  // =========================================================

  static Future<void> removeAccount({
    required String username,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();

    final accounts = await getAccounts();

    accounts.removeWhere(
          (account) =>
      account.username.trim().toLowerCase() ==
          normalizedUsername,
    );

    await _saveAccounts(accounts);
  }

  // =========================================================
  // CLEAR ALL REMEMBERED ACCOUNTS
  //
  // This does NOT logout the current session and does NOT
  // delete any backend users.
  // =========================================================

  static Future<void> clearAccounts() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_storageKey);
  }

  // =========================================================
  // PRIVATE SAVE
  // =========================================================

  static Future<void> _saveAccounts(
      List<RememberedAccount> accounts,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      accounts
          .map(
            (account) => account.toJson(),
      )
          .toList(),
    );

    await preferences.setString(
      _storageKey,
      encoded,
    );
  }
}