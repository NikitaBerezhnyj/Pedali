class RideStats {
  const RideStats({
    required this.distanceMeters,
    required this.movingTime,
    required this.maxSpeedMps,
  });

  final double distanceMeters;
  final Duration movingTime;
  final double maxSpeedMps;

  double get avgSpeedMps {
    final seconds = movingTime.inMilliseconds / 1000.0;
    if (seconds <= 0) return 0;
    return distanceMeters / seconds;
  }
}
