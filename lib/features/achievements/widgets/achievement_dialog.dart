import 'package:flutter/material.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/widgets/achievement_ui.dart';
import 'package:pedali/features/share/widget/achievement_share_card.dart';
import 'package:pedali/features/share/widget/share_card_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

class AchievementDialog extends StatelessWidget {
  const AchievementDialog({super.key, required this.achievement});

  final Achievement achievement;

  void _share(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    navigator.pop();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final t = AppLocalizations.of(context)!;
    final achieved = achievement.achieved;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: achieved ? cs.primary : cs.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievement.metric.icon,
                size: 40,
                color: achieved ? cs.onPrimary : cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              achievement.label(t),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              achievement.description(t),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            if (achieved) ...[
              Text(
                t.achievementCompleted,
                style: theme.textTheme.labelLarge?.copyWith(color: cs.primary),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
                  onPressed: () => _share(context),
                  icon: const Icon(Icons.ios_share),
                  label: Text(t.shareButton),
                ),
              ),
            ] else ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: achievement.progress,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                achievement.progressText(t),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
