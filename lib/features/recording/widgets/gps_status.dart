import 'package:flutter/material.dart';

class GpsStatus extends StatelessWidget {
  const GpsStatus({
    super.key,
    required this.isAutoPaused,
    required this.accuracy,
  });

  final bool isAutoPaused;
  final double? accuracy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isAutoPaused) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.gps_off, color: colorScheme.onErrorContainer, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'GPS нестабільний — запис призупинено',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      accuracy == null
          ? 'GPS: пошук сигналу'
          : 'GPS: ±${accuracy!.toStringAsFixed(0)} м',
      style: theme.textTheme.bodySmall?.copyWith(
        color: (accuracy ?? 999) <= 20 ? Colors.green : Colors.orange,
      ),
    );
  }
}
