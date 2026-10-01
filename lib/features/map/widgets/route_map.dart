import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';

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
  });

  static const double defaultHeight = 220;

  final List<List<LatLng>> segments;
  final double height;

  @override
  Widget build(BuildContext context) {
    final points = segments.expand((s) => s).toList();
    final theme = Theme.of(context);

    if (points.length < 2) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.surfaceContainerLow,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.route_outlined,
                  size: 52,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Маршрут ще не видно',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'У цій поїздці замало GPS-точок для відображення маршруту.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return _buildMap(context, points);
  }

  Widget _buildMap(BuildContext context, List<LatLng> points) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(points),
              padding: const EdgeInsets.all(24),
              maxZoom: 17,
            ),
          ),
          children: [
            const AppTileLayer(),
            RoutePolylineLayer(segments: segments),
            const AppMapAttribution(),
          ],
        ),
      ),
    );
  }
}
