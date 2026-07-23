# Mighty Lube Configurator

Flutter frontend for configuring Mighty Lube industrial and protein conveyor products. Users can sign in, browse product families, configure products, manage carts and drafts, finalize configurations, and view saved configurations. Admin users can manage configurations and users from the admin dashboard.

## Quick Info

```yaml
name: mighty_lube
version: 2.0.2+9
environment:
  sdk: ^3.5.2
```

- Live branch: `addTechNote`
- Active version branch: `adminDashboard`
- Default local backend: `http://localhost:8080`
- API root: `http://localhost:8080/api`
- Admin route: `/admin`

<details>
<summary>Branch And Release Details</summary>

### Branches

- `addTechNote`
  - Current live project baseline.
- `adminDashboard`
  - Active version branch for admin dashboard updates.
  - Adds server-side sorting, date filtering, and configuration status filtering.
  - Adds configuration status grouping.
  - Adds created/updated elapsed-time indicators in configuration lists, cards, view dialogs, and edit dialogs.
  - Keeps Users tab sorting/date filtering separate from configuration-only status controls.

### Version Mapping

- Flutter project version: `2.0.2+9`

Android:

- `versionName`: `2.0.2`
- `versionCode`: `9`
- Source: `android/app/build.gradle` uses `flutter.versionName` and `flutter.versionCode`.

iOS:

- `CFBundleShortVersionString`: `2.0.2`
- `CFBundleVersion`: `9`
- Source: `ios/Runner/Info.plist` uses `$(FLUTTER_BUILD_NAME)` and `$(FLUTTER_BUILD_NUMBER)`.

</details>

<details>
<summary>Technology Stack</summary>

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

</details>

<details>
<summary>Project Structure</summary>

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

Platform folders:

- Android
- iOS
- macOS
- Windows
- Linux
- Web

</details>

<details>
<summary>Routing</summary>

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

</details>

<details>
<summary>Backend And API</summary>

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

Run with a specific backend:

```bash
flutter run --dart-define=API_HOST=http://localhost:8080
flutter run --dart-define=API_HOST=https://configurator-67eol.sevalla.app
```

Main API client classes:

- `UserAPI` in `lib/api.dart`: sessions, account creation, profile updates, password reset, username checks, current-user info, and admin-role checks.
- `FormAPI` in `lib/api.dart`: submits product configuration/order form data.
- `CartAPI` in `lib/api.dart`: reads, updates, deletes, and restores cart orders.
- `DraftAPI` in `lib/api.dart`: reads, saves, and deletes drafts.
- `ConfigurationAPI` in `lib/api.dart`: reads and finalizes user configurations.
- `AdminAPI` in `lib/admin/admin_api.dart`: admin-only configuration and user management.

Admin API models:

- `ConfigurationSummary`
- `AdminConfigurations`
- `AdminConfiguration`
- `AdminUser`
- `AdminListFilters`
- `AdminApiException`

</details>

<details>
<summary>Admin Dashboard</summary>

The admin dashboard is available at:

```text
/admin
```

Admin access is guarded by the locally stored `role` value and backend session validation. Non-admin users are redirected back to the normal dashboard.

Configuration features:

- Load configurations with server-side sorting.
- Filter configurations by created/updated date windows.
- Filter configurations by status: `all`, `requested`, `pending`, `done`.
- Group configurations by status.
- View filtered summary counts.
- View configuration details.
- Edit configuration name and product configuration values.
- Change configuration status.
- Delete configurations.
- Show created/updated elapsed-time information in table rows, cards, view dialogs, and edit dialogs.
- Highlight pending duration.
- Mobile-friendly card layout for narrow screens.

Users features:

- Load users with server-side sorting.
- Filter users by created/updated date windows.
- View user details.
- Edit user profile data.
- Change user role.
- Reset user password.
- Delete users.
- Mobile-friendly card layout for narrow screens.

</details>

<details>
<summary>User Flows</summary>

### Authentication

1. User opens the app and navigates to login or account creation.
2. Login calls `UserAPI.loginUser`.
3. On success, the backend session ID and user metadata are saved in `SharedPreferences`.
4. `SessionObserver` checks session validity during route changes.
5. If the session is missing or expired, the user is redirected to `/login`.
6. Logout calls `UserAPI.logoutUser` and clears local session data.

Stored local session keys:

- `sessionID`
- `username`
- `role`

### Account Creation

1. User enters personal details, country, password, confirm password, and security PIN.
2. The app validates required fields, username availability, password strength, confirm-password match, and security PIN.
3. `UserAPI.makeAccount` sends the account payload to the backend.
4. On success, the user is routed into the dashboard experience.

### Password Reset

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

### Cart, Draft, And Final Configuration

1. User selects a product family and product.
2. User enters configuration data.
3. Product configuration is added to the cart.
4. User can edit cart quantity/configuration data where supported.
5. User can save work as a draft.
6. User can restore a draft later.
7. User finalizes the cart as a named configuration.
8. Finalized configurations are available from the dashboard.

</details>

<details>
<summary>Product Configuration</summary>

The app separates product configuration by business area:

- Industrial products under `lib/industrial/`.
- Protein products under `lib/protien/`.

Industrial flows are organized by product family and product type. Each product folder usually contains:

- A home or product page.
- A configuration page.
- An image/measurement page.

Configuration pages collect product-specific values and add them to the cart through API/state flows. Measurement images are loaded from `assets/Measurements/` and product/category images are loaded from `assets/industrial/`.

</details>

<details>
<summary>UI And Responsiveness</summary>

The app uses Material widgets and shared UI helpers. Dashboard and admin layouts use responsive checks based on `MediaQuery` and `LayoutBuilder`.

Current responsive approach:

- Wide screens use table-style admin views where appropriate.
- Mobile screens use stacked cards to avoid horizontal scrolling.
- View/edit dialogs use constrained max widths and scrollable content.
- Form fields wrap into compact groups on wider screens and become full-width on mobile.

</details>

<details>
<summary>Setup, Analysis, And Release Build</summary>

Install Flutter, then install project dependencies:

```bash
flutter pub get
```

Run locally:

```bash
flutter run
```

Run for specific targets:

```bash
flutter run -d chrome
flutter run -d macos
flutter run -d android
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Android release signing reads `key.properties` from:

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

</details>

<details>
<summary>Platform Notes</summary>

- macOS builds require `com.apple.security.network.client` for outbound API access.
- Web assets and splash/icon files are present under `web/`.
- Native platform folders are included for Android, iOS, macOS, Linux, Windows, and web.
- Android release signing is configured in `android/app/build.gradle`.
- iOS and macOS native project files are included under `ios/` and `macos/`.

</details>
