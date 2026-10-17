import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/admin_models.dart';
import '../repositories/admin_repository.dart';
import '../widgets/common/admin_common_widgets.dart';

// ===========================================================
// RFQ PDF SERVICE
//
// Builds a PDF for one RFQ or a whole project (admin only).
//
// Layout per RFQ:
//
// [Mighty Lube logo]
// RFQ-10002                Project: P-10001 - Name
// Customer / Product / Qty / Submitted / Status
// Configuration Details
// Customer Images
//
// A project PDF starts with a project summary page and every
// RFQ starts on a new page. Activity history is left out.
//
// Images are private, so each one is fetched through a
// temporary signed URL first. An image that fails to load is
// shown as "Image unavailable" instead of failing the PDF.
// ===========================================================

class RfqPdfService {
  RfqPdfService._();

  static const PdfColor _navy = PdfColor.fromInt(0xFF17223B);

  static const PdfColor _muted = PdfColor.fromInt(0xFF64748B);

  static const PdfColor _line = PdfColor.fromInt(0xFFE2E8F0);

  static const PdfColor _purple = PdfColor.fromInt(0xFF7C3AED);

  // =========================================================
  // EXPORT
  //
  // Web: downloads the file.
  // Mobile/desktop: opens the share sheet.
  // =========================================================

  static Future<void> export({
    required List<AdminConfiguration> configurations,
    AdminProjectGroup? project,
    List<AdminUser> users = const [],
  }) async {
    final bytes = await build(
      configurations: configurations,
      project: project,
      users: users,
    );

    await Printing.sharePdf(
      bytes: bytes,
      filename: fileName(
        configurations: configurations,
        project: project,
      ),
    );
  }

  // =========================================================
  // PRINT
  // =========================================================

  static Future<void> printDocument({
    required List<AdminConfiguration> configurations,
    AdminProjectGroup? project,
    List<AdminUser> users = const [],
  }) async {
    final bytes = await build(
      configurations: configurations,
      project: project,
      users: users,
    );

    await Printing.layoutPdf(
      name: fileName(
        configurations: configurations,
        project: project,
      ),
      onLayout: (_) async => bytes,
    );
  }

  static String fileName({
    required List<AdminConfiguration> configurations,
    AdminProjectGroup? project,
  }) {
    final reference = project != null
        ? (project.projectNumberLabel ?? 'Project')
        : (configurations.isEmpty
        ? 'RFQ'
        : configurations.first.rfqLabel ?? 'RFQ');

    return '${reference.replaceAll(RegExp(r'[^A-Za-z0-9\-]'), '_')}.pdf';
  }

  // =========================================================
  // BUILD
  // =========================================================

