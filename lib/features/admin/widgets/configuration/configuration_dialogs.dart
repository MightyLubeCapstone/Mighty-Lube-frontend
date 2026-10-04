import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import '../../repositories/admin_repository.dart';

class ConfigurationDetailsDialog extends StatelessWidget {
  const ConfigurationDetailsDialog({
    super.key,
    required this.configuration,
  });

  final AdminConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return _AdminDetailsDialog(
      icon: Icons.tune,
      title: configuration.name,
      subtitle: configuration.productName.trim().isNotEmpty
          ? configuration.productName
          : 'Configured product',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ConfigurationAgeBlocks(
            configuration: configuration,
          ),

          const SizedBox(height: 16),

          _PlainSectionBox(
            title: 'Configuration summary',
            children: [
              _plainInfoGrid(
                [
                  _PlainInfo(
                    'User status',
                    _titleCase(
                      configuration.status,
                    ),
                  ),
                  _PlainInfo(
                    'Admin status',
                    configuration.adminWorkflowStatus ??
                        'requested',
                  ),
                  _PlainInfo(
                    'Product name',
                    configuration.productName,
                  ),
                  _PlainInfo(
                    'Product type',
                    configuration.productType,
                  ),
                  _PlainInfo(
                    'Quantity',
                    configuration.numRequested,
                  ),
                  _PlainInfo(
                    'Submitted',
                    _friendlyDate(
                      configuration.submittedAt,
                    ),
                  ),
                  _PlainInfo(
                    'Admin requested',
                    _friendlyDate(
                      configuration.adminRequestedAt,
                    ),
                  ),
                  _PlainInfo(
                    'Admin started',
                    _friendlyDate(
                      configuration.adminStartedAt,
                    ),
                  ),
                  _PlainInfo(
                    'Admin completed',
                    _friendlyDate(
                      configuration.adminCompletedAt,
                    ),
                  ),
                  _PlainInfo(
                    'Created',
                    _friendlyDate(
                      configuration.createdAt,
                    ),
                  ),
                  if (_hasDistinctUpdate(
                    configuration,
                  ))
                    _PlainInfo(
                      'Updated',
                      _friendlyDate(
                        configuration.updatedAt,
                      ),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (configuration.configurationData.isEmpty)
            const _EmptyProductEditor()
          else
            _PlainSectionBox(
              title: 'Product configuration',
              children: [
                _ConfigurationDataView(
                  configuration:
                  configuration,
                ),
              ],
            ),
        ],
      ),
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
                  maxLines: 4,
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
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

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
              const BoxDecoration(
                color:
                Color(0xFFF1F5FF),
                borderRadius:
                BorderRadius.vertical(
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
                      backgroundColor:
                      const Color(
                        0xFF2563EB,
                      ),
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

class _PlainSectionBox
    extends StatelessWidget {
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
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(0xFFDCE4F0),
        ),
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
  const _PlainInfo(
      this.label,
      this.value,
      );

  final String label;
  final dynamic value;
}

Widget _plainInfoGrid(
    List<_PlainInfo> items,
    ) {
  return LayoutBuilder(
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
          for (final item in items)
            SizedBox(
              width: width,
              child: _plainInfoRow(
                item.label,
                item.value,
              ),
            ),
        ],
      );
    },
  );
}

Widget _plainInfoRow(
    String label,
    dynamic value,
    ) {
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

        const SizedBox(height: 4),

        SelectableText(
          value?.toString().isEmpty ??
              true
              ? '—'
              : value.toString(),
          maxLines: 4,
          style: const TextStyle(
            fontWeight:
            FontWeight.w600,
          ),
        ),
      ],
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
  if (maxWidth < 520) {
    return maxWidth;
  }

  return ((maxWidth - 24) / 3)
      .clamp(
    190.0,
    240.0,
  );
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