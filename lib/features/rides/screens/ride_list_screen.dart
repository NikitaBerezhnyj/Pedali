import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/core/widgets/app_list_card.dart';
import 'package:pedali/core/widgets/async_value_view.dart';
import 'package:pedali/core/widgets/empty_state.dart';
import 'package:pedali/features/achievements/screens/achievements_screen.dart';
import 'package:pedali/features/recording/providers/recorder_controller_provider.dart';
import 'package:pedali/features/recording/screens/recording_screen.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';
import 'package:pedali/features/rides/screens/ride_detail_screen.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/settings/screens/settings_screen.dart';
import 'package:pedali/features/stats/screens/stats_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';
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
    if (ref.read(recorderControllerProvider).isActive) return;

    final controller = ref.read(recorderControllerProvider.notifier);

    final stale = await controller.checkForActiveRide();

    if (stale == null || !mounted) return;

    final info = await controller.getStaleRideInfo(stale);

    if (!mounted) return;

    final t = AppLocalizations.of(context)!;
    final units = ref.read(unitsProvider);

    final agoText = _formatAgo(
      DateTime.now().toUtc().difference(info.startedAt),
      t,
    );

    final resume = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(t.unfinishedRideTitle),
        content: Text(
          t.unfinishedRideMessage(
            agoText,
            units.formatDistance(info.distanceMeters, t),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.delete),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.continueLabel),
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

  String _formatAgo(Duration duration, AppLocalizations t) {
    if (duration.inDays > 0) {
      return t.startedDaysAgo(duration.inDays);
    }

    if (duration.inHours > 0) {
      return t.startedHoursAgo(duration.inHours);
    }

    if (duration.inMinutes > 0) {
      return t.startedMinutesAgo(duration.inMinutes);
    }

    return t.startedJustNow;
  }

  Future<void> _openStats() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const StatsScreen()),
  );

  Future<void> _openSettings() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const SettingsScreen()),
  );

  Future<void> _openAchievements() => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AchievementsScreen()),
  );

  Future<void> _openRecording() async {
    final controller = ref.read(recorderControllerProvider.notifier);

    if (!ref.read(recorderControllerProvider).isActive) {
      await controller.start();
      if (!mounted || !ref.read(recorderControllerProvider).isActive) return;
    }

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
    final t = AppLocalizations.of(context)!;
    final units = ref.watch(unitsProvider);
    final recording = ref.watch(
      recorderControllerProvider.select((s) => s.isActive),
    );

    return Scaffold(
      appBar: AppHeader(
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: t.achievementsTitle,
            onPressed: _openAchievements,
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: t.statistics,
            onPressed: _openStats,
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: t.settings,
            onPressed: _openSettings,
          ),
        ],
      ),
      body: AsyncValueView(
        value: ref.watch(finishedRidesProvider),
        errorTitle: t.ridesLoadError,
        retryDescription: t.tryAgainLater,
        retryLabel: t.tryAgain,
        onRetry: () => ref.invalidate(finishedRidesProvider),
        data: (rides) {
          if (rides.isEmpty) {
            return Center(
              child: EmptyState(
                icon: Icons.directions_bike,
                title: t.rideListEmptyTitle,
                description: t.rideListEmptyDescription,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: rides.length,
            itemBuilder: (context, i) {
              final ride = rides[i];

              return AppListCard(
                title: units.formatDistance(ride.distanceMeters, t),
                subtitle:
                    '${formatStartedAt(ride.startedAt, locale: t.localeName)} • '
                    '${formatDuration(Duration(milliseconds: ride.movingTimeMs), t)}',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      units.formatSpeed(ride.avgSpeedMps, t),
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
              onPressed: _openRecording,
              icon: const Icon(Icons.directions_bike),
              label: Text(recording ? t.continueRide : t.startRide),
            ),
          ),
        ),
      ),
    );
  }
}
