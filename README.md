# Mighty Lube Configurator

Flutter frontend for configuring Mighty Lube conveyor products.

The application allows users to:

- Sign in and manage their account
- Browse Industrial, Protein, and Technician products
- Configure products
- Upload configuration-related images
- Add configurations to the cart
- Save and restore drafts
- Finalize configurations
- View saved configurations
- Manage configurations through the Admin Dashboard

The frontend has been migrated from a **product-specific page architecture**
to a **reusable, data-driven Product Configurator architecture**.

---

## Quick Info

The application supports:

| Application | Configurable Products |
| --- | ---: |
| Industrial | 76 |
| Protein | 2 |
| Technician | 1 |
| **Total** | **79** |

Backend environments:

```text
Development:
http://localhost:8080

Production:
https://configurator-67eol.sevalla.app
```

Production API root:

```text
https://configurator-67eol.sevalla.app/api
```

Admin route:

```text
/admin
```

---

# Architecture Migration

## Previous Architecture

Previously, most products had dedicated UI/configuration pages.

Typical flow:

```text
Catalog
    ↓
Product
    ↓
Dedicated Product Page
    ↓
Product-Specific Form Logic
    ↓
API
```

Product folders commonly contained their own:

- Product page
- Configuration page
- Form fields
- Validation
- Dropdown handling
- Measurement/image page
- API submission logic

This worked for individual products but resulted in repeated UI and
configuration logic as the catalog grew.

---

## Current Architecture

The Product Configurator now uses a reusable data-driven architecture.

```text
Application Catalog
        ↓
ProductItem
        ↓
ProductDetailData
        ↓
ProductConfigurationForm
        ↓
ProductRepository
        ↓
ProductApiService
        ↓
ApiClient
        ↓
Backend API
```

Product-specific configuration is stored as data.

Common configuration behavior is handled by the reusable
`ProductConfigurationForm`.

Example:

```dart
ProductItem(
  title: 'Mighty Lube CC5 Chain Lubricator',
  imagePath: AppAssets.mlcc5ChainLubricator,
  detail: cc5ChainLubricatorData,
)
```

The `detail` property connects the catalog product to its configuration
definition.

---

# Why the Architecture Was Changed

The previous architecture required separate configuration pages for many
products.

With a large catalog this caused:

- Repeated form code
- Repeated validation
- Repeated dropdown logic
- Product-specific navigation code
- More files to maintain
- More changes when adding common functionality

The new architecture separates:

```text
Product Data
     ↓
What the product requires

Common Form
     ↓
How the configuration is displayed and processed
```

This allows common functionality to be implemented once and reused across
the product catalog.

---

# Product Catalog

The application contains three main product/application groups:

```text
Application Catalog
│
├── Industrial
├── Protein
└── Technician
```

Current total:

```text
Industrial     76
Protein         2
Technician      1
-----------------
Total          79
```

---

# Industrial Catalog

Industrial contains:

```text
11 Main Categories
76 Configurable Products
```

The current main categories are:

1. CC5 Chain
2. 9125/9126 Caterpillar Drive
3. Enclosed Track Inverted Power Only and PF
4. Enclosed Track Overhead Power Only and P&F
5. Flat Top
6. Free Carrier
7. C Channel Overhead Or Inverted
8. In Floor Tow Line
9. In-Board Roller Chain
10. Over Head Power Rail L-Beam
11. Power and Free Overhead Or Inverted

Industrial products can use hierarchical navigation.

Typical structure:

```text
Industrial
    ↓
Main Category
    ↓
Solution Type
    ↓
Product
```

Common solution types include:

```text
Conveyor Cleaning Solutions
Conveyor Greaser Systems
Conveyor Lubrication Systems
Conveyor Monitor Systems
```

Some Industrial categories also contain direct products.

---

# Protein Catalog

Protein currently contains two direct configurable products:

```text
Protein
│
├── Food Grade Cleaner OP-8SS
│
└── Food Grade Lubrication and Monitor
```

