import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/map/domain/route_point.dart';
import 'package:pedali/features/map/utils/route_simplifier.dart';
import 'package:pedali/features/map/utils/speed_smoother.dart';
import 'package:pedali/features/rides/providers/track_points_provider.dart';

final routePointsProvider = FutureProvider.family<List<List<RoutePoint>>, int>((
  ref,
  rideId,
) async {
  final points = await ref.watch(trackPointsProvider(rideId).future);

  final bySegment = <int, List<TrackPoint>>{};
  for (final point in points) {
    (bySegment[point.segmentId] ??= []).add(point);
  }

  const simplifier = RouteSimplifier();

  return bySegment.values
      .map((segment) {
        final positions = segment.map((p) => LatLng(p.lat, p.lon)).toList();
        final speeds = smoothedSpeeds(segment);
        final indexes = simplifier.simplifyIndexes(positions);

        return [
          for (final i in indexes)
            RoutePoint(position: positions[i], speedMps: speeds[i]),
        ];
      })
      .where((s) => s.length >= 2)
      .toList();
});
