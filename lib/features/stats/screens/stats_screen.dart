import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/features/stats/providers/monthly_stats_provider.dart';
import 'package:pedali/features/rides/providers/records_provider.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/stats/widgets/month_card.dart';
import 'package:pedali/features/stats/widgets/record_card.dart';

const _monthNames = [
  '',
  'Січень',
  'Лютий',
  'Березень',
  'Квітень',
  'Травень',
  'Червень',
  'Липень',
  'Серпень',
  'Вересень',
  'Жовтень',
  'Листопад',
  'Грудень',
];

String _monthLabel(String key) {
  final parts = key.split('-');
  final month = int.parse(parts[1]);
  return '${_monthNames[month]} ${parts[0]}';
}

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final units = ref.watch(unitsProvider);
    final records = ref.watch(recordsProvider);
    final monthly = ref.watch(monthlyStatsProvider);

    final hasStats =
        records.longest != null ||
        records.fastest != null ||
        records.longestByTime != null;

    return Scaffold(
      appBar: const AppHeader(title: 'Статистика', showBackButton: true),
      body: !hasStats
          ? const _EmptyStats()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Рекорди', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Column(
                  children: [
                    RecordCard(
                      icon: Icons.straighten,
                      label: 'Найдовша поїздка',
                      ride: records.longest,
                      valueBuilder: (r) =>
                          units.formatDistance(r.distanceMeters),
                    ),
                    RecordCard(
                      icon: Icons.speed,
                      label: 'Найшвидша поїздка',
                      ride: records.fastest,
                      valueBuilder: (r) => units.formatSpeed(r.avgSpeedMps),
                    ),
                    RecordCard(
                      icon: Icons.timer,
                      label: 'Найдовша за часом',
                      ride: records.longestByTime,
                      valueBuilder: (r) => formatDuration(
                        Duration(milliseconds: r.movingTimeMs),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text('По місяцях', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                monthly.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Помилка: $e'),
                  data: (months) {
                    if (months.isEmpty) {
                      return const Text('Поки немає даних');
                    }
                    return Column(
                      children: months
                          .map(
                            (month) => MonthCard(
                              title: _monthLabel(month.monthKey),
                              subtitle:
                                  '${month.rideCount} поїздок • '
                                  '${formatDuration(Duration(milliseconds: month.totalMovingTimeMs))}',
                              distance: units.formatDistance(
                                month.totalDistanceMeters,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class _EmptyStats extends StatelessWidget {
  const _EmptyStats();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events_outlined,
                size: 44,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Тут будуть твої рекорди',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Запиши свою першу поїздку, щоб почати збирати статистику.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
