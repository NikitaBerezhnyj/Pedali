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
import 'package:pedali/features/rides/widgets/record_row.dart';
import 'package:pedali/features/rides/widgets/ride_summary_header.dart';
import 'package:pedali/features/rides/widgets/stat_row.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/screens/ride_share_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';

class RideDetailScreen extends ConsumerWidget {
  const RideDetailScreen({super.key, required this.rideId});

  final int rideId;

  bool _hasRoute(List<List<LatLng>> route) =>
      route.expand((s) => s).length >= 2;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final t = AppLocalizations.of(context)!;

    final ok = await showConfirmDialog(
      context,
      title: t.deleteRideTitle,
      message: t.deleteRideMessage,
      confirmLabel: t.delete,
      cancelLabel: t.cancel,
      destructive: true,
    );

    if (!ok || !context.mounted) return;

    await ref.read(rideRepositoryProvider).deleteRide(rideId);
    ref.invalidate(finishedRidesProvider);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void _share(
    BuildContext context,
    Ride ride,
    List<List<LatLng>> route,
    UnitSystem units,
    AppLocalizations t,
  ) {
    Navigator.push(
      context,
      RideShareScreen.route(
        RideShareCardData(
          segments: route,
          distance: units.formatDistance(ride.distanceMeters, t),
          movingTime: formatDuration(
            Duration(milliseconds: ride.movingTimeMs),
            t,
          ),
          avgSpeed: units.formatSpeed(ride.avgSpeedMps, t),
          maxSpeed: units.formatSpeed(ride.maxSpeedMps, t),
          date: formatStartedAt(ride.startedAt, locale: t.localeName),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context)!;

    final rideAsync = ref.watch(rideProvider(rideId));
    final routeAsync = ref.watch(simplifiedRouteProvider(rideId));
    final records = ref.watch(recordsProvider);
    final units = ref.watch(unitsProvider);

    final currentRide = rideAsync.value;
    final currentRoute = routeAsync.value;

    return Scaffold(
      appBar: AppHeader(
        title: t.rideDetailsTitle,
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            tooltip: t.share,
            onPressed:
                currentRide != null &&
                    currentRoute != null &&
                    _hasRoute(currentRoute)
                ? () => _share(context, currentRide, currentRoute, units, t)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: t.delete,
            onPressed: currentRide == null
                ? null
                : () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: AsyncValueView(
        value: rideAsync,
        errorTitle: t.rideLoadError,
        retryDescription: t.tryAgainLater,
        retryLabel: t.tryAgain,
        onRetry: () => ref.invalidate(rideProvider(rideId)),
        data: (ride) {
          if (ride == null) {
            return Center(
              child: EmptyState(
                icon: Icons.directions_bike_outlined,
                title: t.rideNotFoundTitle,
                description: t.rideNotFoundDescription,
              ),
            );
          }

          final recordLabels = <String>[
            if (records.longestDistance?.id == ride.id) t.recordLongestDistance,
            if (records.longestTime?.id == ride.id) t.recordLongestTime,
            if (records.highestAvgSpeed?.id == ride.id) t.recordHighestAvgSpeed,
            if (records.highestMaxSpeed?.id == ride.id) t.recordHighestMaxSpeed,
          ];

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RideSummaryHeader(
                    distance: units.formatDistance(ride.distanceMeters, t),
                    startedAt: formatStartedAt(
                      ride.startedAt,
                      locale: t.localeName,
                      includeTime: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AsyncValueView(
                    value: routeAsync,
                    stateHeight: RouteMap.defaultHeight,
                    errorTitle: t.routeLoadError,
                    retryDescription: t.tryAgainLater,
                    retryLabel: t.tryAgain,
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
                  if (recordLabels.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(t.recordsTitle, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            for (final label in recordLabels)
                              RecordRow(label: label),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(t.stats, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  StatRow(
                    icon: Icons.timer_outlined,
                    label: t.movingTime,
                    value: formatDuration(
                      Duration(milliseconds: ride.movingTimeMs),
                      t,
                    ),
                  ),
                  StatRow(
                    icon: Icons.schedule,
                    label: t.totalTime,
                    value: formatDuration(
                      Duration(milliseconds: ride.elapsedTimeMs),
                      t,
                    ),
                  ),
                  StatRow(
                    icon: Icons.speed,
                    label: t.averageSpeed,
                    value: units.formatSpeed(ride.avgSpeedMps, t),
                  ),
                  StatRow(
                    icon: Icons.bolt,
                    label: t.maximumSpeed,
                    value: units.formatSpeed(ride.maxSpeedMps, t),
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
