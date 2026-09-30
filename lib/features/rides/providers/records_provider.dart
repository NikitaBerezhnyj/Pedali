import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/rides/domain/ride_records.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';

final recordsProvider = Provider<RideRecords>((ref) {
  final rides = ref.watch(finishedRidesProvider).value ?? [];

  if (rides.isEmpty) {
    return const RideRecords();
  }

  final longest = rides.reduce(
    (a, b) => a.distanceMeters > b.distanceMeters ? a : b,
  );

  final longestByTime = rides.reduce(
    (a, b) => a.movingTimeMs > b.movingTimeMs ? a : b,
  );

  final fastestCandidates = rides
      .where((ride) => ride.distanceMeters >= 5000)
      .toList();

  Ride? fastest;

  if (fastestCandidates.isNotEmpty) {
    fastest = fastestCandidates.reduce(
      (a, b) => a.avgSpeedMps > b.avgSpeedMps ? a : b,
    );
  }

  return RideRecords(
    longest: longest,
    fastest: fastest,
    longestByTime: longestByTime,
  );
});
