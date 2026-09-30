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
    final all = segments.expand((s) => s).toList();
    assert(all.length >= 2, 'RouteMap потребує щонайменше 2 точки');

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCameraFit: CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(all),
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