  static Future<Uint8List> build({
    required List<AdminConfiguration> configurations,
    AdminProjectGroup? project,
    List<AdminUser> users = const [],
  }) async {
    final document = pw.Document();

    final logo = await _loadLogo();

    final imagesByConfiguration = await Future.wait(
      configurations.map(_loadImages),
    );

    if (project != null) {
      document.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.all(36),
          build: (_) => [
            _header(logo),
            pw.SizedBox(height: 16),
            _projectSummary(
              project,
              users,
            ),
          ],
        ),
      );
    }

    for (var i = 0; i < configurations.length; i++) {
      document.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.letter,
          margin: const pw.EdgeInsets.all(36),
          footer: (context) => _footer(context),
          build: (_) => [
            _header(logo),
            pw.SizedBox(height: 16),
            ..._rfqContent(
              configurations[i],
              users,
              imagesByConfiguration[i],
            ),
          ],
        ),
      );
    }

    return document.save();
  }

  // =========================================================
  // HEADER / FOOTER
  // =========================================================

  static pw.Widget _header(
      pw.Widget? logo,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: _navy,
            width: 2,
          ),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          if (logo != null)
            pw.SizedBox(
              height: 44,
              width: 160,
              child: logo,
            )
          else
            pw.Text(
              'Mighty Lube',
              style: const pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: _navy,
              ),
            ),
          pw.Text(
            'Request for Quote',
            style: const pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: _navy,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _footer(
      pw.Context context,
      ) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'Generated ${_date(DateTime.now())} - '
            'Page ${context.pageNumber} of ${context.pagesCount}',
        style: const pw.TextStyle(
          fontSize: 8,
          color: _muted,
        ),
      ),
    );
  }

  // =========================================================
  // PROJECT SUMMARY PAGE
  // =========================================================

  static pw.Widget _projectSummary(
      AdminProjectGroup project,
      List<AdminUser> users,
      ) {
    final first = project.items.first;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Project: ${project.projectNumberLabel ?? ''} - ${project.projectName}',
          style: const pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: _purple,
          ),
        ),
        pw.SizedBox(height: 8),
        _infoLine(
          'Customer',
          _customer(first, users),
        ),
        _infoLine(
          'Submitted',
          _date(project.submittedAt),
        ),
        _infoLine(
          'RFQs',
          '${project.items.length}',
        ),
        pw.SizedBox(height: 14),
        pw.TableHelper.fromTextArray(
          headers: [
            'RFQ #',
            'Product',
            'Qty',
            'Status',
          ],
          data: [
            for (final item in project.items)
              [
                item.rfqLabel ?? '-',
                item.productLabel,
                '${item.numRequested}',
                AdminWorkflowStatus.label(
                  item.adminWorkflowStatus,
                ),
              ],
          ],
          headerStyle: const pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
            fontSize: 10,
          ),
          headerDecoration: const pw.BoxDecoration(
            color: _navy,
          ),
          cellStyle: const pw.TextStyle(
            fontSize: 10,
          ),
          border: pw.TableBorder.all(
            color: _line,
          ),
          cellAlignments: {
            2: pw.Alignment.center,
          },
        ),
      ],
    );
  }

  // =========================================================
  // RFQ CONTENT
  // =========================================================

  static List<pw.Widget> _rfqContent(
      AdminConfiguration configuration,
      List<AdminUser> users,
      List<_PdfImage> images,
      ) {
    final projectNumber =
        configuration.projectNumberLabel;

    final projectName =
        configuration.projectName?.trim() ?? '';

    final details = _detailRows(configuration);

    return [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            configuration.rfqLabel ?? 'RFQ',
            style: const pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
              color: _navy,
            ),
          ),
          if (configuration.isInProject)
            pw.Text(
              'Project: '
                  '${projectNumber == null ? '' : '$projectNumber - '}'
                  '${projectName.isEmpty ? 'Unnamed project' : projectName}',
              style: const pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: _purple,
              ),
            ),
        ],
      ),
      pw.SizedBox(height: 10),
      _infoLine(
        'Customer',
        _customer(configuration, users),
      ),
      pw.Row(
        children: [
          pw.Expanded(
            child: _infoLine(
              'Product',
              configuration.productLabel,
            ),
          ),
          pw.Expanded(
            child: _infoLine(
              'Qty',
              '${configuration.numRequested}',
            ),
          ),
        ],
      ),
      pw.Row(
        children: [
          pw.Expanded(
            child: _infoLine(
              'Submitted',
              _date(configuration.submittedAt),
            ),
          ),
          pw.Expanded(
            child: _infoLine(
              'Status',
              AdminWorkflowStatus.label(
                configuration.adminWorkflowStatus,
              ),
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 14),
      _sectionTitle('Configuration Details'),
      if (details.isEmpty)
        pw.Text(
          'No configuration details available.',
          style: const pw.TextStyle(
            color: _muted,
            fontSize: 10,
          ),
        )
      else
        pw.Table(
          border: pw.TableBorder.all(
            color: _line,
          ),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
          },
          children: [
            for (final row in details)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      row.key,
                      style: const pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      row.value,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      if (images.isNotEmpty) ...[
        pw.SizedBox(height: 14),
        _sectionTitle('Customer Images'),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final image in images)
              _imageTile(image),
          ],
        ),
      ],
    ];
  }

  static pw.Widget _imageTile(
      _PdfImage image,
      ) {
    final bytes = image.bytes;

    return pw.Container(
      width: 165,
      padding: const pw.EdgeInsets.all(6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: _line,
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            image.label,
            maxLines: 2,
            style: const pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.SizedBox(
            height: 130,
            width: double.infinity,
            child: bytes == null
                ? pw.Center(
              child: pw.Text(
                'Image unavailable',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: _muted,
                ),
              ),
            )
                : pw.Image(
              pw.MemoryImage(bytes),
              fit: pw.BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _sectionTitle(
      String title,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Text(
        title,
        style: const pw.TextStyle(
          fontSize: 13,
          fontWeight: pw.FontWeight.bold,
          color: _navy,
        ),
      ),
    );
  }

  static pw.Widget _infoLine(
      String label,
      String value,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(
              text: '$label: ',
              style: const pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: _muted,
              ),
            ),
            pw.TextSpan(
              text: value,
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DATA HELPERS
  // =========================================================

  // "Name (email, company)"
  static String _customer(
      AdminConfiguration configuration,
      List<AdminUser> users,
      ) {
    AdminUser? user;

    for (final candidate in users) {
      if (candidate.userID == configuration.userID) {
        user = candidate;
        break;
      }
    }

    final createdBy = configuration.createdBy;

    final name = user != null && user.name != '—'
        ? user.name
        : '${createdBy?['firstName'] ?? ''} ${createdBy?['lastName'] ?? ''}'
        .trim();

    final extras = [
      if (user != null && user.email != '—') user.email,
      if (user != null && user.company != '—') user.company,
    ];

    final displayName = name.isNotEmpty
        ? name
        : createdBy?['username']?.toString() ?? '-';

    return extras.isEmpty
        ? displayName
        : '$displayName (${extras.join(', ')})';
  }

  static List<MapEntry<String, String>> _detailRows(
      AdminConfiguration configuration,
      ) {
    final rows = <MapEntry<String, String>>[];

    for (final entry in configuration.configurationData.entries) {
      if (entry.key == '_id' ||
          _isImage(entry.key, entry.value)) {
        continue;
      }

      final value = _valueText(entry.value);

      if (value.isEmpty) {
        continue;
      }

      rows.add(
        MapEntry(
          adminReadableLabel(entry.key),
          value,
        ),
      );
    }

    return rows;
  }

  static String _valueText(
      dynamic value,
      ) {
    if (value == null) {
      return '';
    }

    if (value is bool) {
      return value ? 'Yes' : 'No';
    }

    if (value is List) {
      return value.map((item) => item.toString()).join(', ');
    }

    if (value is Map) {
      return value.entries
          .map(
            (entry) =>
        '${adminReadableLabel(entry.key.toString())}: ${entry.value}',
      )
          .join(', ');
    }

    return value.toString().trim();
  }

  static bool _isImage(
      String key,
      dynamic value,
      ) {
    if (!key.endsWith('Image') || value is! Map) {
      return false;
    }

    final objectKey = value['objectKey']?.toString().trim() ?? '';

    return objectKey.isNotEmpty;
  }

  static Future<List<_PdfImage>> _loadImages(
      AdminConfiguration configuration,
      ) async {
    final imageKeys = configuration.configurationData.entries
        .where((entry) => _isImage(entry.key, entry.value))
        .map((entry) => entry.key)
        .toList();

    return Future.wait(
      imageKeys.map((imageKey) async {
        final label = adminReadableLabel(
          imageKey.substring(
            0,
            imageKey.length - 'Image'.length,
          ),
        );

        try {
          final response =
          await AdminRepository.getConfigurationImageUrl(
            configurationID: configuration.id,
            imageKey: imageKey,
          );

          final url = response.data?['url']?.toString().trim() ?? '';

          if (!response.success || url.isEmpty) {
            return _PdfImage(label, null);
          }

          final download = await http.get(
            Uri.parse(url),
          );

          if (download.statusCode != 200 ||
              download.bodyBytes.isEmpty) {
            return _PdfImage(label, null);
          }

          return _PdfImage(label, download.bodyBytes);
        } catch (error) {
          // Web may block the download (CORS) - keep going.
          debugPrint('PDF IMAGE ERROR ($imageKey): $error');

          return _PdfImage(label, null);
        }
      }),
    );
  }

  static Future<pw.Widget?> _loadLogo() async {
    try {
      final svg = await rootBundle.loadString(
        'assets/ML_Logo-w-tag-vector.svg',
      );

      return pw.SvgImage(
        svg: svg,
        fit: pw.BoxFit.contain,
        alignment: pw.Alignment.centerLeft,
      );
    } catch (_) {
      return null;
    }
  }

  static String _date(
      DateTime? value,
      ) {
    if (value == null) {
      return '-';
    }

    return DateFormat('MMM d, yyyy').format(
      value.toLocal(),
    );
  }
}

class _PdfImage {
  const _PdfImage(
      this.label,
      this.bytes,
      );

  final String label;

  // null = could not be loaded.
  final Uint8List? bytes;
}
