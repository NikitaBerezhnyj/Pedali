import 'package:flutter/material.dart';
import 'package:pedali/features/recording/providers/recorder_controller_provider.dart';
import 'package:pedali/features/recording/widgets/recording_map.dart';
import 'package:pedali/features/recording/widgets/recording_panel.dart';
import 'package:pedali/features/recording/widgets/round_icon_button.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/features/settings/providers/keep_screen_on_provider.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({super.key});

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  final _mapController = MapController();
  final _sheetController = DraggableScrollableController();
  bool _followMe = true;

  @override
  void initState() {
    super.initState();
    if (ref.read(keepScreenOnProvider)) {
      WakelockPlus.enable();
    }
  }

  @override
  void dispose() {
    _sheetController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  void _recenter(LatLng? position) {
    if (position == null) return;
    setState(() => _followMe = true);
    _mapController.move(position, _mapController.camera.zoom);
  }

  Future<void> _confirmStop(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Завершити поїздку?'),
        content: const Text('Запис зупиниться і поїздку буде збережено.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Скасувати'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Завершити'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final controller = ref.read(recorderControllerProvider.notifier);

    await controller.stop();
    if (!context.mounted) return;

    if (!controller.isSavable) {
      final keep = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Дуже коротка поїздка'),
          content: const Text('Зберегти її все одно?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Видалити'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Зберегти'),
            ),
          ],
        ),
      );

      if (keep == false) {
        await controller.discardLastRide();
      } else {
        controller.acknowledgeSaved();
      }
    } else {
      controller.acknowledgeSaved();
    }

    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(recorderControllerProvider);
    final c = ref.read(recorderControllerProvider.notifier);
    final units = ref.watch(unitsProvider);

    ref.listen(recorderControllerProvider, (previous, next) {
      if (_followMe && next.currentPosition != null) {
        _mapController.move(next.currentPosition!, _mapController.camera.zoom);
      }
    });

    final screenHeight = MediaQuery.of(context).size.height;
    const gapAboveSheet = 16.0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          RecordingMap(
            mapController: _mapController,
            initialPosition: s.currentPosition ?? const LatLng(50.45, 30.52),
            trackPoints: s.trackPoints,
            currentPosition: s.currentPosition,
            onPositionChanged: (position, hasGesture) {
              if (hasGesture && _followMe) {
                setState(() => _followMe = false);
              }
            },
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: RoundIconButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
            ),
          ),

          if (!_followMe)
            AnimatedBuilder(
              animation: _sheetController,
              builder: (context, child) {
                final sheetExtent = _sheetController.isAttached
                    ? _sheetController.size
                    : RecordingPanel.sheetInitial;

                return Positioned(
                  right: 12,
                  bottom: screenHeight * sheetExtent + gapAboveSheet,
                  child: child!,
                );
              },
              child: RoundIconButton(
                icon: Icons.my_location,
                onPressed: () => _recenter(s.currentPosition),
              ),
            ),

          RecordingPanel(
            sheetController: _sheetController,
            status: s.status,
            currentSpeed: s.currentSpeedMps,
            speedUnit: units == UnitSystem.imperial ? 'mph' : 'km/h',
            distance: units.formatDistance(s.distanceMeters),
            movingTime: s.movingTime,
            elapsedTime: s.elapsedTime,
            avgSpeed: units.formatSpeed(s.avgSpeedMps),
            maxSpeed: units.formatSpeed(s.maxSpeedMps),
            gpsAccuracy: s.gpsAccuracy,
            message: s.message,
            onPause: c.pause,
            onResume: c.resume,
            onStop: () => _confirmStop(context, ref),
          ),
        ],
      ),
    );
  }
}
