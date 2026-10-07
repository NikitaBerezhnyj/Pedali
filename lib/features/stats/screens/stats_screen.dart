import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/core/widgets/app_list_card.dart';
import 'package:pedali/core/widgets/async_value_view.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/features/rides/providers/records_provider.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/stats/providers/monthly_stats_provider.dart';
import 'package:pedali/features/stats/widgets/record_tile.dart';
import 'package:pedali/l10n/app_localizations.dart';

String _monthLabel(String key, String locale) {
  final parts = key.split('-');
  final year = int.parse(parts[0]);
  final month = int.parse(parts[1]);

  return DateFormat.yMMMM(locale).format(DateTime(year, month));
}

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final units = ref.watch(unitsProvider);
    final records = ref.watch(recordsProvider);
    final monthly = ref.watch(monthlyStatsProvider);

    return Scaffold(
      appBar: AppHeader(title: t.statsTitle, showBackButton: true),
      body: records.isEmpty
          ? Center(
              child: EmptyState(
                icon: Icons.emoji_events_outlined,
                title: t.statsEmptyTitle,
                description: t.statsEmptyDescription,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(t.recordsTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                RecordTile(
                  icon: Icons.straighten,
                  label: t.recordLongestDistance,
                  ride: records.longestDistance,
                  locale: locale,
                  valueBuilder: (ride) =>
                      units.formatDistance(ride.distanceMeters, t),
                ),
                RecordTile(
                  icon: Icons.timer_outlined,
                  label: t.recordLongestTime,
                  ride: records.longestTime,
                  locale: locale,
                  valueBuilder: (ride) => formatDuration(
                    Duration(milliseconds: ride.movingTimeMs),
                    t,
                  ),
                ),
                RecordTile(
                  icon: Icons.speed,
                  label: t.recordHighestAvgSpeed,
                  ride: records.highestAvgSpeed,
                  locale: locale,
                  valueBuilder: (ride) =>
                      units.formatSpeed(ride.avgSpeedMps, t),
                ),
                RecordTile(
                  icon: Icons.bolt,
                  label: t.recordHighestMaxSpeed,
                  ride: records.highestMaxSpeed,
                  locale: locale,
                  valueBuilder: (ride) =>
                      units.formatSpeed(ride.maxSpeedMps, t),
                ),
                const SizedBox(height: 16),
                Text(t.monthlyStatsTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                AsyncValueView(
                  value: monthly,
                  errorTitle: t.monthlyStatsErrorTitle,
                  retryDescription: t.tryAgainLater,
                  retryLabel: t.tryAgain,
                  onRetry: () => ref.invalidate(monthlyStatsProvider),
                  data: (months) {
                    if (months.isEmpty) {
                      return Text(t.monthlyStatsEmpty);
                    }

                    return Column(
                      children: months.map((month) {
                        final duration = formatDuration(
                          Duration(milliseconds: month.totalMovingTimeMs),
                          t,
                        );

                        return AppListCard(
                          title: _monthLabel(month.monthKey, locale),
                          subtitle: t.monthlyStatsSubtitle(
                            month.rideCount,
                            duration,
                          ),
                          trailing: Text(
                            units.formatDistance(month.totalDistanceMeters, t),
                            style: theme.textTheme.titleMedium,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
