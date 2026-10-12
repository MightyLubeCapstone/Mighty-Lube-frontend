
import 'package:flutter/material.dart';
import '../../../core/widget/header_logo.dart';
import '../../app_version/manager/app_version_manager.dart';
import '../controllers/login_controller.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
const LoginPage({
super.key,
});

@override
State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController usernameController =
TextEditingController();

final TextEditingController passwordController =
TextEditingController();

bool usererror = false;
bool passerror = false;

bool loading = false;
bool rememberedLoginLoading = false;

bool rememberAccount = true;

String _frontendVersion = '...';

Future<void> _loadVersionLabels() async {
final result = await const AppVersionManager().checkForUpdates();
if (!mounted) return;
setState(() {
_frontendVersion = result.frontendVersion;
});
}

List<Map<String, dynamic>> rememberedAccounts = <Map<String, dynamic>>[];
String? rememberedLoginUsername;

@override
void initState() {
super.initState();

_loadRememberedAccounts();
_loadVersionLabels();
}

// =========================================================
// LOAD REMEMBERED ACCOUNTS
//
// Maximum 5 accounts are returned by the service.
// The service keeps them in oldest -> newest order.
// =========================================================

Future<void> _loadRememberedAccounts() async {
final accounts = await LoginController.getRememberedAccounts();

if (!mounted) {
return;
}

setState(() {
rememberedAccounts = accounts;
});
}

// =========================================================
// NORMAL LOGIN
// =========================================================

Future<void> login() async {
if (loading || rememberedLoginLoading) {
return;
}

final username =
usernameController.text.trim().toLowerCase();

// Password remains case-sensitive.
// Do NOT trim/lowercase/uppercase.
final password = passwordController.text;

setState(() {
usererror = false;
passerror = false;
});

if (username.isEmpty || password.isEmpty) {
setState(() {
usererror = username.isEmpty;
passerror = password.isEmpty;
});

showError(
context,
'Please enter a username and password',
);

return;
}

setState(() {
loading = true;
});

final result = await LoginController.login(
username: username,
password: password,
rememberAccount: rememberAccount,
);

if (!mounted) {
return;
}

if (result.success) {
_openDestination(
isAdmin: result.isAdmin,
);

return;
}

setState(() {
loading = false;
usererror = true;
passerror = true;
});

showError(
context,
result.message ??
'Incorrect username or password',
);
}

// =========================================================
// CONTINUE WITH REMEMBERED ACCOUNT
//
// No password is required here.
//
// Backend validates the selected account's 30-day remember
// token and creates a NEW normal 12-hour session.
// =========================================================

Future<void> _continueWithRememberedAccount(
String username,
) async {
if (loading || rememberedLoginLoading) {
return;
}

setState(() {
rememberedLoginLoading = true;
rememberedLoginUsername = username;
usererror = false;
passerror = false;
});

final result =
await LoginController.continueWithRememberedAccount(
username: username,
);

if (!mounted) {
return;
}

if (result.success) {
_openDestination(
isAdmin: result.isAdmin,
);

return;
}

// If the token is no longer usable, the service removes the
// invalid local entry when appropriate. Reload the list so
// other remembered accounts remain available.
await _loadRememberedAccounts();

if (!mounted) {
return;
}

setState(() {
rememberedLoginLoading = false;
rememberedLoginUsername = null;
});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
result.message ??
'Please login with your username and password.',
),
),
);
}

// =========================================================
// FORGET REMEMBERED ACCOUNT
//
// Removes only the selected remembered account.
// Other remembered accounts remain available.
// =========================================================

Future<void> _forgetRememberedAccount(
String username,
) async {
if (loading || rememberedLoginLoading) {
return;
}

setState(() {
rememberedLoginLoading = true;
rememberedLoginUsername = username;
});

final removed =
await LoginController.forgetRememberedAccount(
username: username,
);

if (!mounted) {
return;
}

if (removed) {
await _loadRememberedAccounts();
}

if (!mounted) {
return;
}

setState(() {
rememberedLoginLoading = false;
rememberedLoginUsername = null;
});

if (!removed) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Unable to forget this account. Please try again.',
),
),
);
}
}

