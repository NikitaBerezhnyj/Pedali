import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/settings/settings_screen.dart';

import '../../core/db/app_database.dart';
import '../../core/format.dart';
import '../../core/providers.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_header.dart';
import '../recording/recorder_controller.dart';
import '../recording/recording_screen.dart';

final finishedRidesProvider = StreamProvider<List<Ride>>((ref) {
  return ref.read(rideRepositoryProvider).watchFinishedRides();
});

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

    final resume = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Незавершена поїздка'),
        content: const Text(
          'Схоже, застосунок закрився під час запису. Видалити цей запис?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Видалити'),
          ),
        ],
      ),
    );
    if (resume == false) {
      await controller.discardStaleRide(stale);
      ref.invalidate(finishedRidesProvider);
    }
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
        data: (rides) => rides.isEmpty
            ? Center(
                child: Text(
                  'Поки що немає поїздок',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: rides.length,
                itemBuilder: (context, i) {
                  final r = rides[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(Icons.directions_bike),
                      title: Text(formatDistance(r.distanceMeters)),
                      subtitle: Text(
                        '${formatDuration(Duration(milliseconds: r.movingTimeMs))} • '
                        '${formatSpeed(r.avgSpeedMps)}',
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: PrimaryButton(label: 'Почати поїздку', onPressed: _startRide),
      ),
    );
  }
}
