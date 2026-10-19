import 'package:latlong2/latlong.dart';

class RoutePoint {
  const RoutePoint({required this.position, required this.speedMps});

  final LatLng position;
  final double speedMps;
}

extension RouteSegments on List<List<RoutePoint>> {
  List<List<LatLng>> get positions =>
      map((s) => s.map((p) => p.position).toList()).toList();
}
