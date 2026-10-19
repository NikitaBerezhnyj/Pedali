import 'package:flutter/material.dart';
import 'package:pedali/features/map/domain/route_point.dart';

class SpeedColorScale {
  const SpeedColorScale._(this.minMps, this.maxMps);

  factory SpeedColorScale.fromSegments(List<List<RoutePoint>> segments) {
    final speeds = segments.expand((s) => s).map((p) => p.speedMps).toList()
      ..sort();
    if (speeds.isEmpty) return const SpeedColorScale._(0, 0);

    return SpeedColorScale._(
      _percentile(speeds, 0.05),
      _percentile(speeds, 0.95),
    );
  }

  static const palette = [
    Color(0xFF2563EB),
    Color(0xFF0891B2),
    Color(0xFF16A34A),
    Color(0xFFF59E0B),
    Color(0xFFEA580C),
  ];

  final double minMps;
  final double maxMps;

  Color colorAt(double speedMps) {
    if (maxMps <= minMps) return palette[palette.length ~/ 2];

    final t = ((speedMps - minMps) / (maxMps - minMps)).clamp(0.0, 1.0);
    final scaled = t * (palette.length - 1);
    final i = scaled.floor().clamp(0, palette.length - 2);

    return Color.lerp(palette[i], palette[i + 1], scaled - i)!;
  }

  static double _percentile(List<double> sorted, double p) =>
      sorted[((sorted.length - 1) * p).round()];
}
