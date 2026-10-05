import 'package:flutter/material.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';
import 'package:pedali/features/recording/widgets/gps_status.dart';
import 'package:pedali/features/recording/widgets/mini_stat.dart';
import 'package:pedali/features/recording/widgets/recording_controls.dart';
import 'package:pedali/theme/app_tokens.dart';

class RecordingPanel extends StatelessWidget {
  const RecordingPanel({
    super.key,
    required this.sheetController,
    required this.state,
    required this.units,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  final DraggableScrollableController sheetController;
  final RecorderState state;
  final UnitSystem units;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  static const sheetMin = 0.10;
  static const sheetInitial = 0.30;
  static const sheetMax = 0.30;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final speed = state.currentSpeedMps;
    final message = state.message;

    return DraggableScrollableSheet(
      controller: sheetController,
      initialChildSize: sheetInitial,
      minChildSize: sheetMin,
      maxChildSize: sheetMax,
      snap: true,
      snapSizes: const [sheetMin, sheetInitial],
      builder: (context, scrollController) {
        return Material(
          color: cs.surface,
          elevation: 8,
          shadowColor: cs.shadow,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xlValue),
            ),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(
              20,
              AppSpacing.sm,
              20,
              MediaQuery.of(context).padding.bottom + AppSpacing.md,
            ),
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    speed == null ? '--' : units.formatSpeed(speed),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  RecordingControls(
                    status: state.status,
                    onPause: onPause,
                    onResume: onResume,
                    onStop: onStop,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    units.formatDistance(state.distanceMeters),
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    'дистанція',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MiniStat(
                    label: 'Час у русі',
                    value: formatDuration(state.movingTime),
                  ),
                  MiniStat(
                    label: 'Заг. час',
                    value: formatDuration(state.elapsedTime),
                  ),
                  MiniStat(
                    label: 'Сер. швидк.',
                    value: units.formatSpeed(state.avgSpeedMps),
                  ),
                  MiniStat(
                    label: 'Макс.',
                    value: units.formatSpeed(state.maxSpeedMps),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GpsStatus(
                isAutoPaused: state.status == RecorderStatus.autoPaused,
                accuracy: state.gpsAccuracy,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.error),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
