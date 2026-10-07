import 'package:pedali/core/db/app_database.dart';

class RideRecords {
  const RideRecords({
    this.longestDistance,
    this.longestTime,
    this.highestAvgSpeed,
    this.highestMaxSpeed,
  });

  static const minDistanceForSpeedRecord = 1000.0;

  final Ride? longestDistance;
  final Ride? longestTime;
  final Ride? highestAvgSpeed;
  final Ride? highestMaxSpeed;

  bool get isEmpty =>
      longestDistance == null &&
      longestTime == null &&
      highestAvgSpeed == null &&
      highestMaxSpeed == null;

  factory RideRecords.fromRides(List<Ride> rides) {
    final speedCandidates = rides.where(
      (ride) => ride.distanceMeters >= minDistanceForSpeedRecord,
    );

    return RideRecords(
      longestDistance: _best(rides, (r) => r.distanceMeters),
      longestTime: _best(rides, (r) => r.movingTimeMs),
      highestAvgSpeed: _best(speedCandidates, (r) => r.avgSpeedMps),
      highestMaxSpeed: _best(speedCandidates, (r) => r.maxSpeedMps),
    );
  }

  static Ride? _best(Iterable<Ride> rides, num Function(Ride ride) value) {
    if (rides.isEmpty) return null;

    return rides.reduce((a, b) => value(a) > value(b) ? a : b);
  }
}
