import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/core/widgets/app_list_card.dart';
import 'package:pedali/core/widgets/async_value_view.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/features/recording/providers/recorder_controller_provider.dart';
import 'package:pedali/features/recording/screens/recording_screen.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/features/rides/screens/ride_detail_screen.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/settings/screens/settings_screen.dart';
import 'package:pedali/features/stats/screens/stats_screen.dart';
import 'package:pedali/theme/app_tokens.dart';

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
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Видалити'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
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
    } else {
      await controller.discardStaleRide(stale);
    }
    ref.invalidate(finishedRidesProvider);
  }

  String _formatAgo(Duration d) {
    if (d.inDays > 0) return '${d.inDays} дн.';
    if (d.inHours > 0) return '${d.inHours} год';
    if (d.inMinutes > 0) return '${d.inMinutes} хв';
    return 'щойно';
  }

  Future<void> _openStats() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const StatsScreen()),
  );

  Future<void> _openSettings() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const SettingsScreen()),
  );

  Future<void> _startRide() async {
    await ref.read(recorderControllerProvider.notifier).start();
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RecordingScreen()),
    );
    ref.invalidate(finishedRidesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final units = ref.watch(unitsProvider);

    return Scaffold(
      appBar: AppHeader(
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Статистика',
            onPressed: _openStats,
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Налаштування',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(finishedRidesProvider),
        onRetry: () => ref.invalidate(finishedRidesProvider),
        data: (rides) {
          if (rides.isEmpty) {
            return const Center(
              child: EmptyState(
                icon: Icons.directions_bike,
                title: 'Час вирушати',
                description: 'Запиши свою першу поїздку, і вона зʼявиться тут.',
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: rides.length,
            itemBuilder: (context, i) {
              final ride = rides[i];

              return AppListCard(
                title: units.formatDistance(ride.distanceMeters),
                subtitle:
                    '${formatStartedAt(ride.startedAt)} • '
                    '${formatDuration(Duration(milliseconds: ride.movingTimeMs))}',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      units.formatSpeed(ride.avgSpeedMps),
                      style: theme.textTheme.titleSmall,
                    ),
                    Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
                  ],
                ),
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

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _startRide,
              icon: const Icon(Icons.directions_bike),
              label: const Text('Почати поїздку'),
            ),
          ),
        ),
      ),
    );
  }
}
