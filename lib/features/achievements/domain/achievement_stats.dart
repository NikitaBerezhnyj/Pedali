import 'package:pedali/core/db/app_database.dart';

class AchievementStats {
  const AchievementStats({
    required this.totalKm,
    required this.bestRideKm,
    required this.rideCount,
    required this.maxSpeedKmh,
    required this.longestRideHours,
  });

  factory AchievementStats.fromRides(Iterable<Ride> rides) {
    var totalKm = 0.0;
    var bestRideKm = 0.0;
    var rideCount = 0;
    var maxSpeedKmh = 0.0;
    var longestRideHours = 0.0;

    for (final ride in rides) {
      final km = ride.distanceMeters / 1000;
      final speedKmh = ride.maxSpeedMps * 3.6;
      final hours = ride.movingTimeMs / Duration.millisecondsPerHour;

      totalKm += km;
      rideCount++;
      if (km > bestRideKm) bestRideKm = km;
      if (speedKmh > maxSpeedKmh) maxSpeedKmh = speedKmh;
      if (hours > longestRideHours) longestRideHours = hours;
    }

    return AchievementStats(
      totalKm: totalKm,
      bestRideKm: bestRideKm,
      rideCount: rideCount,
      maxSpeedKmh: maxSpeedKmh,
      longestRideHours: longestRideHours,
    );
  }

  final double totalKm;
  final double bestRideKm;
  final int rideCount;
  final double maxSpeedKmh;
  final double longestRideHours;
}
