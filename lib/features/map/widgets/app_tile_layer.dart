import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/map/domain/tile_config.dart';
import 'package:pedali/features/map/providers/map_style_provider.dart';

class AppTileLayer extends ConsumerWidget {
  const AppTileLayer({super.key, this.config});

  final TileProviderConfig? config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileConfig = config ?? ref.watch(activeMapStyleProvider)!;

    return TileLayer(
      urlTemplate: tileConfig.urlTemplate,
      subdomains: tileConfig.subdomains,
      userAgentPackageName: tileConfig.userAgentPackageName,
    );
  }
}

class AppMapAttribution extends ConsumerWidget {
  const AppMapAttribution({super.key, this.config});

  final TileProviderConfig? config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileConfig = config ?? ref.watch(activeMapStyleProvider)!;

    return RichAttributionWidget(
      attributions: [TextSourceAttribution(tileConfig.attribution)],
    );
  }
}
