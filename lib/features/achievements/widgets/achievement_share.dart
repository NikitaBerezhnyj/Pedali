import 'package:flutter/material.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/widgets/achievement_ui.dart';
import 'package:pedali/features/share/widget/achievement_share_card.dart';
import 'package:pedali/features/share/widget/share_card_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';

void openAchievementShare(
  NavigatorState navigator,
  AppLocalizations t,
  Achievement achievement,
) {
  navigator.push(
    ShareCardScreen.route(
      title: t.shareAchievementTitle,
      card: AchievementShareCard(
        icon: achievement.metric.icon,
        label: achievement.label(t),
        description: achievement.description(t),
        completedLabel: t.achievementCompleted,
      ),
    ),
  );
}
