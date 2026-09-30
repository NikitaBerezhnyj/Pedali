import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/providers/monthly_stats_provider.dart';
import 'package:pedali/core/providers/records_provider.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/rides/ride_detail_screen.dart';

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
                ride: records.longest,
                valueBuilder: (r) => units.formatDistance(r.distanceMeters),
              ),
              _RecordCard(
                icon: Icons.speed,
                label: 'Найшвидша поїздка',
                ride: records.fastest,
                valueBuilder: (r) => units.formatSpeed(r.avgSpeedMps),
              ),
              _RecordCard(
                icon: Icons.timer,
                label: 'Найдовша за часом',
                ride: records.longestByTime,
                valueBuilder: (r) =>
                    formatDuration(Duration(milliseconds: r.movingTimeMs)),
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
    required this.ride,
    required this.valueBuilder,
  });

  final IconData icon;
  final String label;
  final Ride? ride;
  final String Function(Ride ride) valueBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final r = ride;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: r == null
            ? null
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RideDetailScreen(rideId: r.id),
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: r == null
              ? Row(
                  children: [
                    Icon(icon, color: cs.primary, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text('—'),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: cs.primary, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const SizedBox(width: 32),
                        Expanded(
                          child: Text(
                            formatStartedAt(r.startedAt),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        Text(
                          valueBuilder(r),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: cs.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
