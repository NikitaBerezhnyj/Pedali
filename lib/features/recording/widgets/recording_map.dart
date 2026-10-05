import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';
import 'package:pedali/features/map/widgets/position_marker.dart';
import 'package:pedali/features/map/widgets/route_map.dart';

class RecordingMap extends StatelessWidget {
  const RecordingMap({
    super.key,
    required this.mapController,
    required this.initialPosition,
    required this.trackPoints,
    required this.currentPosition,
    required this.onPositionChanged,
  });

  final MapController mapController;
  final LatLng initialPosition;
  final List<LatLng> trackPoints;
  final LatLng? currentPosition;
  final void Function(MapCamera camera, bool hasGesture) onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialPosition,
        initialZoom: 16,
        onPositionChanged: onPositionChanged,
      ),
      children: [
        const AppTileLayer(),
        RoutePolylineLayer(segments: [trackPoints]),
        if (currentPosition != null)
          PositionMarkerLayer(position: currentPosition!),
        const AppMapAttribution(),
      ],
    );
  }
}
