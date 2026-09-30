import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PositionMarker extends StatelessWidget {
  const PositionMarker({super.key});

  static const double size = 22;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.primary,
        shape: BoxShape.circle,

        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
    );
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
