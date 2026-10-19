import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/features/map/domain/route_color_mode.dart';
import 'package:pedali/features/map/domain/route_point.dart';
import 'package:pedali/features/map/providers/route_color_mode_provider.dart';
import 'package:pedali/features/map/utils/speed_color_scale.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';
import 'package:pedali/features/map/widgets/route_color_mode_button.dart';
import 'package:pedali/features/map/widgets/route_endpoints_layer.dart';
import 'package:pedali/features/map/widgets/speed_legend.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

class RoutePolylineLayer extends StatelessWidget {
  const RoutePolylineLayer({super.key, required this.segments});

  final List<List<LatLng>> segments;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return PolylineLayer(
      polylines: segments
          .where((s) => s.length > 1)
          .map(
            (s) => Polyline(
              points: s,
              strokeWidth: 5,
              color: color,
              borderStrokeWidth: 1.5,
              borderColor: Colors.white,
            ),
          )
          .toList(),
    );
  }
}

class SpeedPolylineLayer extends StatelessWidget {
  const SpeedPolylineLayer({
    super.key,
    required this.segments,
    required this.scale,
  });

  final List<List<RoutePoint>> segments;
  final SpeedColorScale scale;

  @override
  Widget build(BuildContext context) {
    return PolylineLayer(
      polylines: segments
          .where((s) => s.length > 1)
          .map(
            (s) => Polyline(
              points: s.map((p) => p.position).toList(),
              strokeWidth: 5,
              borderStrokeWidth: 1.5,
              borderColor: Colors.white,
              gradientColors: s.map((p) => scale.colorAt(p.speedMps)).toList(),
            ),
          )
          .toList(),
    );
  }
}

class RouteColorLayer extends ConsumerWidget {
  const RouteColorLayer({
    super.key,
    required this.segments,
    required this.scale,
  });

  final List<List<RoutePoint>> segments;
  final SpeedColorScale scale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(routeColorModeProvider)) {
      RouteColorMode.speed => SpeedPolylineLayer(
        segments: segments,
        scale: scale,
      ),
      RouteColorMode.brand => RoutePolylineLayer(segments: segments.positions),
    };
  }
}

class RouteMap extends StatelessWidget {
  const RouteMap({
    super.key,
    required this.segments,
    this.height = defaultHeight,
    this.onExpand,
    this.fitPadding = const EdgeInsets.all(32),
  });

  static const double defaultHeight = 300;

  final List<List<RoutePoint>> segments;
  final double height;
  final VoidCallback? onExpand;
  final EdgeInsets fitPadding;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final positions = segments.positions;
    final points = positions.expand((s) => s).toList();
    final theme = Theme.of(context);

    if (points.length < 2) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: AppRadius.md,
          color: theme.colorScheme.surfaceContainerLow,
        ),
        child: Center(
          child: EmptyState(
            icon: Icons.route_outlined,
            title: t.routeNotVisibleTitle,
            description: t.routeNotVisibleDescription,
            iconColor: theme.colorScheme.primary,
            showIconBackground: false,
            iconSize: 52,
          ),
        ),
      );
    }

    return _buildMap(context, points);
  }

  Widget _buildMap(BuildContext context, List<LatLng> points) {
    final cs = Theme.of(context).colorScheme;
    final scale = SpeedColorScale.fromSegments(segments);

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: AppRadius.md,
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCameraFit: CameraFit.bounds(
                  bounds: LatLngBounds.fromPoints(points),
                  padding: fitPadding,
                  maxZoom: 17,
                ),
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                const AppTileLayer(),
                RouteColorLayer(segments: segments, scale: scale),
                RouteEndpointsLayer(segments: segments.positions),
                const AppMapAttribution(),
              ],
            ),

            Positioned(
              left: 12,
              bottom: 12,
              child: IgnorePointer(child: SpeedLegend(scale: scale)),
            ),

            if (onExpand != null)
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onExpand,
                ),
              ),

            const Positioned(
              right: 12,
              bottom: 12,
              child: RouteColorModeButton(),
            ),

            if (onExpand != null)
              Positioned(
                top: 12,
                right: 12,
                child: IgnorePointer(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: cs.surface.withValues(alpha: 0.9),
                    child: Icon(
                      Icons.open_in_full,
                      size: 18,
                      color: cs.onSurface,
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
