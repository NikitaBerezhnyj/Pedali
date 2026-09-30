import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/format.dart';
import 'package:pedali/core/map/tile_provider.dart';
import 'package:pedali/core/providers/finished_rides_provider.dart';
import 'package:pedali/core/providers/records_provider.dart';
import 'package:pedali/core/providers/ride_repository_provider.dart';
import 'package:pedali/core/providers/track_points_provider.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/units.dart';
import 'package:pedali/core/widgets/app_button.dart';
import 'package:pedali/core/widgets/app_header.dart';

final rideProvider = FutureProvider.family<Ride?, int>((ref, id) {
  return ref.read(rideRepositoryProvider).getRide(id);
});

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
    final tileProvider = mapStyleTiles[MapStyle.cycling]!;

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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: cs.onPrimaryContainer.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.directions_bike,
                          color: cs.onPrimaryContainer,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              units.formatDistance(ride.distanceMeters),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: cs.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formatStartedAt(
                                ride.startedAt,
                                includeTime: true,
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onPrimaryContainer.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            (achievement) => _Achievement(label: achievement),
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

                _StatRow(
                  icon: Icons.timer_outlined,
                  label: 'Час у русі',
                  value: formatDuration(
                    Duration(milliseconds: ride.movingTimeMs),
                  ),
                ),
                _StatRow(
                  icon: Icons.schedule,
                  label: 'Загальний час',
                  value: formatDuration(
                    Duration(milliseconds: ride.elapsedTimeMs),
                  ),
                ),
                _StatRow(
                  icon: Icons.speed,
                  label: 'Середня швидкість',
                  value: units.formatSpeed(ride.avgSpeedMps),
                ),
                _StatRow(
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
                        if (points.isEmpty) {
                          return const _MapPlaceholder(
                            text: 'Для цієї поїздки не збережено GPS-точок',
                          );
                        }
                        if (points.length < 2) {
                          return const _MapPlaceholder(
                            text: 'Замало точок, щоб намалювати маршрут',
                          );
                        }

                        final bySegment = <int, List<LatLng>>{};

                        for (final point in points) {
                          (bySegment[point.segmentId] ??= []).add(
                            LatLng(point.lat, point.lon),
                          );
                        }

                        final allLatLngs = points
                            .map((point) => LatLng(point.lat, point.lon))
                            .toList();

                        final bounds = LatLngBounds.fromPoints(allLatLngs);

                        return SizedBox(
                          height: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCameraFit: CameraFit.bounds(
                                  bounds: bounds,
                                  padding: const EdgeInsets.all(24),
                                ),
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: tileProvider.urlTemplate,
                                  subdomains: tileProvider.subdomains,
                                  userAgentPackageName:
                                      tileProvider.userAgentPackageName,
                                ),
                                PolylineLayer(
                                  polylines: bySegment.values
                                      .map(
                                        (segment) => Polyline(
                                          points: segment,
                                          strokeWidth: 4,
                                          color: cs.primary,
                                        ),
                                      )
                                      .toList(),
                                ),
                                RichAttributionWidget(
                                  attributions: [
                                    TextSourceAttribution(
                                      tileProvider.attribution,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
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

class _Achievement extends StatelessWidget {
  const _Achievement({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              size: 20,
              color: cs.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.check, size: 18, color: cs.primary),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.iconTheme.color),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
