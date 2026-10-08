import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/domain/achievement_stats.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';

final achievementsProvider = Provider<AsyncValue<List<Achievement>>>((ref) {
  return ref
      .watch(finishedRidesProvider)
      .whenData(
        (rides) => evaluateAchievements(AchievementStats.fromRides(rides)),
      );
});
