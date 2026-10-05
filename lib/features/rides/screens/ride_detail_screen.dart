import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/core/widgets/async_value_view.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/core/widgets/show_confirm_dialog.dart';
import 'package:pedali/features/map/providers/simplified_route_provider.dart';
import 'package:pedali/features/map/widgets/route_fullscreen_screen.dart';
import 'package:pedali/features/map/widgets/route_map.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/features/rides/providers/records_provider.dart';
import 'package:pedali/features/rides/providers/ride_provider.dart';
import 'package:pedali/features/rides/providers/ride_repository_provider.dart';
import 'package:pedali/features/rides/widgets/achievements_card.dart';
import 'package:pedali/features/rides/widgets/ride_summary_header.dart';
import 'package:pedali/features/rides/widgets/stat_row.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/screens/ride_share_screen.dart';

class RideDetailScreen extends ConsumerWidget {
  const RideDetailScreen({super.key, required this.rideId});

  final int rideId;

  bool _hasRoute(List<List<LatLng>> route) =>
      route.expand((s) => s).length >= 2;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Видалити поїздку?',
      message: 'Поїздку разом із маршрутом буде видалено назавжди.',
      confirmLabel: 'Видалити',
      destructive: true,
    );

    if (!ok || !context.mounted) return;

    await ref.read(rideRepositoryProvider).deleteRide(rideId);
    ref.invalidate(finishedRidesProvider);

    if (context.mounted) Navigator.pop(context);
  }

  void _share(
    BuildContext context,
    Ride ride,
    List<List<LatLng>> route,
    UnitSystem units,
  ) {
    Navigator.push(
      context,
      RideShareScreen.route(
        ShareCardData(
          segments: route,
          distance: units.formatDistance(ride.distanceMeters),
          movingTime: formatDuration(Duration(milliseconds: ride.movingTimeMs)),
          avgSpeed: units.formatSpeed(ride.avgSpeedMps),
          maxSpeed: units.formatSpeed(ride.maxSpeedMps),
          date: formatStartedAt(ride.startedAt),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final rideAsync = ref.watch(rideProvider(rideId));
    final routeAsync = ref.watch(simplifiedRouteProvider(rideId));
    final records = ref.watch(recordsProvider);
    final units = ref.watch(unitsProvider);

    final currentRide = rideAsync.value;
    final currentRoute = routeAsync.value;

    return Scaffold(
      appBar: AppHeader(
        title: 'Деталі поїздки',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: 'Поділитися',
            onPressed:
                currentRide != null &&
                    currentRoute != null &&
                    _hasRoute(currentRoute)
                ? () => _share(context, currentRide, currentRoute, units)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Видалити',
            onPressed: currentRide == null
                ? null
                : () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: AsyncValueView(
        value: rideAsync,
        errorTitle: 'Не вдалося завантажити поїздку',
        onRetry: () => ref.invalidate(rideProvider(rideId)),
        data: (ride) {
          if (ride == null) {
            return const Center(
              child: EmptyState(
                icon: Icons.directions_bike_outlined,
                title: 'Поїздку не знайдено',
                description: 'Можливо, її вже було видалено.',
              ),
            );
          }

          final achievements = <String>[
            if (records.longest?.id == ride.id) 'Найдовша поїздка',
            if (records.fastest?.id == ride.id) 'Найвища середня швидкість',
            if (records.longestByTime?.id == ride.id) 'Найдовший час у русі',
          ];

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RideSummaryHeader(
                    distance: units.formatDistance(ride.distanceMeters),
                    startedAt: formatStartedAt(
                      ride.startedAt,
                      includeTime: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  AsyncValueView(
                    value: routeAsync,
                    stateHeight: RouteMap.defaultHeight,
                    errorTitle: 'Не вдалося завантажити маршрут',
                    onRetry: () =>
                        ref.invalidate(simplifiedRouteProvider(rideId)),
                    data: (route) => RouteMap(
                      segments: route,
                      onExpand: () => Navigator.push(
                        context,
                        RouteFullscreenScreen.route(route),
                      ),
                    ),
                  ),

                  if (achievements.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text('Досягнення', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            for (final a in achievements)
                              AchievementCard(label: a),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                  Text('Показники', style: theme.textTheme.titleMedium),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
