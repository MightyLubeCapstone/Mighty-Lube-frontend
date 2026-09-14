enum AppEnvironment {
  development,
  production,
}

class AppEnvironmentConfig {
  AppEnvironmentConfig._();

  // =========================================================
  // CURRENT ENVIRONMENT
  // Change only this value
  // =========================================================

  static const AppEnvironment environment = AppEnvironment.development;

  // =========================================================
  // BASE URLS
  // Replace these with your actual URLs
  // =========================================================

  static const String _developmentBaseUrl = 'http://localhost:8080';
  static const String _productionBaseUrl = 'https://configurator-67eol.sevalla.app';

  // =========================================================
  // ACTIVE BASE URL
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
}