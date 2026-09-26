enum AppEnvironment {
  development,
  production,
}

class AppEnvironmentConfig {
  AppEnvironmentConfig._();

  // =========================================================
  // CURRENT ENVIRONMENT
  //
  // Change only this value to switch API server.
  // =========================================================

  static const AppEnvironment environment = AppEnvironment.development;

  // =========================================================
  // TESTING / DEBUG LOGGING
  //
  // true:
  // - Log API URL
  // - Log HTTP method
  // - Log request headers
  // - Log request body
  // - Log response status
  // - Log response body
  // - Log request duration
  // - Log API errors
  //
  // false:
  // - Detailed API logging disabled
  //
  // IMPORTANT:
  // Keep this false for production release builds.
  // =========================================================

  static const bool testingMode = true;

  // =========================================================
  // BASE URLS
  // =========================================================

  static const String _developmentBaseUrl = 'http://localhost:8080';
  // static const String _developmentBaseUrl = 'http://10.0.2.2:8080';
  static const String _productionBaseUrl = 'https://configurator-67eol.sevalla.app';

  // =========================================================
  // ACTIVE BASE URL baseUrl:
  // =========================================================

  static String get baseUrl {
    switch (environment) {
      case AppEnvironment.development:
        return _developmentBaseUrl;

      case AppEnvironment.production:
        return _productionBaseUrl;
    }
  }

  // =========================================================
  // HELPERS
  // =========================================================

  static bool get isDevelopment => environment == AppEnvironment.development;
  static bool get isProduction => environment == AppEnvironment.production;
  static bool get isTestingMode => testingMode;
}