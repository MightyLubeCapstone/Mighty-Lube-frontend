import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mighty_lube/core/widget/helper_widgets.dart';
import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/configurations/models/submitted_rfq.dart';
import 'package:mighty_lube/features/configurations/repositories/configuration_repository.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';
import '../../cart/repositories/cart_repositories.dart';

// =========================================================
// USER CONFIGURATIONS (submitted RFQs)
//
// View-only. Projects show as purple groups that open to
// their RFQs; standalone RFQs show as normal cards. Newest
// first. Admin status is not shown to the user.
// =========================================================

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({
    super.key,
  });

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  static const Color _projectColor = Color(0xFF7C3AED);

  static const Color _projectBackground = Color(0xFFF5F3FF);

  int totalQuantities = 0;

  bool configLoading = false;

  // SubmittedRfq (standalone) or List<SubmittedRfq> (project),
  // newest first.
  List<Object> _entries = [];

  Future<void> getOrders() async {
    try {
      final response = await CartRepository.getOrders();

      if (!response.success || response.data == null) {
        return;
      }

      int total = 0;

      for (final order in response.data!) {
        if (order is Map) {
          total += int.tryParse(
            order['quantity']?.toString() ?? '0',
          ) ??
              0;
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        totalQuantities = total;
      });
    } catch (_) {
      // Configurations page should continue working
      // even if cart count API fails.
    }
  }

  Future<void> getConfigurations() async {
    setState(() {
      configLoading = true;
    });

    final response = await ConfigurationRepository.getConfigurations();

    if (!mounted) {
      return;
    }

    if (!response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message ?? 'Unable to load configurations.',
          ),
        ),
      );
    }

    final rfqs = (response.data ?? const [])
        .whereType<Map>()
        .map(
          (item) => SubmittedRfq.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .where((rfq) => rfq.isSubmitted)
        .toList();

    setState(() {
      _entries = _groupByProject(rfqs);
      configLoading = false;
    });
  }

  // Keeps each project's RFQs together and sorts everything
  // newest first (a project by its newest RFQ).
  List<Object> _groupByProject(
      List<SubmittedRfq> rfqs,
      ) {
    final entries = <Object>[];
    final projects = <String, List<SubmittedRfq>>{};

    for (final rfq in rfqs) {
      final key = rfq.projectKey;

      if (key == null) {
        entries.add(rfq);
        continue;
      }

      final project = projects.putIfAbsent(key, () {
        final items = <SubmittedRfq>[];
        entries.add(items);
        return items;
      });

      project.add(rfq);
    }

    DateTime newest(Object entry) {
      final items = entry is List<SubmittedRfq>
          ? entry
          : [entry as SubmittedRfq];

      return items
          .map((rfq) => rfq.submittedAt ?? DateTime(0))
          .reduce((a, b) => a.isAfter(b) ? a : b);
    }

    for (final items in projects.values) {
      items.sort(
            (a, b) => (a.rfqNumber ?? '').compareTo(b.rfqNumber ?? ''),
      );
    }

    entries.sort((a, b) => newest(b).compareTo(newest(a)));

    return entries;
  }

  @override
  void initState() {
    super.initState();

    getOrders();

    getConfigurations();
  }

  // =========================================================
  // RFQ DETAILS (view-only)
  // =========================================================

  void _showRfqInfo(
      SubmittedRfq rfq,
      ) {
    final details = rfq.configurationData.entries
        .where(
          (entry) =>
      entry.key != '_id' &&
          entry.value != null &&
          entry.value.toString().trim().isNotEmpty,
    )
        .toList();

    final projectLine = rfq.projectName == null
        ? null
        : [rfq.projectNumberLabel, rfq.projectName]
        .whereType<String>()
        .join(' – ');

    showModalBottomSheet(
      backgroundColor: const Color(0xFF579AF6),
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            15,
          ),
        ),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                30.0,
                20.0,
                20.0,
                20.0,
              ),
              children: [
                Text(
                  rfq.rfqLabel ?? 'Configuration Information',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                CommonWidgets.buildSectionDivider(),
                if (projectLine != null)
                  _infoText(
                    'Project',
                    projectLine,
                  ),
                _infoText(
                  'Product',
                  rfq.productName,
                ),
                _infoText(
                  'Quantity',
                  '${rfq.quantity}',
                ),
                _infoText(
                  'Submitted',
                  _date(rfq.submittedAt),
                ),
                if (details.isNotEmpty) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Configuration Details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  for (final entry in details)
                    _infoText(
                      _readableLabel(entry.key),
                      _valueText(entry.value),
                    ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoText(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value,
            ),
          ],
        ),
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationCatalogPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: configLoading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _entries.isEmpty
          ? buildDefaultView(
        context,
      )
          : RefreshIndicator(
        onRefresh: getConfigurations,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          children: [
            for (final entry in _entries)
              if (entry is List<SubmittedRfq>)
                _projectCard(entry)
              else
                _standaloneCard(entry as SubmittedRfq),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PROJECT CARD (purple, expandable)
  // =========================================================

  Widget _projectCard(
      List<SubmittedRfq> rfqs,
      ) {
    final first = rfqs.first;

    final title = [first.projectNumberLabel, first.projectName]
        .whereType<String>()
        .join(' • ');

    final submittedAt = rfqs
        .map((rfq) => rfq.submittedAt)
        .whereType<DateTime>()
        .fold<DateTime?>(
      null,
          (earliest, date) =>
      earliest == null || date.isBefore(earliest) ? date : earliest,
    );

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      elevation: 3,
      color: _projectBackground,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
        side: const BorderSide(
          color: _projectColor,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: const Icon(
            Icons.folder_outlined,
            color: _projectColor,
          ),
          iconColor: _projectColor,
          collapsedIconColor: _projectColor,
          title: Text(
            title.isEmpty ? 'Project' : title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _projectColor,
            ),
          ),
          subtitle: Text(
            '${rfqs.length} RFQ${rfqs.length == 1 ? '' : 's'}'
                '${submittedAt == null ? '' : ' • Submitted ${_date(submittedAt)}'}',
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            12,
            0,
            12,
            12,
          ),
          children: [
            for (final rfq in rfqs)
              Container(
                margin: const EdgeInsets.only(
                  top: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: const Border(
                    left: BorderSide(
                      color: _projectColor,
                      width: 4,
                    ),
                  ),
                ),
                child: _rfqTile(rfq),
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // STANDALONE CARD
  // =========================================================

  Widget _standaloneCard(
      SubmittedRfq rfq,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: _rfqTile(
        rfq,
        showDate: true,
      ),
    );
  }

  Widget _rfqTile(
      SubmittedRfq rfq, {
        bool showDate = false,
      }) {
    final title = [rfq.rfqLabel, rfq.productName]
        .whereType<String>()
        .join('  ');

    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Qty ${rfq.quantity}'
            '${showDate && rfq.submittedAt != null ? ' • Submitted ${_date(rfq.submittedAt)}' : ''}',
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.remove_red_eye_rounded,
          color: Colors.lightBlueAccent,
        ),
        onPressed: () {
          _showRfqInfo(
            rfq,
          );
        },
      ),
    );
  }

  // =========================================================
  // HELPERS
  // =========================================================

  String _date(
      DateTime? value,
      ) {
    if (value == null) {
      return '—';
    }

    return DateFormat.yMMMd().format(
      value.toLocal(),
    );
  }

  String _valueText(
      dynamic value,
      ) {
    if (value is bool) {
      return value ? 'Yes' : 'No';
    }

    if (value is List) {
      return value.join(', ');
    }

    // Uploaded images are stored as metadata maps.
    if (value is Map) {
      return value.containsKey('objectKey')
          ? 'Image attached'
          : value.values.join(', ');
    }

    return value.toString();
  }

  String _readableLabel(
      String key,
      ) {
    final spaced = key
        .replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match[1]} ${match[2]}',
    )
        .replaceAll('_', ' ')
        .trim();

    if (spaced.isEmpty) {
      return key;
    }

    return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }
}

Widget buildDefaultView(
    BuildContext context,
    ) {
  final screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding: EdgeInsets.fromLTRB(
      screenWidth * 0.1,
      0,
      0,
      0,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'No configurations have been made yet.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ApplicationCatalogPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF579AF6),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
          ),
          child: const Text(
            'Browse Products',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}