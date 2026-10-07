import 'package:pedali/features/achievements/widgets/achievement_stats.dart';

enum AchievementMetric {
  rideDistance,
  totalDistance,
  rideCount,
  maxSpeed,
  rideDuration;

  double valueOf(AchievementStats stats) => switch (this) {
    AchievementMetric.rideDistance => stats.bestRideKm,
    AchievementMetric.totalDistance => stats.totalKm,
    AchievementMetric.rideCount => stats.rideCount.toDouble(),
    AchievementMetric.maxSpeed => stats.maxSpeedKmh,
    AchievementMetric.rideDuration => stats.longestRideHours,
  };
}

class Achievement {
  const Achievement({
    required this.metric,
    required this.target,
    required this.value,
  });

  final AchievementMetric metric;

  final int target;

  final double value;

  String get id => '${metric.name}_$target';

  bool get achieved => value >= target;

  double get progress => (value / target).clamp(0.0, 1.0).toDouble();
}

const _targets = <AchievementMetric, List<int>>{
  AchievementMetric.rideDistance: [10, 25, 50, 100],
  AchievementMetric.totalDistance: [100, 500, 1000],
  AchievementMetric.rideCount: [1, 10, 50],
  AchievementMetric.maxSpeed: [20, 30, 40],
  AchievementMetric.rideDuration: [1, 2, 3],
};

List<Achievement> evaluateAchievements(AchievementStats stats) => [
  for (final entry in _targets.entries)
    for (final target in entry.value)
      Achievement(
        metric: entry.key,
        target: target,
        value: entry.key.valueOf(stats),
      ),
];
