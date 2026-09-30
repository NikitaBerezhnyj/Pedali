import 'package:pedali/core/constants/app_constants.dart';
import 'geo_math.dart';
import '../../rides/domain/ride_stats.dart';
import '../../rides/domain/track_sample.dart';

enum PointOutcome { accepted, ignoredStationary, rejectedImplausible }

class RideAccumulator {
  RideAccumulator({
    this.minStepMeters = 3,
    this.movingSpeedThresholdMps = 1,
    this.speedWindowSize = 5,
    this.maxPlausibleSpeedMps = maxPlausibleSpeedMpsDefault,
    this.minSpeedSamplesForMax = 3,
  });

  final double minStepMeters;
  final double movingSpeedThresholdMps;
  final int speedWindowSize;
  final double maxPlausibleSpeedMps;
  final int minSpeedSamplesForMax;

  double _distanceMeters = 0;
  Duration _movingTime = Duration.zero;
  double _maxSpeedMps = 0;

  GPSTrackPoint? _last;
  final List<double> _recentSpeeds = [];

  int _spoofRejectedCount = 0;
  int get spoofRejectedPointCount => _spoofRejectedCount;

  void startNewSegment() {
    _last = null;
  }

  PointOutcome addPoint(GPSTrackPoint sample) {
    final last = _last;
    if (last == null) {
      _last = sample;
      return PointOutcome.accepted;
    }

    final dtSeconds = sample.time.difference(last.time).inMilliseconds / 1000.0;
    if (dtSeconds <= 0) {
      return PointOutcome.ignoredStationary;
    }

    final stepMeters = haversineMeters(
      last.lat,
      last.lon,
      sample.lat,
      sample.lon,
    );
    if (stepMeters < minStepMeters) {
      return PointOutcome.ignoredStationary;
    }

    final impliedSpeedMps = stepMeters / dtSeconds;

    if (impliedSpeedMps > maxPlausibleSpeedMps) {
      _spoofRejectedCount++;
      return PointOutcome.rejectedImplausible;
    }

    _distanceMeters += stepMeters;
    if (impliedSpeedMps >= movingSpeedThresholdMps) {
      _movingTime += Duration(milliseconds: (dtSeconds * 1000).round());
    }

    final speedForMax = sample.speedMps ?? impliedSpeedMps;

    _recentSpeeds.add(speedForMax);

    if (_recentSpeeds.length > speedWindowSize) {
      _recentSpeeds.removeAt(0);
    }

    if (_recentSpeeds.length >= minSpeedSamplesForMax) {
      final medianSpeed = _median(_recentSpeeds);
      if (medianSpeed > _maxSpeedMps) {
        _maxSpeedMps = medianSpeed;
      }
    }

    _last = sample;
    return PointOutcome.accepted;
  }

  void reset() {
    _distanceMeters = 0;
    _movingTime = Duration.zero;
    _maxSpeedMps = 0;
    _last = null;
    _recentSpeeds.clear();
    _spoofRejectedCount = 0;
  }

  RideStats get stats => RideStats(
    distanceMeters: _distanceMeters,
    movingTime: _movingTime,
    maxSpeedMps: _maxSpeedMps,
  );

  double _median(List<double> values) {
    final sorted = [...values]..sort();
    final mid = sorted.length ~/ 2;
    if (sorted.length.isOdd) return sorted[mid];
    return (sorted[mid - 1] + sorted[mid]) / 2;
  }
}
