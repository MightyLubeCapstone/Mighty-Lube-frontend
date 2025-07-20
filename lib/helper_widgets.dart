import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:async';

class CommonWidgets {
  // Nice looking button
  static Widget buildGradientButton(BuildContext context, String title, Widget content,
      {bool isError = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isError ? Colors.red : Colors.white.withOpacity(0.8),
          width: 2,
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF3F4F6), Color(0xFFE0E4E7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: FractionallySizedBox(
                heightFactor: 0.90,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        content,
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  // Section title
  static Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // Line divider
  static Widget buildSectionDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
      height: 30,
    );
  }

  static Widget buildDropdownFieldError<T>(
      String label, List<String> options, int? dropdownSelection, Function(dynamic) onChanged,
      {String? errorText, bool? isEditable = true}) {
    String? assessedValue;

    if (dropdownSelection != null && dropdownSelection > 0 && dropdownSelection <= options.length) {
      assessedValue = options[dropdownSelection - 1];
    }

    OutlineInputBorder borderStyle(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
          width: 2.0, // Explicitly set width to match TextField
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: (isEditable ?? false) ? null : () {}, // Ensure isEditable is not null
        behavior: HitTestBehavior.opaque, // Prevents taps from propagating
        child: AbsorbPointer(
          absorbing: !(isEditable ?? false), // Ensure isEditable is not null
          child: DropdownButtonFormField<String>(
            value: assessedValue,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.black),
              border: borderStyle(Colors.grey),
              enabledBorder: borderStyle(Colors.grey),
              focusedBorder: borderStyle(Colors.grey),
              errorBorder: borderStyle(Colors.red),
              focusedErrorBorder: borderStyle(Colors.red),
              errorText: errorText, // No need for `!`, it's nullable already
            ),
            items: options
                .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                    ))
                .toList(),
            onChanged: (isEditable ?? false)
                ? (value) {
                    if (value != null) {
                      onChanged(options.indexOf(value) + 1);
                    }
                  }
                : null, // Prevents value change
          ),
        ),
      ),
    );
  }

  // Dropdown list
  static Widget buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: options
            .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: (value) {
          // if (value != null) {
          //   if (dropdownSelection.runtimeType == bool) {
          //     (value == "Yes"
          //         ? dropdownSelection = true
          //         : dropdownSelection = false);
          //   } else if (dropdownSelection.runtimeType == int) {
          //     // number range
          //     dropdownSelection = options.indexOf(value) + 1;
          //   }
          // }
        },
      ),
    );
  }

  // Configurator Button with Counter
  static Widget buildConfiguratorWithCounter({void Function(int)? callback}) {
    return _ConfiguratorWithCounter(
      callback: callback,
    );
  }

  // Configurator Button with Counter
  static Widget buildCounter(int numRequested, {void Function(int)? callback}) {
    return _Counter(
      callback: callback,
      initialValue: numRequested,
    );
  }

  // Text Field
  static Widget buildTextField(String hintText, TextEditingController controller,
      {String? errorText, bool isEditable = true, Function(String)? callback}) {
    OutlineInputBorder borderStyle(Color color) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
          width: 2.0, // Explicitly set width to match TextField
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        onChanged: (value) => {
          if (callback != null) {callback(value)}
        },
        enabled: isEditable,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.black),
          border: borderStyle(Colors.grey),
          enabledBorder: borderStyle(Colors.grey),
          focusedBorder: borderStyle(Colors.grey),
          errorBorder: borderStyle(Colors.red), // Ensure error thickness matches
          focusedErrorBorder: borderStyle(Colors.red), // Ensure when focused with error
          errorText: errorText,
        ),
      ),
    );
  }

  // Breadcrumb nav
  static Widget buildBreadcrumbNavigation(
      BuildContext context, String text, Widget page, String text2, Widget page2) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.blue),
            onPressed: () {
              // Navigate to the home page dynamically
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          ),
          const SizedBox(width: 8), // Spacing
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 8), // Spacing
          GestureDetector(
            onTap: () {
              // Navigate to the second page dynamically
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page2),
              );
            },
            child: Text(
              text2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fun image stuff
  static Widget buildImageDisplayEnhanced(
    ImageProvider imageProvider, {
    double width = 300,
    double height = 300,
    BoxFit fit = BoxFit.contain,
    double borderRadius = 12,
    Color backgroundColor = const Color(0xFFF3F4F6),
    double shadowStrength = 0.2,
    bool fullWidth = false,
    double aspectRatio = 1.3,
    bool enableZoom = false,
    BuildContext? context, // required for zoom modal
  }) {
    final Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: imageProvider,
              fit: fit,
              filterQuality: FilterQuality.high,
            ),
          ),
          // Zoom hint icon
          if (enableZoom)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );

    Widget tappableImage = enableZoom && context != null
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    body: Center(
                      child: PhotoView(
                        imageProvider: imageProvider,
                        backgroundDecoration: const BoxDecoration(color: Colors.black),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2.5,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: imageWidget,
          )
        : imageWidget;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(8),
      width: fullWidth ? double.infinity : width,
      height: fullWidth ? null : height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(shadowStrength),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: fullWidth
          ? AspectRatio(
              aspectRatio: aspectRatio,
              child: tappableImage,
            )
          : tappableImage,
    );
  }

  // More fun image stuff - but just for the measurements tab
  static Widget buildMeasurementFieldWithImage({
    required BuildContext context,
    required String title,
    required String hintText,
    required String imagePath,
    required TextEditingController controller,
    String? subHint,
    String? errorText, // NEW
    double aspectRatio = 1.2,
    int leftFlex = 3,
    int rightFlex = 3,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Text label + input
            Expanded(
              flex: leftFlex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonWidgets.buildTextField(hintText, controller,
                      errorText: errorText), // Pass error
                  if (subHint != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subHint,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Right: Image
            Expanded(
              flex: rightFlex,
              child: CommonWidgets.buildImageDisplayEnhanced(
                AssetImage(imagePath),
                fullWidth: true,
                aspectRatio: aspectRatio,
                enableZoom: true,
                context: context,
              ),
            ),
          ],
        ),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  // TemplateA Widget
  static Widget buildTemplateA(GlobalKey<TemplateAWidgetState>? key, Validators validators) {
    return TemplateAWidget(dataKey: key, validators: validators);
  }

  // TemplateB Widget
  static Widget buildTemplateB(GlobalKey<TemplateBWidgetState>? key, Validators validators) {
    return TemplateBWidget(dataKey: key, validators: validators);
  }

  // TemplateC Widget
  static Widget buildTemplateC(GlobalKey<TemplateCWidgetState>? key, Validators validators) {
    return TemplateCWidget(dataKey: key, validators: validators);
  }

  // TemplateD Widget
  static Widget buildTemplateD(GlobalKey<TemplateDWidgetState>? key, Validators validators) {
    return TemplateDWidget(dataKey: key, validators: validators);
  }

  // TemplateE Widget for Mighty Lube Caterpillar Drive Lubricators
  static Widget buildTemplateE(GlobalKey<TemplateEWidgetState>? key, Validators validators) {
    return TemplateEWidget(dataKey: key, validators: validators);
  }

  // TemplateF Widget for OP-52
  static Widget buildTemplateF(GlobalKey<TemplateFWidgetState>? key, Validators validators) {
    return TemplateFWidget(dataKey: key, validators: validators);
  }
}

// Internal StatefulWidget for managing the counter state
class _ConfiguratorWithCounter extends StatefulWidget {
  final void Function(int)? callback;
  const _ConfiguratorWithCounter({this.callback});
  @override
  _ConfiguratorWithCounterState createState() => _ConfiguratorWithCounterState();
}

class _ConfiguratorWithCounterState extends State<_ConfiguratorWithCounter> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Counter Section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (itemCount > 1) itemCount--;
                });
              },
              icon: const Icon(Icons.remove_circle_outline, color: Colors.blue, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '$itemCount',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  itemCount++;
                });
              },
              icon: const Icon(Icons.add_circle_outline, color: Colors.blue, size: 30),
            ),
          ],
        ),
        const SizedBox(height: 15),
        // Configurator Button
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              // Add "Add to Configurator" logic here
              if (widget.callback != null) {
                widget.callback!(itemCount);
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'ADD TO CONFIGURATOR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Internal StatefulWidget for managing the counter state
class _Counter extends StatefulWidget {
  final void Function(int)? callback;
  final int initialValue;
  const _Counter({this.callback, required this.initialValue});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      itemCount = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Counter Section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (itemCount > 1) {
                    itemCount--;
                    widget.callback!(itemCount);
                  }
                });
              },
              icon: const Icon(Icons.remove_circle_outline, color: Colors.blue, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '$itemCount',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  itemCount++;
                  widget.callback!(itemCount);
                });
              },
              icon: const Icon(Icons.add_circle_outline, color: Colors.blue, size: 30),
            ),
          ],
        ),
      ],
    );
  }
}

