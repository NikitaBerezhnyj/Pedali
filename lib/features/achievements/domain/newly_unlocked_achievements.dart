import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/domain/achievement_stats.dart';

List<Achievement> newlyUnlockedAchievements(
  List<Ride> rides,
  int justFinishedRideId,
) {
  final before = evaluateAchievements(
    AchievementStats.fromRides(rides.where((r) => r.id != justFinishedRideId)),
  );
  final after = evaluateAchievements(AchievementStats.fromRides(rides));

  final alreadyDone = {
    for (final a in before)
      if (a.achieved) a.id,
  };

  final highest = <AchievementMetric, Achievement>{};

  for (final a in after) {
    if (!a.achieved || alreadyDone.contains(a.id)) continue;

    final current = highest[a.metric];
    if (current == null || a.target > current.target) {
      highest[a.metric] = a;
    }
  }

  return highest.values.toList();
}
