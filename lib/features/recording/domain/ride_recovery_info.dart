class RideRecoveryInfo {
  const RideRecoveryInfo({
    required this.distanceMeters,
    required this.movingTime,
    required this.startedAt,
  });

  final double distanceMeters;
  final Duration movingTime;
  final DateTime startedAt;
}