class Validators {
  Map<String, String?> errors = {};
  Map<String, List<String>> sections = {};
  Timer? delay;

  void mapErrors(Map<String, String?> newErrors) {
    errors = newErrors;
  }

  void mapSections(Map<String, List<String>> newSections) {
    sections = newSections;
  }

  bool sectionError(String section) {
    List<String>? fields = sections[section];
    if (fields == null || fields.isEmpty) {
      return false;
    }
    return sections[section]!.any((field) => errors[field] != null);
  }

  void validateTextField(String value, String field) {
    errors[field] = value.trim().isEmpty ? 'This field is required.' : null;
  }

  void validateDropdownField(int? value, String field) {
    errors[field] = (value == null || value == -1) ? 'This field is required.' : null;
  }

  void validatorDelay(String value, String field) {
    if (delay?.isActive ?? false) {
      delay!.cancel();
    }
    // manual delay so its not a constant spam of requirements (hopefully)
    delay = Timer(const Duration(milliseconds: 0), () {
      validateTextField(value, field);
    });
  }

  void onNameOpChanged(name, field) {
    validatorDelay(name, field);
  }

  void onNum247Changed(name, field) {
    validatorDelay(name, field);
  }
}

class TemplateAWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateAWidgetState>? dataKey;
  TemplateAWidget({super.key, this.dataKey, required this.validators});

  @override
  TemplateAWidgetState createState() => TemplateAWidgetState();
}

