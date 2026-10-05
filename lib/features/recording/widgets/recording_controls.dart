import 'package:flutter/material.dart';
import 'package:pedali/core/widgets/app_circle_button.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';

class RecordingControls extends StatelessWidget {
  const RecordingControls({
    super.key,
    required this.status,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  final RecorderStatus status;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final stop = AppCircleButton(
      icon: Icons.stop,
      variant: AppCircleButtonVariant.destructive,
      tooltip: 'Завершити',
      onPressed: onStop,
    );

    switch (status) {
      case RecorderStatus.recording:
        return Row(
          children: [
            AppCircleButton(
              icon: Icons.pause,
              variant: AppCircleButtonVariant.tonal,
              tooltip: 'Пауза',
              onPressed: onPause,
            ),
            const SizedBox(width: 8),
            stop,
          ],
        );

      case RecorderStatus.paused:
        return Row(
          children: [
            AppCircleButton(
              icon: Icons.play_arrow,
              variant: AppCircleButtonVariant.tonal,
              tooltip: 'Продовжити',
              onPressed: onResume,
            ),
            const SizedBox(width: 8),
            stop,
          ],
        );

      case RecorderStatus.autoPaused:
        return stop;

      default:
        return const SizedBox.shrink();
    }
  }
}
