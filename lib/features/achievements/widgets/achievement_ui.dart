import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/l10n/app_localizations.dart';

extension AchievementMetricUi on AchievementMetric {
  IconData get icon => switch (this) {
    AchievementMetric.rideDistance => Icons.route_outlined,
    AchievementMetric.totalDistance => Icons.map_outlined,
    AchievementMetric.rideCount => Icons.directions_bike,
    AchievementMetric.maxSpeed => Icons.speed,
    AchievementMetric.rideDuration => Icons.timer_outlined,
  };

  String title(AppLocalizations t) => switch (this) {
    AchievementMetric.rideDistance => t.achievementSectionRideDistance,
    AchievementMetric.totalDistance => t.achievementSectionTotalDistance,
    AchievementMetric.rideCount => t.achievementSectionRideCount,
    AchievementMetric.maxSpeed => t.achievementSectionMaxSpeed,
    AchievementMetric.rideDuration => t.achievementSectionRideDuration,
  };
}

extension AchievementUi on Achievement {
  String label(AppLocalizations t) => switch (metric) {
    AchievementMetric.rideDistance ||
    AchievementMetric.totalDistance => t.achievementLabelKm(target),
    AchievementMetric.rideCount => t.achievementLabelRides(target),
    AchievementMetric.maxSpeed => t.achievementLabelKmh(target),
    AchievementMetric.rideDuration => t.achievementLabelHours(target),
  };

  String description(AppLocalizations t) => switch (metric) {
    AchievementMetric.rideDistance => t.achievementDescRideDistance(target),
    AchievementMetric.totalDistance => t.achievementDescTotalDistance(target),
    AchievementMetric.rideCount => t.achievementDescRideCount(target),
    AchievementMetric.maxSpeed => t.achievementDescMaxSpeed(target),
    AchievementMetric.rideDuration => t.achievementDescRideDuration(target),
  };

  String progressText(AppLocalizations t) {
    final isHours = metric == AchievementMetric.rideDuration;
    final shown = isHours ? (value * 10).floor() / 10 : value.floorToDouble();
    final number = NumberFormat.decimalPatternDigits(
      locale: t.localeName,
      decimalDigits: isHours ? 1 : 0,
    ).format(shown);

    return t.achievementProgress(number, label(t));
  }
}
