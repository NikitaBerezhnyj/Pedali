import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/features/recording/providers/recorder_controller_provider.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/features/rides/widgets/ride_card.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_button.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/recording/screens/recording_screen.dart';
import 'package:pedali/features/rides/screens/ride_detail_screen.dart';
import 'package:pedali/features/settings/screens/settings_screen.dart';
import 'package:pedali/features/stats/screens/stats_screen.dart';

class RideListScreen extends ConsumerStatefulWidget {
  const RideListScreen({super.key});
  @override
  ConsumerState<RideListScreen> createState() => _RideListScreenState();
}

class _RideListScreenState extends ConsumerState<RideListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkStaleRide());
  }

  Future<void> _checkStaleRide() async {
    final controller = ref.read(recorderControllerProvider.notifier);
    final stale = await controller.checkForActiveRide();
    if (stale == null || !mounted) return;

    final info = await controller.getStaleRideInfo(stale);
    if (!mounted) return;

    final units = ref.read(unitsProvider);
    final agoText = _formatAgo(
      DateTime.now().toUtc().difference(info.startedAt),
    );

    final resume = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Незавершена поїздка'),
        content: Text(
          'Схоже, застосунок закрився під час запису.\n\n'
          'Почата $agoText тому · ${units.formatDistance(info.distanceMeters)}\n\n'
          'Продовжити цю поїздку чи видалити запис?',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Видалити'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Продовжити'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (resume == true) {
      await controller.resumeStaleRide(stale);
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RecordingScreen()),
      );
      ref.invalidate(finishedRidesProvider);
    } else {
      await controller.discardStaleRide(stale);
      ref.invalidate(finishedRidesProvider);
    }
  }

  String _formatAgo(Duration d) {
    if (d.inDays > 0) return '${d.inDays} дн.';
    if (d.inHours > 0) return '${d.inHours} год';
    if (d.inMinutes > 0) return '${d.inMinutes} хв';
    return 'щойно';
  }

  Future<void> _openStats() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StatsScreen()),
    );
  }

  Future<void> _startRide() async {
    await ref.read(recorderControllerProvider.notifier).start();
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RecordingScreen()),
    );
    ref.invalidate(finishedRidesProvider);
  }

  Future<void> _openSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final units = ref.watch(unitsProvider);
    final ridesAsync = ref.watch(finishedRidesProvider);
    return Scaffold(
      appBar: AppHeader(
        action: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: _openSettings,
        ),
      ),
      body: ridesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Помилка: $e')),
        data: (rides) {
          if (rides.isEmpty) {
            return Center(
              child: Text(
                'Поки що немає поїздок',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rides.length,
            itemBuilder: (context, i) {
              final ride = rides[i];
              return RideCard(
                distance: units.formatDistance(ride.distanceMeters),
                subtitle:
                    '${formatDuration(Duration(milliseconds: ride.movingTimeMs))} • '
                    '${units.formatSpeed(ride.avgSpeedMps)}',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RideDetailScreen(rideId: ride.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineButton(
              label: 'Статистика',
              icon: Icons.bar_chart,
              onPressed: _openStats,
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Почати поїздку',
              icon: Icons.directions_bike,
              onPressed: _startRide,
            ),
          ],
        ),
      ),
    );
  }
}
