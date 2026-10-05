import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          ? const Center(
              child: EmptyState(
                icon: Icons.emoji_events_outlined,
                title: 'Тут будуть твої рекорди',
                description:
                    'Запиши свою першу поїздку, щоб почати збирати статистику.',
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Рекорди', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                RecordTile(
                  icon: Icons.straighten,
                  label: 'Найдовша поїздка',
                  ride: records.longest,
                  valueBuilder: (r) => units.formatDistance(r.distanceMeters),
                ),
                RecordTile(
                  icon: Icons.speed,
                  label: 'Найшвидша поїздка',
                  ride: records.fastest,
                  valueBuilder: (r) => units.formatSpeed(r.avgSpeedMps),
                ),
                RecordTile(
                  icon: Icons.timer_outlined,
                  label: 'Найдовша за часом',
                  ride: records.longestByTime,
                  valueBuilder: (r) =>
                      formatDuration(Duration(milliseconds: r.movingTimeMs)),
                ),
                const SizedBox(height: 16),
                Text('По місяцях', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                AsyncValueView(
                  value: monthly,
                  errorTitle: 'Не вдалося завантажити статистику',
                  onRetry: () => ref.invalidate(monthlyStatsProvider),
                  data: (months) {
                    if (months.isEmpty) {
                      return const Text('Поки немає даних');
                    }

                    return Column(
                      children: months.map((month) {
                        return AppListCard(
                          title: _monthLabel(month.monthKey),
                          subtitle:
                              '${month.rideCount} поїздок • '
                              '${formatDuration(Duration(milliseconds: month.totalMovingTimeMs))}',
                          trailing: Text(
                            units.formatDistance(month.totalDistanceMeters),
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
