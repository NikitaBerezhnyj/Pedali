import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/recording/domain/geo_math.dart';

List<double> smoothedSpeeds(List<TrackPoint> points, {int window = 11}) {
  if (points.length < 2) return List.filled(points.length, 0);

  final raw = List.generate(points.length, (i) => _rawSpeed(points, i));
  final half = window ~/ 2;

  return List.generate(points.length, (i) {
    final from = (i - half).clamp(0, points.length - 1);
    final to = (i + half).clamp(0, points.length - 1);
    final slice = raw.sublist(from, to + 1);
    return slice.reduce((a, b) => a + b) / slice.length;
  });
}

double _rawSpeed(List<TrackPoint> points, int i) {
  final reported = points[i].speedMps;
  if (reported != null) return reported;

  final a = points[i > 0 ? i - 1 : i];
  final b = points[i > 0 ? i : i + 1];
  final seconds = (b.ts - a.ts) / 1000;
  if (seconds <= 0) return 0;

  return haversineMeters(a.lat, a.lon, b.lat, b.lon) / seconds;
}
