import 'package:flutter/material.dart';

import '../../models/admin_models.dart';
import '../../repositories/admin_repository.dart';

class ConfigurationImageGallery {
  ConfigurationImageGallery._();

  // =========================================================
  // IMAGE ENTRIES
  // =========================================================

  static List<MapEntry<String, Map<String, dynamic>>>
  imageEntries(
      AdminConfiguration configuration,
      ) {
    final images =
    <MapEntry<String, Map<String, dynamic>>>[];

    for (final entry
    in configuration.configurationData.entries) {
      if (_isConfigurationImage(
        entry.key,
        entry.value,
      )) {
        images.add(
          MapEntry(
            entry.key,
            Map<String, dynamic>.from(
              entry.value as Map,
            ),
          ),
        );
      }
    }

    return images;
  }

  // =========================================================
  // IMAGE COUNT
  // =========================================================

  static int imageCount(
      AdminConfiguration configuration,
      ) {
    return imageEntries(configuration).length;
  }

  // =========================================================
  // SHOW GALLERY
  // =========================================================

  static Future<void> show(
      BuildContext context,
      AdminConfiguration configuration,
      ) async {
    final images =
    imageEntries(configuration);

    if (images.isEmpty ||
        !context.mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Attached images (${images.length})',
          ),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final image
                  in images)
                    Column(
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [
                        ConfigurationImageThumbnail(
                          configurationID:
                          configuration.id,
                          imageKey:
                          image.key,
                          imageData:
                          image.value,
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        SizedBox(
                          width: 110,
                          child: Text(
                            _readableLabel(
                              _imageParentKey(
                                image.key,
                              ),
                            ),
                            textAlign:
                            TextAlign.center,
                            maxLines: 2,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop();
              },
              child:
              const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================
// CONFIGURATION IMAGE THUMBNAIL
// ===========================================================

class ConfigurationImageThumbnail
    extends StatefulWidget {
  const ConfigurationImageThumbnail({
    super.key,
    required this.configurationID,
    required this.imageKey,
    required this.imageData,
    this.width = 110,
    this.height = 110,
  });

  final String configurationID;

  final String imageKey;

  final Map<String, dynamic> imageData;

  final double width;

  final double height;

  @override
  State<ConfigurationImageThumbnail>
  createState() =>
      _ConfigurationImageThumbnailState();
}

class _ConfigurationImageThumbnailState
    extends State<
        ConfigurationImageThumbnail> {
  String? _url;

  String? _error;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  @override
  void didUpdateWidget(
      covariant ConfigurationImageThumbnail
      oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.configurationID !=
        widget.configurationID ||
        oldWidget.imageKey !=
            widget.imageKey) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _error = null;
        _url = null;
      });
    }

    try {
      final response =
      await AdminRepository
          .getConfigurationImageUrl(
        configurationID:
        widget.configurationID,
        imageKey: widget.imageKey,
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
      return _placeholder(
        child: const SizedBox.square(
          dimension: 22,
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
          borderRadius:
          BorderRadius.circular(8),
          onTap: _loadImage,
          child: _placeholder(
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
        borderRadius:
        BorderRadius.circular(8),
        onTap: _showPreview,
        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(8),
          child: Container(
            width: widget.width,
            height: widget.height,
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
                    color:
                    Color(
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

  Widget _placeholder({
    required Widget child,
  }) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration:
      _thumbnailDecoration(),
      child: child,
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
        const Color(
          0xFFE2E8F0,
        ),
      ),
    );
  }

  // =========================================================
  // FULL IMAGE PREVIEW
  // =========================================================

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
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                          );
                        },
                        icon:
                        const Icon(
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
                    minScale: .5,
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
                          EdgeInsets.all(
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
// IMAGE HELPERS
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
  if (!imageKey.endsWith(
    'Image',
  )) {
    return imageKey;
  }

  return imageKey.substring(
    0,
    imageKey.length -
        'Image'.length,
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
      .replaceAll(
    '_',
    ' ',
  )
      .trim();

  if (spaced.isEmpty) {
    return key;
  }

  return '${spaced[0].toUpperCase()}'
      '${spaced.substring(1)}';
}