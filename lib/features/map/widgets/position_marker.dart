import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/widgets/map_dot.dart';

class PositionMarker extends StatelessWidget {
  const PositionMarker({super.key});

  static const double size = 22;

  @override
  Widget build(BuildContext context) {
    return MapDot(color: Theme.of(context).colorScheme.primary, size: size);
  }
}

class PositionMarkerLayer extends StatelessWidget {
  const PositionMarkerLayer({super.key, required this.position});

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: position,
          width: PositionMarker.size,
          height: PositionMarker.size,
          child: const PositionMarker(),
        ),
      ],
    );
  }
}
