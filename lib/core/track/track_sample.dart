class TrackSample {
  const TrackSample({
    required this.time,
    required this.lat,
    required this.lon,
    required this.accuracyMeters,
    this.speedMps, // null, якщо джерело (GPX, деякі пристрої) не дало швидкість
  });

  final DateTime time; // UTC
  final double lat;
  final double lon;
  final double accuracyMeters;
  final double? speedMps;
}
