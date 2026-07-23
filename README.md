# Mighty Lube Configurator

Mighty Lube Configurator is a Flutter frontend for configuring Mighty Lube industrial and protein conveyor products. The app lets users sign in, browse product families, enter product-specific configuration data, manage cart items and drafts, finalize configurations, and view saved configurations from a dashboard. It also includes an administrator dashboard for managing configurations and users.

## Project Information

```yaml
name: mighty_lube
version: 2.0.1+8
environment:
  sdk: ^3.5.2
```

Branch information:

- Live version branch: `addTechNote`
- Version branch: `adminDashboard`

The app targets Flutter platforms through the standard project folders:

- Android
- iOS
- macOS
- Windows
- Linux
- Web

## Technology Stack

- Flutter and Dart for the application UI.
- Material widgets for screens, forms, navigation, dialogs, and dashboard controls.
- `http` for REST API communication.
- `shared_preferences` for storing session data such as `sessionID`, `username`, and `role`.
- `provider` for shared UI/application state where used.
- `dropdown_search` for searchable dropdown inputs.
- `intl` for date/time formatting.
- `flutter_svg` for SVG logo rendering.
- `url_launcher` for external links.
- `photo_view` for zoomable measurement/product images.
- `password_strength_checker` for password validation UI.

## Application Architecture

The project uses a screen-based Flutter structure. Route registration is centralized in `lib/main.dart`, API access is centralized in `lib/api.dart` and `lib/admin/admin_api.dart`, and environment/session behavior is handled in `lib/env.dart`.

```text
lib/
  main.dart                         App entry point and route registration
  env.dart                          Backend URL config and session observer
  api.dart                          User, cart, draft, order, and configuration APIs
  admin/admin_api.dart              Admin configuration/user API client
  admin/UI/admin_dashboard.dart     Admin dashboard UI
  LoginPage/UI/                     Login, create account, forgot password, reset password
  dashboard/UI/                     User dashboard, configurations, drafts, profile
  industrial/                       Industrial product selection and configuration flows
  protien/                          Protein product selection and configuration flows
  application/UI/                   Application page
  shopping_cart.dart                Cart display and finalize flow
  app_bar.dart                      Shared app bar
  drawer.dart                       Shared navigation drawer
  helper_widgets.dart               Shared form/configuration widgets
```

Assets are declared in `pubspec.yaml` and stored mainly under:

```text
assets/
  industrial/                       Product category and product images
  Measurements/                     Measurement/detail images used by configurators
  countries.json                    Country list for account creation
  ML_Logo-w-tag-vector.svg          Main logo
  WhiteML_Logo-w-tag-vector.svg     White logo
  FGLM.png                          Protein product image
  FGCO.png                          Protein product image
```

## Routing

Routes are registered in `lib/main.dart`.

| Route | Purpose |
| --- | --- |
| `/` | Landing/home screen |
| `/login` | User login |
| `/create_account` | Account registration |
| `/forgot_password` | Forgot-password entry point |
| `/dashboard` | User dashboard |
| `/configurations` | User saved configurations |
| `/drafts` | User saved drafts |
| `/profile` | User profile |
| `/admin` | Administrator dashboard |
| `/protein_home` | Protein product family landing page |
| `/FGLM` | FGLM configurator |
| `/FGCO` | FGCO configurator |
| `/application` | Application page |
| `/industrial` | Industrial product family landing page |

Navigation uses Flutter named routes and normal `Navigator` calls. A `SessionObserver` is registered as a navigator observer so session validity is checked during navigation.

## Backend Configuration

The backend host is configured in `lib/env.dart`.

```dart
String get baseUrl {
  return const String.fromEnvironment(
    'API_HOST',
    defaultValue: 'http://localhost:8080',
  );
}

String get apiBaseUrl => '$baseUrl/api';
```

Default local backend:

```text
http://localhost:8080
```

Production or hosted backend can be supplied at build/run time:

```bash
flutter run --dart-define=API_HOST=https://configurator-67eol.sevalla.app
flutter build apk --release --dart-define=API_HOST=https://configurator-67eol.sevalla.app
```

## API Approach

The app uses REST endpoints under `/api`. Most authenticated requests send `sessionID` from `SharedPreferences` in the request headers.

Main API client classes:

- `UserAPI` in `lib/api.dart`: sessions, account creation, profile updates, password reset, username checks, current-user info, and admin-role checks.
- `FormAPI` in `lib/api.dart`: submits product configuration/order form data.
- `CartAPI` in `lib/api.dart`: reads, updates, deletes, and restores cart orders.
- `DraftAPI` in `lib/api.dart`: reads, saves, and deletes drafts.
- `ConfigurationAPI` in `lib/api.dart`: reads and finalizes user configurations.
- `AdminAPI` in `lib/admin/admin_api.dart`: admin-only configuration and user management.

Admin API calls use typed frontend models:

- `ConfigurationSummary`
- `AdminConfigurations`
- `AdminConfiguration`
- `AdminUser`
- `AdminApiException`

