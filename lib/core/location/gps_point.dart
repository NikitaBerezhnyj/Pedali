class GpsPoint {
  const GpsPoint({
    required this.time,
    required this.lat,
    required this.lon,
    required this.accuracy,
    this.altitude,
    this.speed, // m/s, null - invalid
  });

  final DateTime time; // UTC
  final double lat;
  final double lon;
  final double accuracy; // m
  final double? altitude;
  final double? speed;
}
