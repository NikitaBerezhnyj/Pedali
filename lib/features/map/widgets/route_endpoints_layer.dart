import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/theme/app_colors.dart';
import 'package:pedali/features/map/widgets/map_dot.dart';

class RouteEndpointsLayer extends StatelessWidget {
  const RouteEndpointsLayer({super.key, required this.segments});

  final List<List<LatLng>> segments;

  static const double _size = 18;

  @override
  Widget build(BuildContext context) {
    final valid = segments.where((s) => s.isNotEmpty).toList();
    if (valid.isEmpty) return const SizedBox.shrink();

    final colors = context.appColors;

    return MarkerLayer(
      markers: [
        Marker(
          point: valid.first.first,
          width: _size,
          height: _size,
          child: MapDot(color: colors.mapStart, size: _size),
        ),
        Marker(
          point: valid.last.last,
          width: _size,
          height: _size,
          child: MapDot(color: colors.mapEnd, size: _size),
        ),
      ],
    );
  }
}
