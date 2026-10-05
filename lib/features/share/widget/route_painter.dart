import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/features/map/widgets/map_dot.dart';

class RoutePainter extends CustomPainter {
  RoutePainter({
    required this.segments,
    required this.color,
    required this.startColor,
    required this.endColor,
    this.padding = 16,
  });

  final List<List<LatLng>> segments;
  final Color color;
  final Color startColor;
  final Color endColor;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final all = segments.expand((s) => s).toList();
    if (all.length < 2) return;

    var minLat = all.first.latitude;
    var maxLat = minLat;
    var minLon = all.first.longitude;
    var maxLon = minLon;

    for (final p in all) {
      minLat = math.min(minLat, p.latitude);
      maxLat = math.max(maxLat, p.latitude);
      minLon = math.min(minLon, p.longitude);
      maxLon = math.max(maxLon, p.longitude);
    }

    final k = math.cos(((minLat + maxLat) / 2) * math.pi / 180);
    final w = math.max((maxLon - minLon) * k, 1e-9);
    final h = math.max(maxLat - minLat, 1e-9);

    final area = Rect.fromLTWH(
      padding,
      padding,
      size.width - padding * 2,
      size.height - padding * 2,
    );

    final scale = math.min(area.width / w, area.height / h);
    final dx = area.left + (area.width - w * scale) / 2;
    final dy = area.top + (area.height - h * scale) / 2;

    Offset project(LatLng p) => Offset(
      dx + (p.longitude - minLon) * k * scale,
      dy + (maxLat - p.latitude) * scale,
    );

    final path = ui.Path();

    for (final segment in segments) {
      if (segment.length < 2) continue;

      final first = project(segment.first);
      path.moveTo(first.dx, first.dy);

      for (final p in segment.skip(1)) {
        final o = project(p);
        path.lineTo(o.dx, o.dy);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = color,
    );

    void dot(Offset o, Color c) {
      canvas.drawCircle(o, 8, Paint()..color = MapDot.borderColor);
      canvas.drawCircle(o, 5.5, Paint()..color = c);
    }

    dot(project(segments.first.first), startColor);
    dot(project(segments.last.last), endColor);
  }

  @override
  bool shouldRepaint(RoutePainter old) =>
      old.segments != segments ||
      old.color != color ||
      old.startColor != startColor ||
      old.endColor != endColor ||
      old.padding != padding;
}
