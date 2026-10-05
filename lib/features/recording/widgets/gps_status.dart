import 'package:flutter/material.dart';
import 'package:pedali/theme/app_colors.dart';
import 'package:pedali/theme/app_tokens.dart';

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
    final cs = theme.colorScheme;

    if (isAutoPaused) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.errorContainer,
          borderRadius: AppRadius.md,
        ),
        child: Row(
          children: [
            Icon(Icons.gps_off, color: cs.onErrorContainer, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'GPS нестабільний — запис призупинено',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final colors = context.appColors;
    final good = (accuracy ?? 999) <= 20;

    return Text(
      accuracy == null
          ? 'GPS: пошук сигналу'
          : 'GPS: ±${accuracy!.toStringAsFixed(0)} м',
      style: theme.textTheme.bodySmall?.copyWith(
        color: good ? colors.success : colors.warning,
      ),
    );
  }
}
