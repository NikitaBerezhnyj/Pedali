import 'package:flutter/material.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';
import 'circle_action_button.dart';

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
    final errorColor = Theme.of(context).colorScheme.error;

    switch (status) {
      case RecorderStatus.recording:
        return Row(
          children: [
            CircleActionButton(icon: Icons.pause, onPressed: onPause),
            const SizedBox(width: 8),
            CircleActionButton(
              icon: Icons.stop,
              color: errorColor,
              onPressed: onStop,
            ),
          ],
        );

      case RecorderStatus.paused:
        return Row(
          children: [
            CircleActionButton(icon: Icons.play_arrow, onPressed: onResume),
            const SizedBox(width: 8),
            CircleActionButton(
              icon: Icons.stop,
              color: errorColor,
              onPressed: onStop,
            ),
          ],
        );

      case RecorderStatus.autoPaused:
        return CircleActionButton(
          icon: Icons.stop,
          color: errorColor,
          onPressed: onStop,
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
