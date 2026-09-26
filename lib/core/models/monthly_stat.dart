class MonthlyStat {
  const MonthlyStat({
    required this.monthKey, // "2026-09"
    required this.totalDistanceMeters,
    required this.rideCount,
    required this.totalMovingTimeMs,
  });

  final String monthKey;
  final double totalDistanceMeters;
  final int rideCount;
  final int totalMovingTimeMs;
}
