class GPSTrackPoint {
  const GPSTrackPoint({
    required this.time,
    required this.lat,
    required this.lon,
    required this.accuracyMeters,
    this.altitudeMeters,
    this.speedMps,
  });

  final DateTime time;
  final double lat;
  final double lon;
  final double accuracyMeters;
  final double? altitudeMeters;
  final double? speedMps;
}