// =========================================================
// NAVIGATION
// =========================================================

void _openDestination({
required bool isAdmin,
}) {
Navigator.pushNamedAndRemoveUntil(
context,
isAdmin ? '/admin' : '/dashboard',
(route) => false,
);
}

// =========================================================
// ERROR
// =========================================================

void showError(
BuildContext context,
String message,
) {
showDialog(
context: context,
builder: (context) => AlertDialog(
title: const Text(
'Login Error',
),
content: Text(
message,
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text(
'OK',
),
),
],
),
);
}

// =========================================================
// DISPOSE
// =========================================================

@override
void dispose() {
usernameController.dispose();
passwordController.dispose();

super.dispose();
}

// =========================================================
// BUILD
// =========================================================

@override
Widget build(BuildContext context) {
final isCompactMobile = MediaQuery.sizeOf(context).width < 600;
if (loading) {
return const Scaffold(
body: Center(
child: CircularProgressIndicator(),
),
);
}

return Scaffold(
backgroundColor: const Color(
0xFFF3F4F6,
),
body: Column(
crossAxisAlignment:
CrossAxisAlignment.stretch,
children: [
const HeaderLogo(
pressable: false,
),

SizedBox(
height: isCompactMobile ? 7.0 : 10.0,
),

Expanded(
child: Center(
child: Container(
constraints: const BoxConstraints(
maxWidth: 520,
),
padding: EdgeInsets.all(isCompactMobile ? 16 : 20),
margin: EdgeInsets.symmetric(
horizontal: isCompactMobile ? 12 : 20,
vertical: isCompactMobile ? 10 : 20,
),
decoration: BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(
20,
),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(
alpha: 0.1,
),
spreadRadius: 5,
blurRadius: 15,
offset: const Offset(
0,
10,
),
),
],
),
child: SingleChildScrollView(
child: Column(
mainAxisSize:
MainAxisSize.min,
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
// =====================================
// TITLE
// =====================================

Center(
child: Text(
'Welcome Back!',
style: TextStyle(
fontSize: isCompactMobile ? 22 : 24,
fontWeight:
FontWeight.bold,
color: Colors.black,
letterSpacing: 1.2,
),
),
),

SizedBox(
height: isCompactMobile ? 7.0 : 10.0,
),

const Center(
child: Text(
'Login to your account',
style: TextStyle(
fontSize: 16,
color: Colors.grey,
),
),
),

// =====================================
// CONTINUE AS
// =====================================

if (rememberedAccounts.isNotEmpty) ...[
SizedBox(
height: isCompactMobile ? 16.0 : 25.0,
),

const Text(
'Continue as',
style: TextStyle(
fontSize: 14,
fontWeight:
FontWeight.w600,
color: Colors.black87,
),
),

SizedBox(
height: isCompactMobile ? 7 : 10,
),

...rememberedAccounts.reversed.map(
(account) => Padding(
padding: EdgeInsets.only(
bottom: isCompactMobile ? 7 : 10,
),
child: _buildRememberedAccountCard(
account,
),
),
),

SizedBox(
height: isCompactMobile ? 6 : 8,
),

// =================================
// OR DIVIDER
//
// Intentionally kept.
// =================================

Row(
children: [
Expanded(
child: Divider(
color:
Colors.grey[300],
),
),
const Padding(
padding:
EdgeInsets.symmetric(
horizontal: 12,
),
child: Text(
'OR',
style: TextStyle(
fontSize: 12,
color:
Colors.grey,
fontWeight:
FontWeight.w600,
),
),
),
Expanded(
child: Divider(
color:
Colors.grey[300],
),
),
],
),
],

SizedBox(
height: isCompactMobile ? 12.0 : 20.0,
),

// =====================================
// USERNAME
// =====================================

const Text(
'Username:',
style: TextStyle(
color: Colors.black,
fontWeight:
FontWeight.w500,
),
),

SizedBox(
height: isCompactMobile ? 6.0 : 8.0,
),

TextField(
controller:
usernameController,
textInputAction:
TextInputAction.next,
autocorrect: false,
enableSuggestions: false,
onChanged: (_) {
if (usererror) {
setState(() {
usererror = false;
});
}
},
decoration: InputDecoration(
border:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
),
enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
borderSide:
BorderSide(
color: usererror
? Colors.red
    : Colors.grey,
),
),
focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
borderSide:
BorderSide(
color: usererror
? Colors.red
    : Colors.blueAccent,
),
),
contentPadding:
EdgeInsets.symmetric(
horizontal: 15,
vertical: isCompactMobile ? 13 : 18,
),
filled: true,
fillColor:
Colors.grey[100],
hintText:
'Enter username',
prefixIcon:
const Icon(
Icons.person_outline,
),
),
),

SizedBox(
height: isCompactMobile ? 12.0 : 20.0,
),

// =====================================
// PASSWORD
// =====================================

const Text(
'Password:',
style: TextStyle(
color: Colors.black,
fontWeight:
FontWeight.w500,
),
),

SizedBox(
height: isCompactMobile ? 6.0 : 8.0,
),

TextField(
controller:
passwordController,
obscureText: true,
textInputAction:
TextInputAction.done,
autocorrect: false,
enableSuggestions: false,
onSubmitted: (_) {
login();
},
onChanged: (_) {
if (passerror) {
setState(() {
passerror = false;
});
}
},
decoration: InputDecoration(
border:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
),
enabledBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
borderSide:
BorderSide(
color: passerror
? Colors.red
    : Colors.grey,
),
),
focusedBorder:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
12,
),
borderSide:
BorderSide(
color: passerror
? Colors.red
    : Colors.blueAccent,
),
),
contentPadding:
EdgeInsets.symmetric(
horizontal: 15,
vertical: isCompactMobile ? 13 : 18,
),
filled: true,
fillColor:
Colors.grey[100],
hintText:
'Enter password',
prefixIcon:
const Icon(
Icons.lock_outline,
),
),
),

