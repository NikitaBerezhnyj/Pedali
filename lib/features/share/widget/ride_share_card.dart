import 'package:flutter/material.dart';
import 'package:pedali/app/app_theme.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/widget/route_painter.dart';
import 'package:pedali/l10n/app_localizations.dart';

class RideShareCard extends StatelessWidget {
  const RideShareCard({super.key, required this.data});

  static const double size = 360;

  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final bg = AppTheme.seed.shade800;
    final soft = AppTheme.seed.shade100;
    final t = AppLocalizations.of(context)!;

    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        width: size,
        height: size,
        child: ColoredBox(
          color: bg,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.directions_bike, size: 17, color: bg),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Pedali',
                      style: tt.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.date,
                      style: tt.bodySmall?.copyWith(color: soft, fontSize: 12),
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
                          color: Colors.white,
                          startColor: bg,
                          endColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  data.distance,
                  style: tt.displaySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Stat(
                      label: t.shareMovingTimeLabel,
                      value: data.movingTime,
                    ),
                    _Stat(label: t.shareAvgSpeedLabel, value: data.avgSpeed),
                    _Stat(label: t.shareMaxSpeedLabel, value: data.maxSpeed),
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
    final tt = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: tt.labelSmall?.copyWith(
              color: AppTheme.seed.shade100,
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
            style: tt.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
