import 'package:flutter/material.dart';
import 'package:pedali/app/app_theme.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/widget/route_painter.dart';

class RideShareCard extends StatelessWidget {
  const RideShareCard({super.key, required this.data});

  static const double size = 360;

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        width: size,
        height: size,
        child: ColoredBox(
          color: cs.surface,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.seed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.directions_bike,
                        size: 17,
                        color: cs.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'PEDALI',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.seed,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.date,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox.expand(
                      child: CustomPaint(
                        painter: RoutePainter(
                          segments: data.segments,
                          color: AppTheme.seed,
                          startColor: cs.onSurface,
                          endColor: AppTheme.seed,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  data.distance,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: cs.onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Stat(label: 'ЧАС У РУСІ', value: data.movingTime),
                    _Stat(label: 'СЕРЕДНЯ', value: data.avgSpeed),
                    _Stat(label: 'МАКС.', value: data.maxSpeed),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: cs.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              color: cs.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
