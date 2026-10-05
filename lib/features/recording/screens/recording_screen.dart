import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/widgets/app_circle_button.dart';
import 'package:pedali/core/widgets/show_confirm_dialog.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';
import 'package:pedali/features/recording/providers/recorder_controller_provider.dart';
import 'package:pedali/features/recording/widgets/recording_map.dart';
import 'package:pedali/features/recording/widgets/recording_panel.dart';
import 'package:pedali/features/settings/providers/keep_screen_on_provider.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

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

  bool _isActive(RecorderStatus status) =>
      status == RecorderStatus.recording ||
      status == RecorderStatus.paused ||
      status == RecorderStatus.autoPaused;

  void _recenter(LatLng? position) {
    if (position == null) return;

    setState(() => _followMe = true);
    _mapController.move(position, _mapController.camera.zoom);
  }

  Future<void> _confirmStop() async {
    final t = AppLocalizations.of(context)!;

    final confirmed = await showConfirmDialog(
      context,
      title: t.finishRideTitle,
      message: t.finishRideMessage,
      confirmLabel: t.finishRideConfirm,
      cancelLabel: t.cancel,
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    final controller = ref.read(recorderControllerProvider.notifier);

    await controller.stop();

    if (!mounted) return;

    if (controller.isSavable) {
      controller.acknowledgeSaved();
    } else {
      final keep = await showConfirmDialog(
        context,
        title: t.shortRideTitle,
        message: t.shortRideMessage,
        confirmLabel: t.saveRide,
        cancelLabel: t.discardRide,
        barrierDismissible: false,
      );

      if (keep) {
        controller.acknowledgeSaved();
      } else {
        await controller.discardLastRide();
      }
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final s = ref.watch(recorderControllerProvider);
    final c = ref.read(recorderControllerProvider.notifier);
    final units = ref.watch(unitsProvider);

    ref.listen(recorderControllerProvider, (previous, next) {
      if (_followMe && next.currentPosition != null) {
        _mapController.move(next.currentPosition!, _mapController.camera.zoom);
      }
    });

    final screenHeight = MediaQuery.of(context).size.height;
    const gapAboveSheet = AppSpacing.md;

    return PopScope(
      canPop: !_isActive(s.status),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _confirmStop();
        }
      },
      child: Scaffold(
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
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: 12,
              child: AppCircleButton(
                icon: Icons.arrow_back,
                tooltip: t.back,
                onPressed: () => Navigator.maybePop(context),
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
                child: AppCircleButton(
                  icon: Icons.my_location,
                  tooltip: t.myLocation,
                  onPressed: () => _recenter(s.currentPosition),
                ),
              ),
            RecordingPanel(
              sheetController: _sheetController,
              state: s,
              units: units,
              onPause: c.pause,
              onResume: c.resume,
              onStop: _confirmStop,
            ),
          ],
        ),
      ),
    );
  }
}