Unlike most Industrial products, there is currently no intermediate
category/sub-category level.

Both products use the common Product Configurator architecture.

---

# Technician

Technician currently contains one configurable item:

```text
Technician
│
└── Technician Note
```

---

# Product Data Architecture

Product-specific configuration definitions are stored in data files.

Conceptually:

```text
features/
└── products/
    └── data/
        ├── industrial_catalog.dart
        ├── protein_catalog.dart
        │
        └── product_details/
            ├── Industrial(76)/
            └── Protein/
```

Each product data file can define:

- Product information
- Configuration sections
- Text fields
- Dropdown fields
- Dropdown options
- Required fields
- Optional fields
- Conditional fields
- Dependent fields
- Reference images
- Measurement images
- Image-upload requirements

The product data describes **what** needs to be collected.

`ProductConfigurationForm` controls **how** the form behaves.

---

# Reusable Product Configuration Form

The common:

```text
ProductConfigurationForm
```

handles shared configuration functionality.

It currently supports:

- Dynamic form generation
- Text fields
- Dropdown fields
- Required validation
- Optional fields
- Conditional fields
- Dependent fields
- `Other` option handling
- Custom values
- Quantity selection
- Reference images
- Measurement images
- Customer image selection
- Image preview
- Image removal
- Image upload
- Configuration submission

This functionality no longer needs to be reimplemented separately for
every product.

---

# Required Field Validation

Required fields are defined by product data.

Example:

```dart
ProductFieldData(
  key: 'conveyorName',
  label: 'Conveyor Name',
  type: ProductFieldType.text,
  required: true,
)
```

The common form validates visible required fields before the configuration
is submitted.

---

# Conditional Fields

Fields can depend on another field.

Example:

```text
Parent Question
      ↓
Specific Selection
      ↓
Additional Field Appears
```

When the controlling value changes and a dependent field is no longer
applicable, its hidden value is cleared.

This prevents stale hidden configuration data from being submitted.

---

# Other Option Handling

Dropdowns can support:

```text
Other
```

When `Other` is selected, the user can enter a custom value.

Example:

```text
Manufacturer

Daifuku
Frost
Rapid
Other
```

If the user enters:

```text
Custom Manufacturer
```

the submitted value becomes:

```text
Custom Manufacturer
```

instead of the literal value:

```text
Other
```

Backend validation must therefore allow custom values for fields that
support `Other`.

---

# Quantity

Quantity is handled by the common Product Configurator.

Minimum quantity:

```text
1
```

The quantity is submitted together with the product configuration.

---

# Static Product / Measurement Images

Static images are stored as Flutter assets.

They are used for:

- Product images
- Product-category images
- Reference images
- Measurement diagrams

Reference and measurement images can be previewed from the configuration
form.

These images are separate from customer-uploaded images.

---

# Customer Image Upload

Customer image upload support has been added to applicable configuration
fields.

Flow:

```text
Select Image
    ↓
Preview / Remove
    ↓
Upload Image
    ↓
Receive Permanent File Metadata
    ↓
Add Metadata to Configuration
    ↓
Submit Configuration
```

The application does **not** store local device image paths.

For example, local paths such as:

```text
/data/user/.../image.jpg
```

must not be persisted.

Instead, configuration data stores permanent uploaded-file metadata.

Example:

```json
{
  "objectKey": "product-configurations/.../image.jpg",
  "originalName": "factory.jpg",
  "contentType": "image/jpeg",
  "size": 123456
}
```

---

# Image Upload Architecture

Image upload is separated from the product configuration UI.

```text
ProductConfigurationForm
        ↓
ImageUploadService
        ↓
ApiClient.postMultipart()
        ↓
Backend Upload API
        ↓
Object Storage
```

The multipart request sends:

```text
image
projectKey
```

The backend uses the authenticated user and project/product information
to organize the uploaded object.

---

# Image Upload Failure Handling

If an image upload fails, the user can choose:

```text
Try Again
```

or:

```text
Add Without Image
```

Retry only retries the failed image.

