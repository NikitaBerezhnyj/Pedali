import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/models/ride_records.dart';
import 'package:pedali/core/providers/ride_repository_provider.dart';

final recordsProvider = FutureProvider<RideRecords>((ref) async {
  final repository = ref.read(rideRepositoryProvider);

  final results = await Future.wait([
    repository.longestRide(),
    repository.fastestRide(),
    repository.longestRideByTime(),
  ]);

  return RideRecords(
    longest: results[0],
    fastest: results[1],
    longestByTime: results[2],
  );
});
