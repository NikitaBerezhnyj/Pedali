import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/providers/route_points_provider.dart';

final simplifiedRouteProvider = FutureProvider.family<List<List<LatLng>>, int>((
  ref,
  rideId,
) async {
  final segments = await ref.watch(routePointsProvider(rideId).future);

  return segments.map((s) => s.map((p) => p.position).toList()).toList();
});
