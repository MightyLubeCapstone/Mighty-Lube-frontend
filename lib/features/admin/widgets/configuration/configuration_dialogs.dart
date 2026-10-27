import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widget/customer_details_form.dart';
import '../../../configurations/models/customer_details.dart';
import '../../models/admin_models.dart';
import '../../repositories/admin_repository.dart';
import '../../services/rfq_pdf_service.dart';
import '../common/admin_status_style.dart';

class ConfigurationDetailsDialog extends StatelessWidget {
  const ConfigurationDetailsDialog({
    super.key,
    required this.configuration,
    this.users = const [],
  });

  final AdminConfiguration configuration;

  // Used for customer details in the PDF.
  final List<AdminUser> users;

  @override
  Widget build(BuildContext context) {
    final adminStatus = configuration.adminWorkflowStatus ?? 'requested';

    final rfq = configuration.rfqLabel;

    final productName = configuration.productName.trim().isNotEmpty
        ? configuration.productName
        : 'Configured product';

    return _AdminDetailsDialog(
      icon: Icons.assignment_outlined,
      title: rfq == null
          ? 'Configuration Details'
          : '$rfq • $productName',
      subtitle: rfq == null
          ? productName
          : 'Configuration Details',
      headerActions: RfqPdfActions(
        configurations: [configuration],
        users: users,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ConfigurationHero(
            configuration: configuration,
            adminStatus: adminStatus,
          ),
          const SizedBox(height: 18),
          _PlainSectionBox(
            title: 'Overview',
            children: [
              _plainInfoGrid([
                _PlainInfo('RFQ #', rfq ?? '—'),
                _PlainInfo(
                  'Project',
                  configuration.isInProject
                      ? [
                    configuration.projectNumberLabel,
                    configuration.projectName,
                  ].whereType<String>().join(' – ')
                      : 'Standalone',
                ),
                _PlainInfo('Configuration', configuration.name),
                _PlainInfo('Quantity', configuration.numRequested),
                _PlainInfo('User status', _titleCase(configuration.status)),
                _PlainInfo('Admin status', AdminWorkflowStatus.label(adminStatus)),
                _PlainInfo('Submitted', _friendlyDate(configuration.submittedAt)),
                _PlainInfo('Current status since', _friendlyDate(configuration.adminStatusChangedAt)),
                _PlainInfo('Created', _friendlyDate(configuration.createdAt)),
                if (_hasDistinctUpdate(configuration))
                  _PlainInfo('Last updated', _friendlyDate(configuration.updatedAt)),
              ]),
            ],
          ),
          const SizedBox(height: 18),
          _customerDetailsBox(configuration.customerDetails),
          const SizedBox(height: 18),

          _PlainSectionBox(
            title: 'Product Configuration',
            children: [
              if (configuration.configurationData.isEmpty)
                const _EmptyProductEditor()
              else
                _plainInfoGrid(
                  configuration.configurationData.entries
                      .map(
                        (entry) => _PlainInfo(
                      _readableLabel(entry.key),
                      entry.value?.toString() ?? '-',
                    ),
                  )
                      .toList(),
                ),
            ],
          ),


          const SizedBox(height: 18),
          _ActivityHistoryExpandable(
            configuration: configuration,
          ),
        ],
      ),
    );
  }
}

class _ConfigurationHero extends StatelessWidget {
  const _ConfigurationHero({required this.configuration, required this.adminStatus});

  final AdminConfiguration configuration;
  final String adminStatus;

