import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/utils/route_simplifier.dart';
import 'package:pedali/features/rides/providers/track_points_provider.dart';

final simplifiedRouteProvider = FutureProvider.family<List<List<LatLng>>, int>((
  ref,
  rideId,
) async {
  final points = await ref.watch(trackPointsProvider(rideId).future);

  final bySegment = <int, List<LatLng>>{};
  for (final point in points) {
    (bySegment[point.segmentId] ??= []).add(LatLng(point.lat, point.lon));
  }

  const simplifier = RouteSimplifier();

  return bySegment.values
      .map((s) => simplifier.simplify(s, toleranceMeters: 5))
      .where((s) => s.length >= 2)
      .toList();
});
