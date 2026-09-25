import 'track_sample.dart';

class LocationFilter {
  const LocationFilter({
    this.maxAccuracyMeters = 20,
    this.maxSpeedMps = 30, // 108 km/h
  });

  final double maxAccuracyMeters;
  final double maxSpeedMps;

  bool accepts(TrackSample sample) {
    if (sample.accuracyMeters > maxAccuracyMeters) return false;
    final speed = sample.speedMps;
    if (speed != null && (speed < 0 || speed > maxSpeedMps)) return false;
    return true;
  }
}