  @override
  Widget build(BuildContext context) {
    final color = _adminStatusColor(adminStatus);
    final background = _adminStatusBackground(adminStatus);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE4F0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PRODUCT', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
              const SizedBox(height: 6),
              Text(
                configuration.productName.trim().isNotEmpty ? configuration.productName : 'Configured product',
                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.w800, height: 1.2),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MiniBadge(icon: Icons.tag, text: configuration.productType.trim().isEmpty ? 'No product ID' : configuration.productType),
                  _MiniBadge(icon: Icons.inventory_2_outlined, text: 'Qty ${configuration.numRequested}'),
                ],
              ),
            ],
          );
          final badge = Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(.25))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 7),
              Text(AdminWorkflowStatus.label(adminStatus).toUpperCase(), style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: .5)),
            ]),
          );
          if (compact) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [info, const SizedBox(height: 14), badge]);
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: info), const SizedBox(width: 18), badge]);
        },
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class _ActivityHistoryExpandable extends StatelessWidget {
  const _ActivityHistoryExpandable({
    required this.configuration,
  });

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final count = configuration.activityHistory.length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE4F0),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 3,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            16,
          ),
          leading: Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.history,
              size: 19,
              color: Color(0xFF2563EB),
            ),
          ),
          title: const Text(
            'Activity History',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            count == 1 ? '1 activity' : '$count activities',
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            const Divider(height: 1),
            const SizedBox(height: 14),
            _ConfigurationActivityHistory(
              configuration: configuration,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigurationActivityHistory extends StatelessWidget {
  const _ConfigurationActivityHistory({required this.configuration});
  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final activities = configuration.newestActivityFirst;
    if (activities.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Column(children: [
          Icon(Icons.history_toggle_off, size: 30, color: Color(0xFF94A3B8)),
          SizedBox(height: 8),
          Text('No activity history available.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
        ]),
      );
    }
    return Column(children: [
      for (var i = 0; i < activities.length; i++)
        _ActivityTimelineItem(activity: activities[i], isLast: i == activities.length - 1),
    ]);
  }
}

class _ActivityTimelineItem extends StatelessWidget {
  const _ActivityTimelineItem({required this.activity, required this.isLast});
  final Map<String, dynamic> activity;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final action = activity['action']?.toString() ?? '';
    final actor = activity['actor'] is Map ? Map<String, dynamic>.from(activity['actor'] as Map) : <String, dynamic>{};
    final changedAt = DateTime.tryParse(activity['changedAt']?.toString() ?? '');
    final changes = _activityChanges(activity['changes']);
    final color = _activityColor(action);

    return IntrinsicHeight(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(width: 42, child: Column(children: [
          Container(width: 32, height: 32, alignment: Alignment.center, decoration: BoxDecoration(color: color.withOpacity(.10), shape: BoxShape.circle, border: Border.all(color: color.withOpacity(.25))), child: Icon(_activityIcon(action), size: 17, color: color)),
          if (!isLast) Expanded(child: Container(width: 2, margin: const EdgeInsets.symmetric(vertical: 5), color: const Color(0xFFE2E8F0))),
        ])),
        const SizedBox(width: 10),
        Expanded(child: Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(_activityTitle(action), style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w800, fontSize: 14))),
                const SizedBox(width: 10),
                Text(_friendlyDate(changedAt), style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 8),
              _ActivityActor(actor: actor),
              if (changes.isNotEmpty) ...[
                const SizedBox(height: 12),
                for (final change in changes)
                  Padding(padding: const EdgeInsets.only(bottom: 6), child: _ActivityChangeRow(change: change)),
              ],
            ]),
          ),
        )),
      ]),
    );
  }
}

class _ActivityActor extends StatelessWidget {
  const _ActivityActor({required this.actor});
  final Map<String, dynamic> actor;
  @override
  Widget build(BuildContext context) {
    final firstName = actor['firstName']?.toString().trim() ?? '';
    final lastName = actor['lastName']?.toString().trim() ?? '';
    final username = actor['username']?.toString().trim() ?? '';
    final role = actor['role']?.toString().trim() ?? '';
    final fullName = '$firstName $lastName'.trim();
    final displayName = fullName.isNotEmpty ? fullName : (username.isNotEmpty ? username : 'Unknown user');
    return Wrap(spacing: 6, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
      const Icon(Icons.person_outline, size: 15, color: Color(0xFF64748B)),
      Text('By $displayName', style: const TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.w600)),
      if (role.isNotEmpty) Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(10)), child: Text(_titleCase(role), style: const TextStyle(color: Color(0xFF475569), fontSize: 10, fontWeight: FontWeight.w800))),
    ]);
  }
}

class _ActivityChangeRow extends StatelessWidget {
  const _ActivityChangeRow({required this.change});
  final Map<String, dynamic> change;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Wrap(spacing: 7, runSpacing: 5, crossAxisAlignment: WrapCrossAlignment.center, children: [
        Text(_readableLabel(change['field']?.toString() ?? ''), style: const TextStyle(color: Color(0xFF334155), fontSize: 12, fontWeight: FontWeight.w800)),
        Text(_activityChangeValue(change, 'from'), style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
        const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF94A3B8)),
        Text(_activityChangeValue(change, 'to'), style: const TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

// ===========================================================
// CONFIGURATION DATA VIEW
// ===========================================================

class _ConfigurationDataView
    extends StatelessWidget {
  const _ConfigurationDataView({
    required this.configuration,
  });

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    final data =
        configuration.configurationData;

    final imageEntries =
    <String, Map<String, dynamic>>{};

    for (final entry in data.entries) {
      if (_isConfigurationImage(
        entry.key,
        entry.value,
      )) {
        imageEntries[entry.key] =
        Map<String, dynamic>.from(
          entry.value as Map,
        );
      }
    }

    final simpleEntries =
    data.entries.where(
          (entry) =>
      entry.key != '_id' &&
          !_isNested(entry.value),
    );

    final nestedEntries =
    data.entries.where(
          (entry) =>
      _isNested(entry.value) &&
          !_isConfigurationImage(
            entry.key,
            entry.value,
          ),
    );

    final orphanImages =
    imageEntries.entries.where(
          (entry) {
        final parentKey =
        _imageParentKey(
          entry.key,
        );

        return !data.containsKey(
          parentKey,
        );
      },
    );

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        if (simpleEntries.isNotEmpty)
          LayoutBuilder(
            builder: (
                context,
                constraints,
                ) {
              final width =
              _compactFieldWidth(
                constraints.maxWidth,
              );

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final entry
                  in simpleEntries)
                    SizedBox(
                      width: width,
                      child:
                      _configurationField(
                        entry: entry,
                        imageData:
                        imageEntries[
                        '${entry.key}Image'
                        ],
                      ),
                    ),
                ],
              );
            },
          ),

