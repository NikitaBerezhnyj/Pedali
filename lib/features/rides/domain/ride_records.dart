import 'package:pedali/core/db/app_database.dart';

class RideRecords {
  const RideRecords({this.longest, this.fastest, this.longestByTime});

  static const minDistanceForSpeedRecord = 1000.0;

  final Ride? longest;
  final Ride? fastest;
  final Ride? longestByTime;

  factory RideRecords.fromRides(List<Ride> rides) {
    if (rides.isEmpty) {
      return const RideRecords();
    }

    final longest = rides.reduce(
      (a, b) => a.distanceMeters > b.distanceMeters ? a : b,
    );

    final longestByTime = rides.reduce(
      (a, b) => a.movingTimeMs > b.movingTimeMs ? a : b,
    );

    final fastestCandidates = rides.where(
      (ride) => ride.distanceMeters >= minDistanceForSpeedRecord,
    );

    final fastest = fastestCandidates.isEmpty
        ? null
        : fastestCandidates.reduce(
            (a, b) => a.avgSpeedMps > b.avgSpeedMps ? a : b,
          );

    return RideRecords(
      longest: longest,
      fastest: fastest,
      longestByTime: longestByTime,
    );
  }
}