Previously successful image uploads are preserved and are not uploaded
again unnecessarily.

---

# Supported Image Types

Multipart image upload supports:

```text
JPG / JPEG
PNG
WEBP
```

Expected MIME types:

```text
.jpg / .jpeg → image/jpeg
.png         → image/png
.webp        → image/webp
```

The frontend explicitly sends the image MIME type with the multipart
request.

---

# Product Configuration Flow

The current product flow is:

```text
Open Application Catalog
        ↓
Select Application
        ↓
Select Category / Product
        ↓
Load ProductDetailData
        ↓
Open ProductConfigurationForm
        ↓
Generate Dynamic Fields
        ↓
Enter Configuration
        ↓
Validate Required Fields
        ↓
Upload Selected Images
        ↓
Collect Configuration Data
        ↓
Select Quantity
        ↓
ProductRepository
        ↓
ProductApiService
        ↓
Backend
```

---

# API Architecture

API/networking responsibilities are separated from product UI.

```text
UI
 ↓
Repository
 ↓
API Service
 ↓
ApiClient
 ↓
Backend
```

The product ID is used to route the configuration to the corresponding
backend API.

This keeps HTTP implementation outside product data definitions and
configuration UI.

---

# API Debug Logging

Detailed API logging is available during development/testing.

Logging can include:

- HTTP method
- URL
- Sanitized headers
- Request data
- Multipart information
- Response status
- Response body
- Request duration
- Errors

Sensitive information is masked/excluded from detailed logs.

Examples:

```text
Authorization
Token
Session
Password
Secret
```

Production should not rely on detailed development logging.

---

# Authentication

The application supports:

- Login
- Account creation
- Logout
- Forgot password
- Security PIN validation
- Password reset
- Session validation
- User role handling

Session information is stored locally where required and backend session
validation is used during authenticated application flows.

---

# Account Creation

Account creation includes validation for user information and password
requirements.

Password rules include:

- Minimum 8 characters
- Uppercase letter
- Lowercase letter
- Number
- Special character
- Confirm password match

---

# Cart Flow

Configured products are added to the common configurator/cart workflow.

```text
Product
   ↓
Configuration
   ↓
Add to Configurator
   ↓
Cart
   ↓
Finalize Configuration
```

Quantity and product configuration data are maintained as part of the
configuration item.

---

# Draft Functionality

Users can save unfinished work as drafts.

Drafts support:

- Load
- View
- Restore
- Delete

The newer draft structure uses concepts including:

```text
draftID
items
quantity
createdAt
```

Draft restoration returns the user to the configuration/cart workflow.

---

# Final Configuration

Users can finalize configured cart items into saved configurations.

Typical user flow:

```text
Select Product
      ↓
Configure Product
      ↓
Add to Cart
      ↓
Continue Configuring
      ↓
Save Draft
      OR
Finalize
      ↓
Saved Configuration
```

---

# Admin Dashboard

The application includes an Admin Dashboard for configuration and user
management.

Admin route:

```text
/admin
```

Admin access is restricted to authorized Admin users.

---

# Admin Configuration Table

The updated configuration table focuses on:

```text
Configuration Name

Product

Quantity

Configuration Dates

Completion Date

Admin Status

Actions
```

This keeps the table focused on the most useful configuration information.

---

# Configuration Dates

Configuration lifecycle dates are grouped together.

The Configuration Dates section contains:

```text
Created
Updated
Submitted
```

Completion Date is displayed separately.

---

# Admin Configuration Actions

Admin actions include:

```text
View
Edit
Delete
```

The View action opens detailed configuration information.

---

# Admin Workflow

Configuration processing has a separate Admin workflow.

Statuses:

```text
Requested
Pending
Done
```

Admin can move configurations between these statuses.

This workflow is separate from the normal configuration lifecycle status.

---

# Admin Workflow Timestamps

Admin workflow transitions maintain timestamps such as:

```text
adminRequestedAt
adminStartedAt
adminCompletedAt
```

Conceptually:

```text
Requested
    ↓
adminRequestedAt

Pending
    ↓
adminStartedAt

Done
    ↓
adminCompletedAt
```

---

# Pending Duration

Pending duration starts from the actual time the configuration enters:

```text
Pending
```

The timer uses:

```text
adminStartedAt
```

It does not use the original configuration creation time.

If a configuration leaves Pending and later returns to Pending, a new
Pending timing period starts.

---

# Admin Image Support

The Admin Dashboard detects customer-uploaded image metadata stored inside
configuration data.

When images are available, Admin can see an attached-image indicator/count.

Example:

```text
Configuration Name          Images

Conveyor Configuration      📷 2
```

Admin can open the images directly from the configuration interface.

---

# Admin Image Preview

Admin image functionality supports:

- Attached-image count
- Image gallery
- Thumbnail
- Larger image preview

Uploaded objects are private.

Permanent public image URLs are not stored.

When an Admin needs to view an image:

```text
Admin
   ↓
Request Image
   ↓
Backend
   ↓
Temporary Signed URL
   ↓
Display Image
```

Signed URLs are temporary and should never be stored in configuration
data.

---

# Admin User Management

Admin user functionality includes:

- Load users
- Search/filter users where supported
- View user information
- Edit user information
- Change role
- Reset password
- Delete user

Admin layouts support desktop/table and smaller-screen presentation where
applicable.

---

# Old vs New Architecture

| Previous Architecture | Current Architecture |
| --- | --- |
| Dedicated product pages | Common `ProductConfigurationForm` |
| Product-specific forms | Data-driven forms |
| Repeated field UI | Shared field rendering |
| Repeated validation | Centralized validation |
| Product-specific navigation | `ProductItem.detail` |
| Product data mixed with UI | Product data separated from UI |
| Common changes required many files | Common behavior changed centrally |
| No shared customer image workflow | Common image-upload workflow |
| API logic closer to individual flows | Repository/API service architecture |
| Harder to maintain large catalog | Architecture designed for 79 products |

---

# Current Project Structure

The migrated frontend is conceptually organized as:

```text
lib/
│
├── main.dart
│
├── core/
│   │
│   ├── constants/
│   │   └── app_assets.dart
│   │
│   └── network/
│       ├── api_client.dart
│       ├── api_endpoints.dart
│       ├── api_response.dart
│       │
│       └── Services/
│           └── image_upload_service.dart
│
├── features/
│   │
│   ├── products/
│   │   │
│   │   ├── data/
│   │   │   ├── industrial_catalog.dart
│   │   │   ├── protein_catalog.dart
│   │   │   │
│   │   │   └── product_details/
│   │   │       ├── Industrial(76)/
│   │   │       └── Protein/
│   │   │
│   │   └── models/
│   │       └── product_item.dart
│   │
│   ├── product_configurator/
│   │   │
│   │   └── screens/
│   │       └── product_configuration_form.dart
│   │
│   ├── cart/
│   ├── admin/
│   └── ...
│
└── ...
```

The important architectural separation is:

```text
Catalog
    → Navigation / Product Hierarchy

ProductDetailData
    → Product-Specific Fields

ProductConfigurationForm
    → Common Form UI / Behavior

Repository
    → Data Access

API Service
    → Product/API Operations

ApiClient
    → HTTP / Multipart / Logging

Backend
    → Validation / Persistence / Storage
```

---

# Adding a New Product

For most new products:

```text
1. Add product to the correct catalog

2. Create ProductDetailData

3. Define configuration sections

4. Define fields

5. Define required/optional behavior

6. Define conditional fields if required

7. Connect using ProductItem.detail

8. Add/verify product ID

9. Add/verify API mapping

10. Make sure backend field names match frontend keys

11. Test submission
```

Do **not** create another dedicated configuration page when the requirement
can be handled by the reusable configurator.

---

# Updating an Existing Product

Most product changes should only require updating its data definition.

Examples:

```text
Add Field
Remove Field
Change Label
Change Dropdown Options
Change Required Status
Add Conditional Field
Add Reference Image
Add Measurement Image
Add Customer Image Requirement
```

Change `ProductConfigurationForm` only when the behavior should be shared
or supported across products.

---

# Frontend / Backend Field Contract

Frontend field keys and backend model fields must remain aligned.

For example:

Frontend:

```dart
key: 'wheelOpenType'
```

Backend:

```javascript
wheelOpenType
```

Avoid using different names for the same field between frontend and
backend.

---

# Backend Validation for Other Values

When a frontend dropdown contains:

```text
Other
```

the frontend can replace `Other` with arbitrary user-entered text.

Therefore, the backend should not use a restrictive enum for that field
unless the architecture explicitly stores custom values separately.

Do not create additional fields such as:

```text
otherManufacturer
otherChainSize
```

unless the frontend actually sends those fields.

---

# Image Storage Rules

Always follow these rules:

```text
DO NOT store local device image paths.

DO NOT persist temporary signed URLs.

STORE permanent objectKey and image metadata.

GENERATE signed URLs only when viewing private images.

KEEP customer uploads separate from static Flutter assets.
```

---

# Development Setup

Install Flutter dependencies:

```bash
flutter pub get
```

Run locally:

```bash
flutter run
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

---

# Local Backend Development

The local backend normally runs on:

```text
http://localhost:8080
```

For Android development using ADB reverse:

```bash
adb reverse tcp:8080 tcp:8080
```

When multiple devices are connected:

```bash
adb -s <device-id> reverse tcp:8080 tcp:8080
```

The Flutter app can then use:

```text
http://localhost:8080
```

for the backend on the forwarded Android device.

---

# Release Backend

Production backend:

```text
https://configurator-67eol.sevalla.app
```

Production API:

```text
https://configurator-67eol.sevalla.app/api
```

Environment-specific URLs should remain centralized in the application
environment/network configuration.

Do not hard-code production URLs inside product configuration files.

---

# Build Commands

Android APK:

```bash
flutter build apk --release
```

Android App Bundle:

```bash
flutter build appbundle --release
```

Always verify the current version/build number before creating a release.

---

# Security Notes

Never commit sensitive credentials to Git.

Do not commit:

```text
API Secrets
Access Tokens
Object Storage Secret Keys
Database Passwords
Private Certificates
Production .env Files
Signing Passwords
```

Private repository access does not replace proper secret management.

---

# Notes for the Next Engineer

When working on this project:

1. Keep product-specific configuration inside product data files.
2. Keep shared form behavior inside `ProductConfigurationForm`.
3. Avoid creating duplicate product-specific screens.
4. Keep frontend and backend field names synchronized.
5. Keep API/networking logic outside product data files.
6. Keep required validation synchronized with backend validation.
7. Remember that `Other` can become custom user text.
8. Never persist local image paths.
9. Never persist temporary signed URLs.
10. Keep static assets and customer uploads separate.
11. Keep configuration lifecycle status and Admin workflow status separate.
12. Add common functionality centrally whenever possible.

---

# Current Migration Result

The frontend has moved from a collection of product-specific configuration
pages to a reusable Product Configurator architecture supporting:

```text
76 Industrial Products
 2 Protein Products
 1 Technician Item
----------------------
79 Configurable Items
```

The current architecture now provides:

- Data-driven product configuration
- Reusable product forms
- Centralized validation
- Conditional fields
- Dependent fields
- `Other` custom-value handling
- Quantity management
- Product/reference images
- Measurement images
- Customer image uploads
- Upload retry/skip handling
- Permanent image metadata
- Multipart API support
- Repository/API service separation
- Development API logging
- Cart integration
- Draft management
- Final configurations
- Admin configuration management
- Admin user management
- Requested / Pending / Done workflow
- Admin workflow timestamps
- Pending-duration tracking
- Customer-image indicators
- Private image access through signed URLs

The main development principle going forward is:

> **Product-specific data belongs in product data files. Common behavior
> belongs in the reusable configuration architecture.**