const SizedBox(
height: 6,
),

// =====================================
// REMEMBER ACCOUNT
// =====================================
Row(
children: [
Checkbox(
value: rememberAccount,
onChanged: (value) {
setState(() {
rememberAccount = value ?? false;
});
},
),
const Expanded(
child: Text(
'Remember this account',
style: TextStyle(
fontSize: 13,
color: Colors.black87,
),
),
),
],
),

// =====================================
// ACCOUNT RECOVERY
// =====================================
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Flexible(
child: TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const ForgotPasswordPage(
mode: AccountRecoveryMode.username,
),
),
);
},
child: const Text(
'Forgot Username?',
style: TextStyle(
color: Colors.blueAccent,
fontSize: 13,
),
),
),
),
Flexible(
child: TextButton(
onPressed: () {
Navigator.pushNamed(
context,
'/forgot_password',
);
},
child: const Text(
'Forgot Password?',
style: TextStyle(
color: Colors.blueAccent,
fontSize: 13,
),
),
),
),
],
),

SizedBox(
height: isCompactMobile ? 12.0 : 20.0,
),

// =====================================
// LOGIN
// =====================================

Container(
width: double.infinity,
decoration: BoxDecoration(
borderRadius:
BorderRadius.circular(
12,
),
gradient:
const LinearGradient(
colors: [
Colors.blueAccent,
Colors.lightBlueAccent,
],
begin:
Alignment.topLeft,
end:
Alignment.bottomRight,
),
),
child: TextButton(
onPressed:
rememberedLoginLoading
? null
    : login,
child: const Text(
'Login',
style: TextStyle(
fontSize: 16,
color: Colors.white,
fontWeight:
FontWeight.bold,
),
),
),
),

SizedBox(
height: isCompactMobile ? 7.0 : 10.0,
),

