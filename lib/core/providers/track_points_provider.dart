import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/providers/ride_repository_provider.dart';

final trackPointsProvider = FutureProvider.family<List<TrackPoint>, int>((
  ref,
  rideId,
) {
  return ref.read(rideRepositoryProvider).getTrackPoints(rideId);
});
