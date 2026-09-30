import 'package:flutter/material.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';
import 'gps_status.dart';
import 'mini_stat.dart';
import 'recording_controls.dart';

class RecordingPanel extends StatelessWidget {
  const RecordingPanel({
    super.key,
    required this.sheetController,
    required this.status,
    required this.currentSpeed,
    required this.speedUnit,
    required this.distance,
    required this.movingTime,
    required this.elapsedTime,
    required this.avgSpeed,
    required this.maxSpeed,
    required this.gpsAccuracy,
    required this.message,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  final DraggableScrollableController sheetController;
  final RecorderStatus status;
  final double? currentSpeed;
  final String speedUnit;
  final String distance;
  final Duration movingTime;
  final Duration elapsedTime;
  final String avgSpeed;
  final String maxSpeed;
  final double? gpsAccuracy;
  final String? message;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  static const sheetMin = 0.10;
  static const sheetInitial = 0.30;
  static const sheetMax = 0.30;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      controller: sheetController,
      initialChildSize: sheetInitial,
      minChildSize: sheetMin,
      maxChildSize: sheetMax,
      snap: true,
      snapSizes: const [sheetMin, sheetInitial],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    currentSpeed == null
                        ? '--'
                        : currentSpeed!.toStringAsFixed(1),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(speedUnit, style: theme.textTheme.bodySmall),
                  const Spacer(),
                  RecordingControls(
                    status: status,
                    onPause: onPause,
                    onResume: onResume,
                    onStop: onStop,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    distance,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('дистанція', style: theme.textTheme.bodySmall),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MiniStat(
                    label: 'Час у русі',
                    value: formatDuration(movingTime),
                  ),
                  MiniStat(
                    label: 'Заг. час',
                    value: formatDuration(elapsedTime),
                  ),
                  MiniStat(label: 'Сер. швидк.', value: avgSpeed),
                  MiniStat(label: 'Макс.', value: maxSpeed),
                ],
              ),

              const SizedBox(height: 12),

              GpsStatus(
                isAutoPaused: status == RecorderStatus.autoPaused,
                accuracy: gpsAccuracy,
              ),

              if (message != null) ...[
                const SizedBox(height: 8),
                Text(message!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        );
      },
    );
  }
}