// =====================================
// CREATE ACCOUNT
// =====================================

Container(
width: double.infinity,
decoration: BoxDecoration(
borderRadius:
BorderRadius.circular(
12,
),
gradient:
const LinearGradient(
colors: [
Colors.blueAccent,
Colors.lightBlueAccent,
],
begin:
Alignment.topLeft,
end:
Alignment.bottomRight,
),
),
child: TextButton(
onPressed:
rememberedLoginLoading
? null
    : () {
Navigator.pushNamed(
context,
'/create_account',
);
},
child: const Text(
'Create Account',
style: TextStyle(
fontSize: 16,
color: Colors.white,
fontWeight:
FontWeight.bold,
),
),
),
),
],
),
),
),
),
),
// Compact version text outside the login form.
SafeArea(
top: false,
child: Padding(
padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
child: Text(
'Version $_frontendVersion',
textAlign: TextAlign.center,
maxLines: 2,
softWrap: true,
style: const TextStyle(
fontSize: 12,
fontWeight: FontWeight.w600,
color: Color(0xFF30343B),
),
),
),
),
],
),
);
}

// =========================================================
// REMEMBERED ACCOUNT CARD
//
// The newest remembered account is shown first.
// User and Admin accounts can both be displayed.
// =========================================================

Widget _buildRememberedAccountCard(
Map<String, dynamic> account,
) {
final username =
account['username']?.toString().trim() ?? '';

final role =
account['role']?.toString().trim().toLowerCase() ??
'user';

final initial = username.isNotEmpty
? username[0].toUpperCase()
    : '?';

final isThisAccountLoading =
rememberedLoginLoading &&
rememberedLoginUsername == username;

return Container(
decoration: BoxDecoration(
color: Colors.grey[50],
borderRadius: BorderRadius.circular(
12,
),
border: Border.all(
color: Colors.grey.shade300,
),
),
child: Material(
color: Colors.transparent,
child: InkWell(
borderRadius: BorderRadius.circular(
12,
),
onTap: rememberedLoginLoading
? null
    : () {
_continueWithRememberedAccount(
username,
);
},
child: Padding(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 10,
),
child: Row(
children: [
CircleAvatar(
radius: 20,
backgroundColor:
Colors.blueAccent.withValues(
alpha: 0.12,
),
child: Text(
initial,
style: const TextStyle(
color: Colors.blueAccent,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(
width: 12,
),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Row(
children: [
Expanded(
child: Text(
username,
maxLines: 1,
overflow:
TextOverflow.ellipsis,
style: const TextStyle(
fontSize: 15,
fontWeight:
FontWeight.w600,
color: Colors.black87,
),
),
),

const SizedBox(
width: 8,
),

Container(
padding:
const EdgeInsets.symmetric(
horizontal: 7,
vertical: 3,
),
decoration: BoxDecoration(
color: Colors.blueAccent
    .withValues(
alpha: 0.08,
),
borderRadius:
BorderRadius.circular(
20,
),
),
child: Text(
role == 'admin'
? 'Admin'
    : 'User',
style: const TextStyle(
fontSize: 10,
fontWeight:
FontWeight.w600,
color: Colors.blueAccent,
),
),
),
],
),

const SizedBox(
height: 2,
),

Text(
isThisAccountLoading
? 'Signing in...'
    : 'Tap to continue',
style: const TextStyle(
fontSize: 12,
color: Colors.grey,
),
),
],
),
),

if (isThisAccountLoading)
const SizedBox(
width: 20,
height: 20,
child: CircularProgressIndicator(
strokeWidth: 2,
),
)
else ...[
IconButton(
tooltip: 'Forget this account',
onPressed: rememberedLoginLoading
? null
    : () {
_forgetRememberedAccount(
username,
);
},
icon: const Icon(
Icons.close,
size: 19,
color: Colors.grey,
),
),

const Icon(
Icons.chevron_right,
color: Colors.grey,
),
],
],
),
),
),
),
);
}
}