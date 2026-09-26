import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/format.dart';
import 'package:pedali/core/providers/monthly_stats_provider.dart';
import 'package:pedali/core/providers/records_provider.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/units.dart';
import 'package:pedali/core/widgets/app_header.dart';

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

    return Scaffold(
      appBar: const AppHeader(title: 'Статистика', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Рекорди', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Column(
            children: [
              _RecordCard(
                icon: Icons.straighten,
                label: 'Найдовша поїздка',
                value: records.longest == null
                    ? '—'
                    : units.formatDistance(records.longest!.distanceMeters),
              ),
              _RecordCard(
                icon: Icons.speed,
                label: 'Найшвидша поїздка',
                value: records.fastest == null
                    ? '—'
                    : units.formatSpeed(records.fastest!.avgSpeedMps),
              ),
              _RecordCard(
                icon: Icons.timer,
                label: 'Найдовша за часом',
                value: records.longestByTime == null
                    ? '—'
                    : formatDuration(
                        Duration(
                          milliseconds: records.longestByTime!.movingTimeMs,
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // monthly залишається без змін
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
                      (month) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(_monthLabel(month.monthKey)),
                          subtitle: Text(
                            '${month.rideCount} поїздок • '
                            '${formatDuration(Duration(milliseconds: month.totalMovingTimeMs))}',
                          ),
                          trailing: Text(
                            units.formatDistance(month.totalDistanceMeters),
                            style: theme.textTheme.titleMedium,
                          ),
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

class _RecordCard extends StatelessWidget {
  const _RecordCard({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(label),
        trailing: Text(value, style: theme.textTheme.titleMedium),
      ),
    );
  }
}
