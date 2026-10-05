import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';
import 'package:pedali/features/map/widgets/route_endpoints_layer.dart';
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
          .map((s) => Polyline(points: s, strokeWidth: 4, color: color))
          .toList(),
    );
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

  final List<List<LatLng>> segments;
  final double height;
  final VoidCallback? onExpand;
  final EdgeInsets fitPadding;

  @override
  Widget build(BuildContext context) {
    final points = segments.expand((s) => s).toList();
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
            title: 'Маршрут ще не видно',
            description:
                'У цій поїздці замало GPS-точок для відображення маршруту.',
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
                RoutePolylineLayer(segments: segments),
                RouteEndpointsLayer(segments: segments),
                const AppMapAttribution(),
              ],
            ),
            if (onExpand != null)
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onExpand,
                ),
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
