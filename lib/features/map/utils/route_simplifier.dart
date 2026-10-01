import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

class RouteSimplifier {
  const RouteSimplifier();

  static const int minPointsToSimplify = 500;

  List<LatLng> simplify(List<LatLng> points, {double toleranceMeters = 5}) {
    if (points.length <= 2 || points.length < minPointsToSimplify) {
      return points;
    }

    final referenceLatitude = points.first.latitude * math.pi / 180;
    final cosLatitude = math.cos(referenceLatitude);

    final projected = points
        .map(
          (point) => _ProjectedPoint(
            x: point.longitude * 111320 * cosLatitude,
            y: point.latitude * 110540,
          ),
        )
        .toList();

    final simplifiedIndexes = <int>[];

    _simplify(
      projected,
      0,
      projected.length - 1,
      toleranceMeters * toleranceMeters,
      simplifiedIndexes,
    );

    simplifiedIndexes
      ..add(0)
      ..add(points.length - 1)
      ..sort();

    return simplifiedIndexes.map((index) => points[index]).toList();
  }

  void _simplify(
    List<_ProjectedPoint> points,
    int start,
    int end,
    double toleranceSquared,
    List<int> result,
  ) {
    if (end <= start + 1) return;

    var maxDistanceSquared = toleranceSquared;
    var maxIndex = -1;

    for (var i = start + 1; i < end; i++) {
      final distanceSquared = _distanceToSegmentSquared(
        points[i],
        points[start],
        points[end],
      );

      if (distanceSquared > maxDistanceSquared) {
        maxDistanceSquared = distanceSquared;
        maxIndex = i;
      }
    }

    if (maxIndex == -1) return;

    result.add(maxIndex);

    _simplify(points, start, maxIndex, toleranceSquared, result);

    _simplify(points, maxIndex, end, toleranceSquared, result);
  }

  double _distanceToSegmentSquared(
    _ProjectedPoint point,
    _ProjectedPoint start,
    _ProjectedPoint end,
  ) {
    final dx = end.x - start.x;
    final dy = end.y - start.y;

    if (dx == 0 && dy == 0) {
      return _distanceSquared(point, start);
    }

    final t =
        ((point.x - start.x) * dx + (point.y - start.y) * dy) /
        (dx * dx + dy * dy);

    final clampedT = t.clamp(0.0, 1.0);

    final projection = _ProjectedPoint(
      x: start.x + clampedT * dx,
      y: start.y + clampedT * dy,
    );

    return _distanceSquared(point, projection);
  }

  double _distanceSquared(_ProjectedPoint a, _ProjectedPoint b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;

    return dx * dx + dy * dy;
  }
}

class _ProjectedPoint {
  const _ProjectedPoint({required this.x, required this.y});

  final double x;
  final double y;
}
