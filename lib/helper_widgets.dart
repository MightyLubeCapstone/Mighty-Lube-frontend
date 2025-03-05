import 'package:flutter/material.dart';

class CommonWidgets {
  // Nice looking button
  static Widget buildGradientButton(
      BuildContext context, String title, Widget content,
      {bool isError = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isError
              ? Colors.red
              : const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.3),
          width: 2,
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(25, 54, 53, 53).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color:
                const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.3),
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(25, 54, 53, 53)
                        .withValues(alpha: 0.2),
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

  // Dropdown list - protein (temporary until industrial is finished API-wise)
  static Widget buildDropdownFieldProtein<T>(String label, List<String> options,
      int? dropdownSelection, Function(int) onChanged,
      {String? errorText, bool? isEditable = true}) {
    String? assessedValue;
    if (dropdownSelection != null &&
        dropdownSelection > 0 &&
        dropdownSelection <= options.length) {
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
        onTap: (isEditable ?? false)
            ? null
            : () {}, // Ensure isEditable is not null
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
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
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
  static Widget buildTextField(
      String hintText, TextEditingController controller,
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
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.black),
          border: borderStyle(Colors.grey),
          enabledBorder: borderStyle(Colors.grey),
          focusedBorder: borderStyle(Colors.grey),
          errorBorder:
              borderStyle(Colors.red), // Ensure error thickness matches
          focusedErrorBorder:
              borderStyle(Colors.red), // Ensure when focused with error
          errorText: errorText,
        ),
      ),
    );
  }

  // breadcrumb nav
  static Widget buildBreadcrumbNavigation(BuildContext context, String text,
      Widget page, String text2, Widget page2) {
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
}

// Internal StatefulWidget for managing the counter state
class _ConfiguratorWithCounter extends StatefulWidget {
  final void Function(int)? callback;
  const _ConfiguratorWithCounter({this.callback});
  @override
  _ConfiguratorWithCounterState createState() =>
      _ConfiguratorWithCounterState();
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
              icon: const Icon(Icons.remove_circle_outline,
                  color: Colors.blue, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '$itemCount',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  itemCount++;
                });
              },
              icon: const Icon(Icons.add_circle_outline,
                  color: Colors.blue, size: 30),
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
                color:
                    const Color.fromARGB(25, 54, 53, 53).withValues(alpha: 0.1),
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
              icon: const Icon(Icons.remove_circle_outline,
                  color: Colors.blue, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '$itemCount',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  itemCount++;
                  widget.callback!(itemCount);
                });
              },
              icon: const Icon(Icons.add_circle_outline,
                  color: Colors.blue, size: 30),
            ),
          ],
        ),
      ],
    );
  }
}
