import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteEndpointsLayer extends StatelessWidget {
  const RouteEndpointsLayer({super.key, required this.segments});
  final List<List<LatLng>> segments;

  @override
  Widget build(BuildContext context) {
    final valid = segments.where((s) => s.isNotEmpty).toList();
    if (valid.isEmpty) return const SizedBox.shrink();

    Widget dot(Color color) => Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
    );

    return MarkerLayer(
      markers: [
        Marker(
          point: valid.first.first,
          width: 18,
          height: 18,
          child: dot(Colors.green),
        ),
        Marker(
          point: valid.last.last,
          width: 18,
          height: 18,
          child: dot(Colors.red),
        ),
      ],
    );
  }
}