## Authentication Flow

1. User opens the app and navigates to login or account creation.
2. Login calls `UserAPI.loginUser`.
3. On success, the backend session ID and user metadata are saved in `SharedPreferences`.
4. `SessionObserver` checks session validity during route changes.
5. If the session is missing or expired, the user is redirected to `/login`.
6. Logout calls `UserAPI.logoutUser` and clears local session data.

Stored local session keys include:

- `sessionID`
- `username`
- `role`

## Account Creation Flow

1. User enters personal details, country, password, confirm password, and security PIN.
2. The app validates required fields, username availability, password strength, confirm-password match, and security PIN.
3. `UserAPI.makeAccount` sends the account payload to the backend.
4. On success, the user is routed into the dashboard experience.

## Password Reset Flow

1. User enters an email on the forgot-password screen.
2. `UserAPI.forgotPassword` submits the email.
3. User is routed to the security PIN screen.
4. `UserAPI.validateSecurityPin` validates the email and PIN through `/api/email/forgot/verify-pin`.
5. On success, the user is routed to the password reset screen.
6. `UserAPI.resetPassword` updates the password through `/api/email/forgot`.

Password rules:

- At least 8 characters.
- At least one uppercase letter.
- At least one lowercase letter.
- At least one number.
- At least one special character.
- Confirm password must match.

## User Dashboard Flow

The user dashboard provides access to:

- Product configuration entry points.
- Saved configurations.
- Draft configurations.
- User profile management.
- Application page.
- Logout.

The dashboard screens are under `lib/dashboard/UI/`.

## Product Configuration Flow

The app separates product configuration by business area:

- Industrial products under `lib/industrial/`.
- Protein products under `lib/protien/`.

Industrial flows are organized by product family and product type. Each product folder usually contains:

- A home or product page.
- A configuration page.
- An image/measurement page.

Configuration pages collect product-specific values and add them to the cart through API/state flows. Measurement images are loaded from `assets/Measurements/` and product/category images are loaded from `assets/industrial/`.

## Cart, Draft, and Final Configuration Flow

Cart and configuration behavior is handled through:

- `shopping_cart.dart`
- `CartAPI`
- `DraftAPI`
- `ConfigurationAPI`

Typical user flow:

1. User selects a product family and product.
2. User enters configuration data.
3. Product configuration is added to the cart.
4. User can edit cart quantity/configuration data where supported.
5. User can save work as a draft.
6. User can restore a draft later.
7. User finalizes the cart as a named configuration.
8. Finalized configurations are available from the dashboard.

## Admin Dashboard

The admin dashboard is available at:

```text
/admin
```

Admin access is guarded by the locally stored `role` value and backend session validation. Non-admin users are redirected back to the normal dashboard.

Admin configuration features:

- Load all configurations.
- View configuration summary counts.
- View configuration details.
- Edit configuration name and product configuration values.
- Change configuration status.
- Delete configurations.
- Mobile-friendly card layout for narrow screens.

Admin user features:

- Load all users.
- View user details.
- Edit user profile data.
- Change user role.
- Reset user password.
- Delete users.
- Mobile-friendly card layout for narrow screens.

## UI and Responsiveness

The app uses Material widgets and shared UI helpers. Dashboard and admin layouts use responsive checks based on `MediaQuery` and `LayoutBuilder`.

Current responsive approach:

- Wide screens use table-style admin views where appropriate.
- Mobile screens use stacked cards to avoid horizontal scrolling.
- View/edit dialogs use constrained max widths and scrollable content.
- Form fields wrap into compact groups on wider screens and become full-width on mobile.

## Setup

Install Flutter, then install project dependencies:

```bash
flutter pub get
```

Run locally:

```bash
flutter run
```

Run with a specific backend:

```bash
flutter run --dart-define=API_HOST=http://localhost:8080
flutter run --dart-define=API_HOST=https://configurator-67eol.sevalla.app
```

Run for specific targets:

```bash
flutter run -d chrome
flutter run -d macos
flutter run -d android
```

## Analysis and Tests

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Android Release Build

Release signing reads `key.properties` from:

```text
android/app/key.properties
```

Expected properties:

```properties
keyAlias=...
keyPassword=...
storeFile=...
storePassword=...
```

Build a release APK:

```bash
flutter build apk --release --dart-define=API_HOST=https://configurator-67eol.sevalla.app
```

## Platform Notes

- macOS builds require `com.apple.security.network.client` for outbound API access.
- Web assets and splash/icon files are present under `web/`.
- Native platform folders are included for Android, iOS, macOS, Linux, Windows, and web.
- Android release signing is configured in `android/app/build.gradle`.
- iOS and macOS native project files are included under `ios/` and `macos/`.

## Current Version Notes

Current app version:

```yaml
version: 2.0.1+8
```

The note in `pubspec.yaml` says iOS already had version `2.0.0`, so this project is using `2.0.1+8` to keep Android and iOS versioning aligned.
