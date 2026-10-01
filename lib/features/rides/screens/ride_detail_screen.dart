import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/features/map/utils/route_simplifier.dart';
import 'package:pedali/features/map/widgets/route_map.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/features/rides/providers/records_provider.dart';
import 'package:pedali/features/rides/providers/ride_provider.dart';
import 'package:pedali/features/rides/providers/ride_repository_provider.dart';
import 'package:pedali/features/rides/providers/track_points_provider.dart';
import 'package:pedali/features/rides/widgets/achievements_card.dart';
import 'package:pedali/features/rides/widgets/ride_summary_header.dart';
import 'package:pedali/features/rides/widgets/stat_row.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_button.dart';
import 'package:pedali/core/widgets/app_header.dart';

class RideDetailScreen extends ConsumerWidget {
  const RideDetailScreen({super.key, required this.rideId});

  final int rideId;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Видалити поїздку?'),
        content: const Text('Цю дію не можна скасувати.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Скасувати'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Видалити'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(rideRepositoryProvider).deleteRide(rideId);
    ref.invalidate(finishedRidesProvider);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final rideAsync = ref.watch(rideProvider(rideId));
    final records = ref.watch(recordsProvider);
    final units = ref.watch(unitsProvider);

    return Scaffold(
      appBar: const AppHeader(title: 'Деталі поїздки', showBackButton: true),
      body: rideAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (ride) {
          if (ride == null) {
            return const SizedBox.shrink();
          }

          final achievements = <String>[];

          if (records.longest?.id == ride.id) {
            achievements.add('Найдовша поїздка');
          }

          if (records.fastest?.id == ride.id) {
            achievements.add('Найвища середня швидкість');
          }

          if (records.longestByTime?.id == ride.id) {
            achievements.add('Найдовший час у русі');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RideSummaryHeader(
                  distance: units.formatDistance(ride.distanceMeters),
                  startedAt: formatStartedAt(ride.startedAt, includeTime: true),
                ),

                if (achievements.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Досягнення',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: achievements
                          .map(
                            (achievement) =>
                                AchievementCard(label: achievement),
                          )
                          .toList(),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                Text(
                  'Показники',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                StatRow(
                  icon: Icons.timer_outlined,
                  label: 'Час у русі',
                  value: formatDuration(
                    Duration(milliseconds: ride.movingTimeMs),
                  ),
                ),
                StatRow(
                  icon: Icons.schedule,
                  label: 'Загальний час',
                  value: formatDuration(
                    Duration(milliseconds: ride.elapsedTimeMs),
                  ),
                ),
                StatRow(
                  icon: Icons.speed,
                  label: 'Середня швидкість',
                  value: units.formatSpeed(ride.avgSpeedMps),
                ),
                StatRow(
                  icon: Icons.bolt,
                  label: 'Максимальна швидкість',
                  value: units.formatSpeed(ride.maxSpeedMps),
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, _) {
                    final pointsAsync = ref.watch(trackPointsProvider(rideId));

                    return pointsAsync.when(
                      loading: () => const SizedBox(
                        height: 220,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (e, _) => _MapPlaceholder(
                        text: 'Не вдалося завантажити маршрут',
                      ),
                      data: (points) {
                        final bySegment = <int, List<LatLng>>{};

                        for (final point in points) {
                          (bySegment[point.segmentId] ??= []).add(
                            LatLng(point.lat, point.lon),
                          );
                        }

                        final simplifier = const RouteSimplifier();

                        final simplifiedSegments = bySegment.values
                            .map(
                              (segment) => simplifier.simplify(
                                segment,
                                toleranceMeters: 5,
                              ),
                            )
                            .where((segment) => segment.length >= 2)
                            .toList();

                        return RouteMap(segments: simplifiedSegments);
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: SizedBox(
          width: double.infinity,
          child: OutlineButton(
            label: 'Видалити поїздку',
            icon: Icons.delete_outline,
            color: Colors.red,
            onPressed: () => _confirmDelete(context, ref),
          ),
        ),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