class TemplateAWidgetState extends State<TemplateAWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};
  final Map<String, bool> _toggles = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
    _toggles.putIfAbsent(name, () => false);
  }

  @override
  void initState() {
    super.initState();
    [
      'internalExistingMonitoring',
      'newMonitoring',
      'addDCU',
      'windowsVersion',
      'headUnitVersion',
      'dcuVersion',
      'piuVersion',
      'addReservoir',
      'reservoirSize',
      'reservoirQty',
      'monitoringType',
      'paintMarkerOnly',
      'driveMotorAmp',
      'driveTakeupAir',
      'takeupDistance',
      'driveMotorTemp',
      'driveMotorVibration',
      'dogPitchValidation',
      'paintMarkerSystem',
      'trolleyDetect',
      'chainVision',
      'upgradeDCUQty1',
      'lubeVision',
      'trolleyVision',
      'addTrolleyDetect',
      'omniView',
      'upgradeDCUQty2',
      'notes',
      'distanceToPIU',
      'distanceSwitchToCTR',
      'distanceAmpPickup',
      'distanceAirTakeup',
      'controllerOptions',
      'operatingVoltage'
    ].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    // Collect toggle values
    _toggles.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSwitch(String title, String key) {
    return SwitchListTile(
      title: Text(title),
      value: _toggles[key]!,
      onChanged: (val) => setState(() => _toggles[key] = val),
    );
  }

  Widget _buildDropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  Widget _buildTextField(String label, String key) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPortable = _dropdowns['monitoringType'] == 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Monitoring Template (A)"),
        _buildSwitch("Connecting to Existing Monitoring", 'internalExistingMonitoring'),
        if (_toggles['internalExistingMonitoring']!) ...[
          _buildTextField("Version of Existing Windows Software (CMS)", 'windowsVersion'),
          _buildTextField("Version of Existing Head Unit Software (CTR)", 'headUnitVersion'),
          _buildTextField("Version of Existing DCU Software", 'dcuVersion'),
          _buildTextField("Version of Existing Power Interface Unit", 'piuVersion'),
        ],
        _buildSwitch("Add New Monitoring System", 'newMonitoring'),
        if (_toggles['newMonitoring']!) ...[
          _buildSwitch("Add DCU?", 'addDCU'),
          if (_toggles['addDCU']!) _buildTextField("DCU Quantity", 'upgradeDCUQty1'),
          _buildSwitch("Adding Reservoir?", 'addReservoir'),
          if (_toggles['addReservoir']!) ...[
            _buildDropdown("Reservoir Size", 'reservoirSize', ["10 Gallon", "65 Gallon", "Other"]),
            _buildDropdown("Reservoir Quantity", 'reservoirQty',
                ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]),
          ],
        ],
        _buildDropdown("Type of Monitoring System", 'monitoringType', ["Permanent", "Portable"]),
        if (isPortable) ...[
          _buildSwitch("Paint Marker", 'paintMarkerOnly'),
        ] else ...[
          _buildSwitch("Drive Motor Amp", 'driveMotorAmp'),
          _buildSwitch("Drive Take-up – Air", 'driveTakeupAir'),
          _buildSwitch("Take-Up Distance", 'takeupDistance'),
          _buildSwitch("Drive Motor Temp", 'driveMotorTemp'),
          _buildSwitch("Drive Motor Vibration", 'driveMotorVibration'),
          _buildSwitch("Dog Pitch Validation", 'dogPitchValidation'),
          _buildSwitch("Paint Marker System", 'paintMarkerSystem'),
          _buildSwitch("Trolley Detect", 'trolleyDetect'),
          _buildSwitch("ChainVision", 'chainVision'),
          if (_toggles['chainVision']!) _buildTextField("Upgrade DCU QTY", 'upgradeDCUQty1'),
          _buildSwitch("LubeVision", 'lubeVision'),
          _buildSwitch("Trolley Vision", 'trolleyVision'),
          if (_toggles['trolleyVision']!) _buildSwitch("Add Trolley Detect", 'addTrolleyDetect'),
          _buildSwitch("OmniView", 'omniView'),
          if (_toggles['omniView']!) _buildTextField("Upgrade DCU QTY", 'upgradeDCUQty2'),
          _buildTextField("Distance to PIU to NGM (add if over 100')", 'distanceToPIU'),
          _buildTextField("Distance Switch to CTR (add if over 100')", 'distanceSwitchToCTR'),
          _buildTextField("Distance from AMP Pickup (add if over 100')", 'distanceAmpPickup'),
          _buildTextField("Distance from Air Take-Up (add if over 100')", 'distanceAirTakeup'),
          _buildTextField("Special Controller Options (I/O Link, Plug and Play, Dry Contacts)",
              'controllerOptions'),
        ],
        _buildTextField("Notes", 'notes'),
        _buildTextField("Operating Voltage - Single Phase (Volts/Hz)", 'operatingVoltage'),
      ],
    );
  }
}

class TemplateBWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateBWidgetState>? dataKey;
  TemplateBWidget({super.key, this.dataKey, required this.validators});

  @override
  State<TemplateBWidget> createState() => TemplateBWidgetState();
}

class TemplateBWidgetState extends State<TemplateBWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};
  final Map<String, bool> _toggles = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
    _toggles.putIfAbsent(name, () => false);
  }

  @override
  void initState() {
    super.initState();
    [
      'nameConveyor',
      'chainManufacturer',
      'wheelManufacturer',
      'speedRange',
      'speedType',
      'tempCondition',
      'mountOrientation',
      'airSupply',
      'operatingVoltage',
      'controlVoltage',
      'connectExistingMonitoring',
      'addNewMonitoring',
      'freeTrolleyWheels',
      'dogActuator',
      'kingPin',
      'currentEquip',
      'currentViscosity',
      'currentGreaseType',
      'currentNLGI',
      'zerkSide',
      'zerkOrientation',
      'wheelDiameter'
    ].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    // Collect toggle values
    _toggles.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String label, String key, {bool multiline = false}) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  Widget _dropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Template B - OPCO Free Rail 314 Wheel Greaser"),
        _field("Name of Conveyor System", 'nameConveyor'),
        _field("Chain Manufacturer", 'chainManufacturer'),
        _field("Wheel Manufacturer", 'wheelManufacturer'),
        _field("Conveyor Speed (Min/Max)", 'speedRange'),
        _dropdown("Speed Type", 'speedType', ['Indexing', 'Variable']),
        CommonWidgets.buildSectionTitle("Application Environment"),
        _dropdown(
            "Temperature of Area", 'tempCondition', ['Below 30°F', 'Above 120°F', 'Normal Range']),
        _dropdown("Mounting Orientation", 'mountOrientation',
            ['Overhead', 'Inverted', 'Inverted/Inverted']),
        CommonWidgets.buildSectionTitle("Customer Power Utilities"),
        _field("Operating Voltage (Volts/Hz)", 'operatingVoltage'),
        _field("Control Voltage (Volts/Hz)", 'controlVoltage'),
        _dropdown("Compressed Air Supply Available?", 'airSupply', ['Yes', 'No']),
        CommonWidgets.buildSectionTitle("Monitoring System"),
        _dropdown("Connect to Existing Monitoring?", 'connectExistingMonitoring', ['Yes', 'No']),
        _dropdown("Add New Monitoring System?", 'addNewMonitoring', ['Yes', 'No']),
        // Can see the "null" giving us MAJOR issues in the future, but one problem at a time...
        if (_dropdowns['addNewMonitoring'] == 1)
          CommonWidgets.buildTemplateA(null, widget.validators),
        CommonWidgets.buildSectionTitle("Conveyor Specifications"),
        _field("Free Trolley Wheels", 'freeTrolleyWheels'),
        _field("Dog Actuator", 'dogActuator'),
        _field("King Pin", 'kingPin'),
        _field("Current Lubrication Equipment (Brand)", 'currentEquip'),
        _field("Current Lubricant Viscosity/Grade", 'currentViscosity'),
        _field("Current Grease Type", 'currentGreaseType'),
        _field("Current Grease NLGI Grade", 'currentNLGI'),
        _dropdown("Zerk Ftg Location (Side)", 'zerkSide', ['Left', 'Right']),
        _field("Zerk Ftg Orientation", 'zerkOrientation'),
        _field("Wheel Diameter", 'wheelDiameter'),
        _field("Does Conveyor/Chain Move Side-to-Side?", 'swayDetect'),
        if (_controllers['currentEquip']!.text.trim().toLowerCase() == 'mighty lube')
          CommonWidgets.buildSectionTitle("Controller Info (Mighty Lube Detected)")
      ],
    );
  }
}

class TemplateCWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateCWidgetState>? dataKey;
  TemplateCWidget({super.key, this.dataKey, required this.validators});

  @override
  State<TemplateCWidget> createState() => TemplateCWidgetState();
}

class TemplateCWidgetState extends State<TemplateCWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};
  final Map<String, bool> _toggles = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
    _toggles.putIfAbsent(name, () => false);
  }

  @override
  void initState() {
    super.initState();
    [
      'nameConveyorC',
      'chainManufacturerC',
      'wheelManufacturerC',
      'speedRangeC',
      'speedTypeC',
      'tempConditionC',
      'mountOrientationC',
      'guideWheelSpacingC',
      'airSupplyC',
      'operatingVoltageC',
      'controlVoltageC',
      'connectExistingMonitoringC',
      'addNewMonitoringC',
      'freeTrolleyWheelsC',
      'dogActuatorC',
      'kingPinC',
      'currentEquipC',
      'currentViscosityC',
      'currentGreaseTypeC',
      'currentNLGIC',
      'zerkSideC',
      'zerkOrientationC',
      'wheelDiameterC'
    ].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    // Collect toggle values
    _toggles.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String label, String key) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  Widget _dropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Template C - OPCO Free Rail 317 Guide Wheel Greaser"),
        _field("Name of Conveyor System", 'nameConveyorC'),
        _field("Chain Manufacturer", 'chainManufacturerC'),
        _field("Wheel Manufacturer", 'wheelManufacturerC'),
        _field("Conveyor Speed (Min/Max)", 'speedRangeC'),
        _dropdown("Speed Type", 'speedTypeC', ['Indexing', 'Variable']),
        CommonWidgets.buildSectionTitle("Application Environment"),
        _dropdown(
            "Temperature of Area", 'tempConditionC', ['Below 30°F', 'Above 120°F', 'Normal Range']),
        _dropdown("Mounting Orientation", 'mountOrientationC',
            ['Overhead', 'Inverted', 'Inverted/Inverted']),
        _dropdown("Are guide wheels evenly spaced?", 'guideWheelSpacingC', ['Yes', 'No']),
        if (_dropdowns['guideWheelSpacingC'] == 2)
          CommonWidgets.buildSectionTitle("Please provide trolley mechanical diagrams"),
        CommonWidgets.buildSectionTitle("Customer Power Utilities"),
        _field("Operating Voltage (Volts/Hz)", 'operatingVoltageC'),
        _field("Control Voltage (Volts/Hz)", 'controlVoltageC'),
        _dropdown("Compressed Air Supply Available?", 'airSupplyC', ['Yes', 'No']),
        CommonWidgets.buildSectionTitle("Monitoring System"),
        _dropdown("Connect to Existing Monitoring?", 'connectExistingMonitoringC', ['Yes', 'No']),
        _dropdown("Add New Monitoring System?", 'addNewMonitoringC', ['Yes', 'No']),
        if (_dropdowns['addNewMonitoringC'] == 1)
          CommonWidgets.buildTemplateA(null, widget.validators),
        CommonWidgets.buildSectionTitle("Conveyor Specifications"),
        _field("Free Trolley Wheels", 'freeTrolleyWheelsC'),
        _field("Dog Actuator", 'dogActuatorC'),
        _field("King Pin", 'kingPinC'),
        _field("Current Lubrication Equipment (Brand)", 'currentEquipC'),
        _field("Current Lubricant Viscosity/Grade", 'currentViscosityC'),
        _field("Current Grease Type", 'currentGreaseTypeC'),
        _field("Current Grease NLGI Grade", 'currentNLGIC'),
        _dropdown("Zerk Ftg Location (Side)", 'zerkSideC', ['Left', 'Right']),
        _field("Zerk Ftg Orientation", 'zerkOrientationC'),
        _field("Wheel Diameter", 'wheelDiameterC'),
        if (_controllers['currentEquipC']!.text.trim().toLowerCase() == 'mighty lube')
          CommonWidgets.buildSectionTitle("Controller Info (Mighty Lube Detected)")
      ],
    );
  }
}

class TemplateDWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateDWidgetState>? dataKey;
  TemplateDWidget({super.key, this.dataKey, required this.validators});

  @override
  State<TemplateDWidget> createState() => TemplateDWidgetState();
}

class TemplateDWidgetState extends State<TemplateDWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};
  final Map<String, bool> _toggles = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
    _toggles.putIfAbsent(name, () => false);
  }

  @override
  void initState() {
    super.initState();
    [
      'nameConveyorD',
      'wheelManufacturerD',
      'conveyorLengthD',
      'chainSizeD',
      'chainManufacturerD',
      'speedRangeD',
      'speedTypeD',
      'tempConditionD',
      'mountOrientationD',
      'loadStatusD',
      'swayConditionD',
      'operatingVoltageD',
      'controlVoltageD',
      'airSupplyD',
      'connectExistingMonitoringD',
      'addNewMonitoringD',
      'currentGreaseTypeD',
      'currentNLGID',
      'wheelDiameterD',
      'currentEquipD',
      'chainMasterControllerD',
      'remoteControlledD',
      'mountedOnGreaserD',
      'controlsOtherUnitsD',
      'timerD',
      'mightyLubeMonitoringD',
      'preMountingD',
      'otherDescribeD'
    ].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    // Collect toggle values
    _toggles.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String label, String key) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  Widget _dropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Template D - OPCO OP-201 Greaser Power Chain"),
        _field("Name of Conveyor System", 'nameConveyorD'),
        _field("Wheel Manufacturer", 'wheelManufacturerD'),
        _field("Conveyor Length", 'conveyorLengthD'),
        _field("Conveyor Chain Size", 'chainSizeD'),
        _field("Chain Manufacturer", 'chainManufacturerD'),
        _field("Conveyor Speed (Min/Max)", 'speedRangeD'),
        _dropdown("Speed Type", 'speedTypeD', ['Indexing', 'Variable']),
        CommonWidgets.buildSectionTitle("Application Environment"),
        _dropdown(
            "Temperature of Area", 'tempConditionD', ['Below 30°F', 'Above 120°F', 'Normal Range']),
        _dropdown("Mounting Orientation", 'mountOrientationD',
            ['Overhead', 'Inverted Chain Under', 'Inverted Chain Over']),
        _dropdown("Is Conveyor Loaded?", 'loadStatusD', ['Loaded', 'Unloaded']),
        _dropdown("Does Conveyor/Chain Sway/Surge?", 'swayConditionD', ['Yes', 'No']),
        CommonWidgets.buildSectionTitle("Customer Power Utilities"),
        _field("Operating Voltage (Volts/Hz)", 'operatingVoltageD'),
        _field("Control Voltage (Volts/Hz)", 'controlVoltageD'),
        _dropdown("Compressed Air Supply Available?", 'airSupplyD', ['Yes', 'No']),
        CommonWidgets.buildSectionTitle("Monitoring System"),
        _dropdown("Connect to Existing Monitoring?", 'connectExistingMonitoringD', ['Yes', 'No']),
        _dropdown("Add New Monitoring System?", 'addNewMonitoringD', ['Yes', 'No']),
        if (_dropdowns['addNewMonitoringD'] == 1)
          CommonWidgets.buildTemplateA(null, widget.validators),
        CommonWidgets.buildSectionTitle("Conveyor Specifications"),
        _field("Current Grease Type", 'currentGreaseTypeD'),
        _field("Current Grease NLGI Grade", 'currentNLGID'),
        _field("Wheel Diameter", 'wheelDiameterD'),
        if (_controllers['currentEquipD']!.text.trim().toLowerCase() == 'mighty lube') ...[
          CommonWidgets.buildSectionTitle("Controller Info - Mighty Lube Detected"),
          _field("ChainMaster Controller", 'chainMasterControllerD'),
          _field("Remote Controlled by E-series", 'remoteControlledD'),
          _field("Mounted on Greaser", 'mountedOnGreaserD'),
          _field("Controls Other Units (list)", 'controlsOtherUnitsD'),
          _field("Timer", 'timerD'),
          _field("Mighty Lube Monitoring", 'mightyLubeMonitoringD'),
          _field("Pre-Mounting Requirements", 'preMountingD'),
          _field("Other Describe", 'otherDescribeD'),
        ]
      ],
    );
  }
}

class TemplateEWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateEWidgetState>? dataKey;
  TemplateEWidget({super.key, this.dataKey, required this.validators});

  @override
  State<TemplateEWidget> createState() => TemplateEWidgetState();
}

class TemplateEWidgetState extends State<TemplateEWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
  }

  @override
  void initState() {
    super.initState();
    ['nameConveyorE', 'chainSizeE'].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    return data;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String label, String key) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  Widget _dropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Template E - Mighty Lube Caterpillar Drive Lubricators"),
        _field("Name of Conveyor System", 'nameConveyorD2'),
        _dropdown("Conveyor Chain Size", 'chainSizeD2',
            ['3-inch', '4-inch', '6-inch', '8-inch', 'X-Type', 'I-Beam'])
      ],
    );
  }
}

class TemplateFWidget extends StatefulWidget {
  final Validators validators;
  GlobalKey<TemplateFWidgetState>? dataKey;
  TemplateFWidget({super.key, this.dataKey, required this.validators});

  @override
  State<TemplateFWidget> createState() => TemplateFWidgetState();
}

class TemplateFWidgetState extends State<TemplateFWidget> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, int?> _dropdowns = {};

  void _initField(String name) {
    _controllers.putIfAbsent(name, () => TextEditingController());
    _dropdowns.putIfAbsent(name, () => null);
  }

  @override
  void initState() {
    super.initState();
    [
      'nameConveyorF',
      'chainSizeF',
      'chainManufacturerF',
      'wheelManufacturerF',
      'conveyorLengthF',
      'brushApplicatorsF',
      'm12PlugsF',
      'mainBackupF'
    ].forEach(_initField);
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = {};
    // Collect text field values
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    // Collect dropdown values
    _dropdowns.forEach((key, value) {
      data[key] = value; // nullable int
    });
    return data;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String label, String key) {
    return CommonWidgets.buildTextField(
      label,
      _controllers[key]!,
      callback: (val) => widget.validators.validateTextField(val, key),
    );
  }

  Widget _dropdown(String label, String key, List<String> options) {
    return CommonWidgets.buildDropdownFieldError(
      label,
      options,
      _dropdowns[key],
      (val) => setState(() => _dropdowns[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle("Template F - OP-52"),
        _field("Name of Conveyor System", 'nameConveyorF'),
        _dropdown("Conveyor Chain Size", 'chainSizeF',
            ['3-inch', '4-inch', '6-inch', '8-inch', 'X-Type', 'I-Beam']),
        _field("Chain Manufacturer", 'chainManufacturerF'),
        _field("Wheel Manufacturer", 'wheelManufacturerF'),
        _field("Conveyor Length", 'conveyorLengthF'),
        _dropdown("Are brush applicators wanted?", 'brushApplicatorsF', ['Yes', 'No']),
        _dropdown("Are M12 plugs required?", 'm12PlugsF', ['Yes', 'No']),
        _dropdown("Used for main and backup caterpillar drives?", 'mainBackupF', ['Yes', 'No'])
      ],
    );
  }
}
