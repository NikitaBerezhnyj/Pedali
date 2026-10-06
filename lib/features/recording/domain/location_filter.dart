import 'package:pedali/core/constants/app_constants.dart';
import 'package:pedali/features/rides/domain/gps_track_point.dart';

class LocationFilter {
  const LocationFilter({
    this.maxAccuracyMeters = 20,
    this.maxSpeedMps = maxPlausibleSpeedMpsDefault,
  });

  final double maxAccuracyMeters;
  final double maxSpeedMps;

  bool accepts(GPSTrackPoint sample) {
    if (sample.accuracyMeters > maxAccuracyMeters) return false;

    final speed = sample.speedMps;
    if (speed != null && (speed < 0 || speed > maxSpeedMps)) return false;

    return true;
  }
}
