import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/core/widgets/async_value_view.dart';
import 'package:pedali/features/achievements/domain/achievement.dart';
import 'package:pedali/features/achievements/providers/achievements_provider.dart';
import 'package:pedali/features/achievements/widgets/achievement_dialog.dart';
import 'package:pedali/features/achievements/widgets/achievement_tile.dart';
import 'package:pedali/features/achievements/widgets/achievement_ui.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppHeader(title: t.achievementsTitle, showBackButton: true),
      body: AsyncValueView(
        value: ref.watch(achievementsProvider),
        errorTitle: t.ridesLoadError,
        retryDescription: t.tryAgainLater,
        retryLabel: t.tryAgain,
        onRetry: () => ref.invalidate(finishedRidesProvider),
        data: (achievements) => ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            for (final metric in AchievementMetric.values)
              _Section(
                metric: metric,
                items: achievements.where((a) => a.metric == metric).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.metric, required this.items});

  static const _columns = 3;

  final AchievementMetric metric;
  final List<Achievement> items;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(metric.title(t), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = math.max(
                0.0,
                (constraints.maxWidth - AchievementTile.size * _columns) /
                    (_columns - 1),
              );

              return Wrap(
                spacing: gap,
                children: [
                  for (final a in items)
                    AchievementTile(
                      achievement: a,
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (_) => AchievementDialog(achievement: a),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