        if (orphanImages.isNotEmpty) ...[
          if (simpleEntries.isNotEmpty)
            const SizedBox(
              height: 12,
            ),

          LayoutBuilder(
            builder: (
                context,
                constraints,
                ) {
              final width =
              _compactFieldWidth(
                constraints.maxWidth,
              );

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final entry
                  in orphanImages)
                    SizedBox(
                      width: width,
                      child:
                      _ConfigurationImageField(
                        configurationID:
                        configuration.id,
                        imageKey:
                        entry.key,
                        label:
                        _readableLabel(
                          _imageParentKey(
                            entry.key,
                          ),
                        ),
                        imageData:
                        entry.value,
                      ),
                    ),
                ],
              );
            },
          ),
        ],

        if (nestedEntries.isNotEmpty) ...[
          const SizedBox(
            height: 14,
          ),

          _PlainSubsection(
            title: 'Linked information',
            child: Column(
              children: [
                for (final entry
                in nestedEntries)
                  _plainLinkedInfo(
                    entry.key,
                    entry.value,
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _configurationField({
    required MapEntry<String, dynamic>
    entry,
    Map<String, dynamic>? imageData,
  }) {
    if (imageData == null) {
      return _plainInfoRow(
        _readableLabel(
          entry.key,
        ),
        entry.value,
      );
    }

    return _ConfigurationValueWithImage(
      configurationID:
      configuration.id,
      imageKey:
      '${entry.key}Image',
      label: _readableLabel(
        entry.key,
      ),
      value: entry.value,
      imageData: imageData,
    );
  }
}

// ===========================================================
// CONFIGURATION IMAGE HELPERS
// ===========================================================

bool _isConfigurationImage(
    String key,
    dynamic value,
    ) {
  if (!key.endsWith('Image') ||
      value is! Map) {
    return false;
  }

  final data =
  Map<String, dynamic>.from(
    value,
  );

  final objectKey =
  data['objectKey']
      ?.toString()
      .trim();

  return objectKey != null &&
      objectKey.isNotEmpty;
}

String _imageParentKey(
    String imageKey,
    ) {
  if (!imageKey.endsWith('Image')) {
    return imageKey;
  }

  return imageKey.substring(
    0,
    imageKey.length -
        'Image'.length,
  );
}

// ===========================================================
// VALUE + IMAGE
// ===========================================================

class _ConfigurationValueWithImage
    extends StatelessWidget {
  const _ConfigurationValueWithImage({
    required this.configurationID,
    required this.imageKey,
    required this.label,
    required this.value,
    required this.imageData,
  });

  final String configurationID;
  final String imageKey;
  final String label;
  final dynamic value;

  final Map<String, dynamic>
  imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color:
        const Color(0xFFF8FAFC),
        borderRadius:
        BorderRadius.circular(8),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color:
              Color(0xFF64748B),
              fontSize: 12,
              fontWeight:
              FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SelectableText(
                  value?.toString().isEmpty ??
                      true
                      ? '—'
                      : value.toString(),
                  style:
                  const TextStyle(
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              _ConfigurationImageThumbnail(
                configurationID:
                configurationID,
                imageKey: imageKey,
                imageData: imageData,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// IMAGE FIELD
// ===========================================================

class _ConfigurationImageField
    extends StatelessWidget {
  const _ConfigurationImageField({
    required this.configurationID,
    required this.imageKey,
    required this.label,
    required this.imageData,
  });

  final String configurationID;
  final String imageKey;
  final String label;

  final Map<String, dynamic>
  imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color:
        const Color(0xFFF8FAFC),
        borderRadius:
        BorderRadius.circular(8),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color:
              Color(0xFF64748B),
              fontSize: 12,
              fontWeight:
              FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          _ConfigurationImageThumbnail(
            configurationID:
            configurationID,
            imageKey: imageKey,
            imageData: imageData,
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// IMAGE THUMBNAIL
// ===========================================================

class _ConfigurationImageThumbnail
    extends StatefulWidget {
  const _ConfigurationImageThumbnail({
    required this.configurationID,
    required this.imageKey,
    required this.imageData,
  });

  final String configurationID;
  final String imageKey;

  final Map<String, dynamic>
  imageData;

  @override
  State<_ConfigurationImageThumbnail>
  createState() =>
      _ConfigurationImageThumbnailState();
}

class _ConfigurationImageThumbnailState
    extends State<
        _ConfigurationImageThumbnail> {
  String? _url;
  String? _error;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  Future<void> _loadImage() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response =
      await AdminRepository
          .getConfigurationImageUrl(
        configurationID:
        widget.configurationID,
        imageKey:
        widget.imageKey,
      );

      if (!mounted) {
        return;
      }

      final url = response.data?['url']
          ?.toString()
          .trim();

      if (!response.success ||
          url == null ||
          url.isEmpty) {
        setState(() {
          _loading = false;
          _error =
              response.message ??
                  'Image unavailable';
        });

        return;
      }

      setState(() {
        _url = url;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _error =
        'Image unavailable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration:
        _thumbnailDecoration(),
        child:
        const SizedBox.square(
          dimension: 20,
          child:
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    if (_error != null ||
        _url == null) {
      return Tooltip(
        message:
        _error ??
            'Image unavailable',
        child: InkWell(
          onTap: _loadImage,
          borderRadius:
          BorderRadius.circular(8),
          child: Container(
            width: 64,
            height: 64,
            alignment:
            Alignment.center,
            decoration:
            _thumbnailDecoration(),
            child: const Icon(
              Icons
                  .broken_image_outlined,
              color:
              Color(0xFF94A3B8),
            ),
          ),
        ),
      );
    }

    return Tooltip(
      message: 'Click to enlarge',
      child: InkWell(
        onTap: _showPreview,
        borderRadius:
        BorderRadius.circular(8),
        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(8),
          child: Container(
            width: 64,
            height: 64,
            decoration:
            _thumbnailDecoration(),
            child: Image.network(
              _url!,
              fit: BoxFit.cover,
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return const Center(
                  child: Icon(
                    Icons
                        .broken_image_outlined,
                    color: Color(
                      0xFF94A3B8,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration
  _thumbnailDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius:
      BorderRadius.circular(8),
      border: Border.all(
        color:
        const Color(0xFFE2E8F0),
      ),
    );
  }

  Future<void>
  _showPreview() async {
    final url = _url;

    if (url == null ||
        url.isEmpty ||
        !mounted) {
      return;
    }

    final originalName =
    widget.imageData[
    'originalName']
        ?.toString()
        .trim();

    await showDialog<void>(
      context: context,
      builder: (
          dialogContext,
          ) {
        return Dialog(
          insetPadding:
          const EdgeInsets.all(
            24,
          ),
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(
              maxWidth: 1000,
              maxHeight: 800,
            ),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                Padding(
                  padding:
                  const EdgeInsets
                      .fromLTRB(
                    16,
                    10,
                    8,
                    10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          originalName ==
                              null ||
                              originalName
                                  .isEmpty
                              ? 'Configuration image'
                              : originalName,
                          maxLines: 1,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight
                                .w700,
                          ),
                        ),
                      ),

                      IconButton(
                        tooltip: 'Close',
                        onPressed: () =>
                            Navigator.pop(
                              dialogContext,
                            ),
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  height: 1,
                ),

                Flexible(
                  child:
                  InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child:
                    Image.network(
                      url,
                      fit:
                      BoxFit.contain,
                      loadingBuilder: (
                          context,
                          child,
                          progress,
                          ) {
                        if (progress ==
                            null) {
                          return child;
                        }

                        return const Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
                        return const Padding(
                          padding:
                          EdgeInsets
                              .all(
                            40,
                          ),
                          child: Column(
                            mainAxisSize:
                            MainAxisSize
                                .min,
                            children: [
                              Icon(
                                Icons
                                    .broken_image_outlined,
                                size: 48,
                                color:
                                Color(
                                  0xFF94A3B8,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Unable to load image.',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================
// DETAILS DIALOG SHELL
// ===========================================================

class _AdminDetailsDialog
    extends StatelessWidget {
  const _AdminDetailsDialog({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
    this.headerActions,
    this.headerColor = const Color(0xFFF1F5FF),
    this.iconColor = const Color(0xFF2563EB),
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  // Shown under the title (e.g. Export PDF / Print).
  final Widget? headerActions;

  final Color headerColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final screen =
    MediaQuery.sizeOf(context);

    final compact =
        screen.width < 560;

    return Dialog(
      insetPadding: EdgeInsets.all(
        compact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 780,
          maxHeight: screen.height -
              (compact ? 24 : 48),
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            Container(
              padding:
              EdgeInsets.fromLTRB(
                compact ? 16 : 24,
                compact ? 16 : 20,
                8,
                compact ? 14 : 18,
              ),
              decoration:
              BoxDecoration(
                color: headerColor,
                borderRadius:
                const BorderRadius.vertical(
                  top:
                  Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (!compact) ...[
                    CircleAvatar(
                      backgroundColor: iconColor,
                      foregroundColor:
                      Colors.white,
                      child: Icon(icon),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                  ],

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          TextStyle(
                            fontSize:
                            compact
                                ? 18
                                : 21,
                            fontWeight:
                            FontWeight
                                .w800,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          subtitle,
                          style:
                          const TextStyle(
                            color:
                            Color(
                              0xFF64748B,
                            ),
                          ),
                        ),
                        if (headerActions != null) ...[
                          const SizedBox(
                            height: 10,
                          ),
                          headerActions!,
                        ],
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () =>
                        Navigator.pop(
                          context,
                        ),
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child:
              SingleChildScrollView(
                padding:
                EdgeInsets.all(
                  compact ? 14 : 24,
                ),
                child: child,
              ),
            ),

            const Divider(
              height: 1,
            ),

            Padding(
              padding:
              EdgeInsets.all(
                compact ? 12 : 16,
              ),
              child: Align(
                alignment:
                Alignment.centerRight,
                child:
                FilledButton.icon(
                  onPressed: () =>
                      Navigator.pop(
                        context,
                      ),
                  icon: const Icon(
                    Icons.check,
                  ),
                  label:
                  const Text(
                    'Done',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================
// AGE BLOCKS
// ===========================================================

class _ConfigurationAgeBlocks
    extends StatelessWidget {
  const _ConfigurationAgeBlocks({
    required this.configuration,
  });

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        final compact =
            constraints.maxWidth <
                460;

        final hasUpdate =
        _hasDistinctUpdate(
          configuration,
        );

        final width =
        compact || !hasUpdate
            ? constraints.maxWidth
            : (constraints.maxWidth -
            10) /
            2;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _AgeFocusBlock(
              width: width,
              label: 'Created ago',
              icon: Icons
                  .add_circle_outline,
              value: _elapsedAge(
                configuration.createdAt,
              ),
              color:
              const Color(
                0xFF2563EB,
              ),
              background:
              const Color(
                0xFFEFF6FF,
              ),
            ),

            if (hasUpdate)
              _AgeFocusBlock(
                width: width,
                label: 'Updated ago',
                icon: Icons.update,
                value: _elapsedAge(
                  configuration.updatedAt,
                ),
                color:
                const Color(
                  0xFF0F766E,
                ),
                background:
                const Color(
                  0xFFECFDF5,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _AgeFocusBlock
    extends StatelessWidget {
  const _AgeFocusBlock({
    required this.width,
    required this.label,
    required this.icon,
    required this.value,
    required this.color,
    required this.background,
  });

  final double width;
  final String label;
  final IconData icon;
  final String? value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(8),
        border: Border.all(
          color:
          color.withOpacity(.28),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight:
                    FontWeight.w800,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  value ?? '-',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontSize: 26,
                    fontWeight:
                    FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// PLAIN SECTION
// ===========================================================

class _PlainSectionBox extends StatelessWidget {
  const _PlainSectionBox({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4F0),),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          ...children,
        ],
      ),
    );
  }
}

class _PlainSubsection
    extends StatelessWidget {
  const _PlainSubsection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(10),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight:
              FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          child,
        ],
      ),
    );
  }
}

// ===========================================================
// PLAIN INFO
// ===========================================================

class _PlainInfo {
  const _PlainInfo(this.label, this.value, {this.isEmail = false});
  final String label;
  final dynamic value;

  // Adds Copy / Send email icons after the value.
  final bool isEmail;
}

Widget _plainInfoGrid(
    List<_PlainInfo> items,
    ) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 380;
      final columns = isMobile ? 1 : 2;

      Widget cell(int index) {
        final item = items[index];

        return Container(
              decoration: BoxDecoration(
                border: Border(
                  right: !isMobile && index.isEven
                      ? const BorderSide(
                    color: Color(0xFFE2E8F0),
                  )
                      : BorderSide.none,
                  bottom: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                ),
              ),
              child: item.isEmail &&
                  (item.value?.toString().trim() ?? '').isNotEmpty
                  ? Row(
                children: [
                  Expanded(
                    child: _plainInfoRow(
                      item.label,
                      item.value,
                    ),
                  ),
                  _emailAction(
                    tooltip: 'Copy email',
                    icon: Icons.copy_rounded,
                    onPressed: () => _copyEmail(
                      context,
                      item.value.toString().trim(),
                    ),
                  ),
                  _emailAction(
                    tooltip: 'Send email',
                    icon: Icons.mail_outline_rounded,
                    onPressed: () => _openEmail(
                      context,
                      item.value.toString().trim(),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              )
                  : _plainInfoRow(
                item.label,
                item.value,
              ),
            );
      }

      // Rows grow with their tallest cell, so multi-line
      // values (e.g. Technician Note) are never cut off.
      return Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          children: [
            for (var start = 0; start < items.length; start += columns)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = start; i < start + columns; i++)
                      Expanded(
                        child: i < items.length
                            ? cell(i)
                            : const SizedBox.shrink(),
                      ),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}

// Same Copy / Send email actions as the Activity Log details.
Widget _emailAction({
  required String tooltip,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    icon: Icon(icon),
    iconSize: 16,
    color: const Color(0xFF475569),
    visualDensity: VisualDensity.compact,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(
      minWidth: 28,
      minHeight: 20,
    ),
  );
}

Future<void> _openEmail(
    BuildContext context,
    String email,
    ) async {
  final messenger = ScaffoldMessenger.of(context);

  bool opened;

  try {
    opened = await launchUrl(
      Uri(scheme: 'mailto', path: email),
    );
  } catch (_) {
    opened = false;
  }

  if (!opened) {
    messenger.showSnackBar(
      const SnackBar(
        content: Text('No email app found. Use Copy instead.'),
      ),
    );
  }
}

Future<void> _copyEmail(
    BuildContext context,
    String email,
    ) async {
  final messenger = ScaffoldMessenger.of(context);

  await Clipboard.setData(
    ClipboardData(text: email),
  );

  messenger.showSnackBar(
    const SnackBar(
      content: Text('Email copied'),
      duration: Duration(seconds: 2),
    ),
  );
}


bool _shouldShowGridBottomBorder({
  required int index,
  required int totalItems,
  required bool compact,
}) {
  if (compact) {
    return index < totalItems - 1;
  }

  final row = index ~/ 2;
  final lastRow = (totalItems - 1) ~/ 2;

  return row < lastRow;
}

Widget _plainInfoRow(
    String label,
    dynamic value,
    ) {
  final displayValue =
      value?.toString().trim() ?? '';

  return Container(
    width: double.infinity,
    constraints: const BoxConstraints(
      minHeight: 38,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 7,
    ),
    alignment: Alignment.centerLeft,
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: displayValue.isEmpty
                ? '—'
                : displayValue,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget _plainLinkedInfo(
    String label,
    dynamic value,
    ) {
  return Padding(
    padding:
    const EdgeInsets.only(
      bottom: 8,
    ),
    child: _plainInfoRow(
      _readableLabel(label),
      _nestedSummary(value),
    ),
  );
}

// ===========================================================
// EMPTY CONFIGURATION
// ===========================================================

class _EmptyProductEditor
    extends StatelessWidget {
  const _EmptyProductEditor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color:
        const Color(0xFFF8FAFC),
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(0xFFE2E8F0),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            color: Colors.grey,
            size: 34,
          ),
          SizedBox(height: 8),
          Text(
            'No product configuration information is available.',
          ),
        ],
      ),
    );
  }
}

// ===========================================================
// HELPERS
// ===========================================================

bool _isNested(
    dynamic value,
    ) {
  return value is Map ||
      value is List;
}

double _compactFieldWidth(
    double maxWidth,
    ) {
  if (maxWidth < 560) {
    return maxWidth;
  }

  return (maxWidth - 12) / 2;
}

String _readableLabel(
    String key,
    ) {
  const overrides = {
    'cc5ChainSize':
    'CC5 chain size',
    'appEnviroment':
    'Application environment',
    'numRequested':
    'Quantity requested',
  };

  if (overrides.containsKey(key)) {
    return overrides[key]!;
  }

  final spaced = key
      .replaceAllMapped(
    RegExp(
      r'([a-z0-9])([A-Z])',
    ),
        (match) =>
    '${match[1]} ${match[2]}',
  )
      .replaceAll('_', ' ')
      .trim();

  if (spaced.isEmpty) {
    return key;
  }

  return '${spaced[0].toUpperCase()}'
      '${spaced.substring(1)}';
}

String _nestedSummary(
    dynamic value,
    ) {
  if (value == null) {
    return '—';
  }

  if (value is List) {
    if (value.isEmpty) {
      return '—';
    }

    return value
        .map(
          (item) => item.toString(),
    )
        .join(', ');
  }

  if (value is Map) {
    if (value.isEmpty) {
      return '—';
    }

    return value.entries
        .map(
          (entry) =>
      '${_readableLabel(entry.key.toString())}: '
          '${entry.value}',
    )
        .join(', ');
  }

  return value.toString();
}

String _titleCase(
    String value,
    ) {
  if (value.trim().isEmpty) {
    return value;
  }

  return value
      .split(' ')
      .where(
        (part) => part.isNotEmpty,
  )
      .map(
        (part) =>
    '${part[0].toUpperCase()}'
        '${part.substring(1).toLowerCase()}',
  )
      .join(' ');
}

String _friendlyDate(
    DateTime? value,
    ) {
  if (value == null) {
    return '—';
  }

  final local = value.toLocal();

  String twoDigits(int value) {
    return value
        .toString()
        .padLeft(2, '0');
  }

  return '${twoDigits(local.month)}/'
      '${twoDigits(local.day)}/'
      '${local.year} '
      '${twoDigits(local.hour)}:'
      '${twoDigits(local.minute)}';
}

String? _elapsedAge(
    DateTime? date,
    ) {
  if (date == null) {
    return null;
  }

  final duration =
  DateTime.now().difference(
    date.toLocal(),
  );

  if (duration.inDays >= 1) {
    return '${duration.inDays}d';
  }

  if (duration.inHours >= 1) {
    return '${duration.inHours}h';
  }

  final minutes =
  duration.inMinutes.clamp(
    0,
    59,
  );

  return '${minutes}m';
}

List<Map<String, dynamic>> _activityChanges(dynamic value) {
  if (value is! List) return <Map<String, dynamic>>[];
  return value.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList();
}

String _activityTitle(String action) {
  switch (action) {
    case 'configuration_created': return 'Configuration Created';
    case 'configuration_updated': return 'Configuration Updated';
    case 'configuration_submitted': return 'Configuration Submitted';
    case 'admin_status_changed': return 'Status Changed';
    default: return _readableLabel(action);
  }
}

IconData _activityIcon(String action) {
  switch (action) {
    case 'configuration_created': return Icons.add_circle_outline;
    case 'configuration_updated': return Icons.edit_outlined;
    case 'configuration_submitted': return Icons.send_outlined;
    case 'admin_status_changed': return Icons.swap_horiz;
    default: return Icons.history;
  }
}

Color _activityColor(String action) {
  switch (action) {
    case 'configuration_created': return const Color(0xFF2563EB);
    case 'configuration_updated': return const Color(0xFF7C3AED);
    case 'configuration_submitted': return const Color(0xFF0F766E);
    case 'admin_status_changed': return const Color(0xFFD97706);
    default: return const Color(0xFF64748B);
  }
}

Color _adminStatusColor(String status) {
  return AdminStatusStyle.text(status.toLowerCase());
}

Color _adminStatusBackground(String status) {
  return AdminStatusStyle.row(status.toLowerCase());
}

// Admin status changes show "Awaiting Response" instead of
// the raw "awaiting_response" value.
String _activityChangeValue(
    Map<String, dynamic> change,
    String side,
    ) {
  final value = change[side];

  if (change['field'] == 'adminStatus' && value is String) {
    return AdminWorkflowStatus.label(value.trim().toLowerCase());
  }

  return _activityValue(value);
}

String _activityValue(dynamic value) {
  if (value == null) return '—';
  if (value is bool) return value ? 'Yes' : 'No';
  if (value is List) return value.isEmpty ? '—' : value.map((item) => item.toString()).join(', ');
  if (value is Map) {
    if (value.isEmpty) return '—';
    return value.entries.map((entry) => '${_readableLabel(entry.key.toString())}: ${entry.value}').join(', ');
  }
  final text = value.toString().trim();
  return text.isEmpty ? '—' : text;
}

bool _hasDistinctUpdate(
    AdminConfiguration configuration,
    ) {
  final created =
      configuration.createdAt;

  final updated =
      configuration.updatedAt;

  if (updated == null) {
    return false;
  }

  if (created == null) {
    return true;
  }

  return updated
      .difference(created)
      .abs()
      .inMinutes >=
      1;
}

// ===========================================================
// PDF / PRINT ACTIONS
// ===========================================================

class RfqPdfActions extends StatefulWidget {
  const RfqPdfActions({
    super.key,
    required this.configurations,
    this.project,
    this.projectCustomerDetails,
    this.users = const [],
  });

  final List<AdminConfiguration> configurations;

  final AdminProjectGroup? project;

  // Latest project details (after an edit in the dialog).
  final CustomerDetails? projectCustomerDetails;

  final List<AdminUser> users;

  @override
  State<RfqPdfActions> createState() => _RfqPdfActionsState();
}

class _RfqPdfActionsState extends State<RfqPdfActions> {
  // 'export' / 'print' while busy.
  String? _busyAction;

  Future<void> _run(
      String action,
      ) async {
    if (_busyAction != null) {
      return;
    }

    setState(() {
      _busyAction = action;
    });

    try {
      if (action == 'export') {
        await RfqPdfService.export(
          configurations: widget.configurations,
          project: widget.project,
          projectCustomerDetails: widget.projectCustomerDetails,
          users: widget.users,
        );
      } else {
        await RfqPdfService.printDocument(
          configurations: widget.configurations,
          project: widget.project,
          projectCustomerDetails: widget.projectCustomerDetails,
          users: widget.users,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('PDF ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              action == 'export'
                  ? 'Unable to export PDF.'
                  : 'Unable to print.',
            ),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _busyAction = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget icon(String action, IconData data) {
      if (_busyAction == action) {
        return const SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      }

      return Icon(data, size: 18);
    }

    final busy = _busyAction != null;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: busy ? null : () => _run('export'),
          icon: icon('export', Icons.picture_as_pdf_outlined),
          label: const Text('Export PDF'),
        ),
        OutlinedButton.icon(
          onPressed: busy ? null : () => _run('print'),
          icon: icon('print', Icons.print_outlined),
          label: const Text('Print'),
        ),
      ],
    );
  }
}

// ===========================================================
// PROJECT DETAILS DIALOG
//
// Project info + customer details (editable) + every RFQ in
// it, with PDF/print for the whole project.
// ===========================================================

class ProjectDetailsDialog extends StatefulWidget {
  const ProjectDetailsDialog({
    super.key,
    required this.project,
    this.users = const [],
    this.onDetailsSaved,
  });

  final AdminProjectGroup project;

  final List<AdminUser> users;

  // Lets the dashboard reload its list after an edit.
  final VoidCallback? onDetailsSaved;

  @override
  State<ProjectDetailsDialog> createState() => _ProjectDetailsDialogState();
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  late CustomerDetails? _details = widget.project.customerDetails;

  Future<void> _editDetails() async {
    final projectID = widget.project.projectID;

    if (projectID == null) {
      return;
    }

    final saved = await showDialog<CustomerDetails>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditCustomerDetailsDialog(
        title: 'Edit customer details',
        initial: _details,
        onSave: (details) => AdminRepository.updateProjectDetails(
          projectID: projectID,
          details: details,
        ),
      ),
    );

    if (saved == null || !mounted) {
      return;
    }

    setState(() {
      _details = saved;
    });

    widget.onDetailsSaved?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project details updated.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final users = widget.users;
    final details = _details;
    final count = project.items.length;

    return _AdminDetailsDialog(
      icon: Icons.folder_outlined,
      iconColor: AdminStatusStyle.projectColor,
      headerColor: AdminStatusStyle.projectBackground,
      title: project.title,
      subtitle: 'Project • $count RFQ${count == 1 ? '' : 's'}',
      headerActions: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          RfqPdfActions(
            configurations: project.items,
            project: project,
            projectCustomerDetails: details,
            users: users,
          ),
          if (project.projectID != null)
            OutlinedButton.icon(
              onPressed: _editDetails,
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Edit customer details'),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlainSectionBox(
            title: 'Overview',
            children: [
              _plainInfoGrid([
                _PlainInfo('Project #', project.projectNumberLabel ?? '—'),
                _PlainInfo('Project name', project.projectName),
                _PlainInfo('Submitted by', adminConfigurationUserName(project.items.first, users),
                ),
                _PlainInfo('Submitted', _friendlyDate(project.submittedAt)),
                _PlainInfo('RFQs', count),
                _PlainInfo('Total quantity', project.totalQuantity),
              ]),
              const SizedBox(height: 12),
              AdminProjectStatusSummary(
                group: project,
                alignment: WrapAlignment.start,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _customerDetailsBox(details),
          const SizedBox(height: 18),
          _PlainSectionBox(
            title: 'RFQs',
            children: [
              for (final item in project.items)
                _ProjectRfqTile(
                  configuration: item,
                  users: users,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Customer / Final Customer / Contact / Additional info,
// read-only, in the same two-column grid as Overview.
// Project RFQs show the project's details.
Widget _customerDetailsBox(
    CustomerDetails? details,
    ) {
  final sections = details?.filledSections ?? const [];

  return _PlainSectionBox(
    title: 'Customer details',
    children: [
      if (sections.isEmpty)
        Text(
          'No customer details yet.',
          style: TextStyle(
            color: Colors.orange.shade800,
          ),
        )
      else
        for (var i = 0; i < sections.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          // "Customer details" already titles the Customer
          // section; the others keep their own heading.
          if (sections[i].title != 'Customer')
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                sections[i].title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          _plainInfoGrid([
            for (final row in sections[i].rows)
              _PlainInfo(
                row.key,
                row.value,
                isEmail: row.key == 'Email',
              ),
          ]),
        ],
    ],
  );
}

class _ProjectRfqTile extends StatelessWidget {
  const _ProjectRfqTile({
    required this.configuration,
    required this.users,
  });

  final AdminConfiguration configuration;

  final List<AdminUser> users;

  @override
  Widget build(BuildContext context) {
    final status =
        configuration.adminWorkflowStatus ?? AdminWorkflowStatus.requested;

    final color = AdminStatusStyle.text(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AdminStatusStyle.row(status),
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(
            color: AdminStatusStyle.projectColor,
            width: 4,
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          '${configuration.rfqLabel ?? 'RFQ —'} • ${configuration.productLabel}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          'Qty ${configuration.numRequested} • '
              'Submitted ${_friendlyDate(configuration.submittedAt)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AdminWorkflowStatus.label(status),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
            IconButton(
              tooltip: 'View RFQ',
              icon: const Icon(Icons.visibility_outlined),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => ConfigurationDetailsDialog(
                    configuration: configuration,
                    users: users,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
