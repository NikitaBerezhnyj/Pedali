import 'package:flutter_test/flutter_test.dart';
import 'package:pedali/features/recording/domain/ride_accumulator.dart';
import 'package:pedali/features/rides/domain/gps_track_point.dart';

void main() {
  final t0 = DateTime.utc(2026, 9, 26, 10, 0, 0);
  DateTime at(int seconds) => t0.add(Duration(seconds: seconds));

  GPSTrackPoint p(int seconds, double lat, double lon, {double? speedMps}) =>
      GPSTrackPoint(
        time: at(seconds),
        lat: lat,
        lon: lon,
        accuracyMeters: 5,
        speedMps: speedMps,
      );

  test('ignores GPS drift while stationary', () {
    final acc = RideAccumulator()..startNewSegment();

    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(5, 50.45001, 30.52000));
    acc.addPoint(p(10, 50.44999, 30.52001));
    acc.addPoint(p(15, 50.45000, 30.51999));

    expect(acc.stats.distanceMeters, closeTo(0, 1));
    expect(acc.stats.movingTime, Duration.zero);
  });

  test('adds distance and moving time for actual movement', () {
    final acc = RideAccumulator()..startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));

    acc.addPoint(p(10, 50.45050, 30.52000));

    expect(acc.stats.distanceMeters, greaterThan(40));
    expect(acc.stats.movingTime, Duration(seconds: 10));
  });

  test('does not count the pause between segments as movement', () {
    final acc = RideAccumulator();

    acc.startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000));

    final distanceBeforePause = acc.stats.distanceMeters;

    acc.startNewSegment();
    acc.addPoint(p(300, 51.00000, 31.00000));
    acc.addPoint(p(310, 51.00050, 31.00000));

    final totalDistance = acc.stats.distanceMeters;
    expect(totalDistance - distanceBeforePause, lessThan(100));
  });

  test('reset clears all stats before a new ride', () {
    final acc = RideAccumulator();
    acc.startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000));
    expect(acc.stats.distanceMeters, greaterThan(0));

    acc.reset();
    expect(acc.stats.distanceMeters, 0);
    expect(acc.stats.movingTime, Duration.zero);
    expect(acc.stats.maxSpeedMps, 0);

    acc.startNewSegment();
    acc.addPoint(p(100, 60.0000, 30.0000));
    acc.addPoint(p(110, 60.0005, 30.0000));
    expect(acc.stats.distanceMeters, lessThan(100));
  });

  test('calculates max speed after collecting 3 valid samples', () {
    final acc = RideAccumulator()..startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000));
    acc.addPoint(p(20, 50.45100, 30.52000));
    acc.addPoint(p(30, 50.45150, 30.52000));

    expect(acc.stats.maxSpeedMps, greaterThan(0));
  });

  test(
    'keeps max speed at 0 when fewer than 3 valid samples are available',
    () {
      final acc = RideAccumulator()..startNewSegment();
      acc.addPoint(p(0, 50.45000, 30.52000));
      acc.addPoint(p(10, 50.45050, 30.52000));

      expect(acc.stats.maxSpeedMps, 0);
    },
  );

  test(
    'calculates speed from position and time when sample speed is unavailable',
    () {
      final acc = RideAccumulator()..startNewSegment();
      acc.addPoint(p(0, 50.45000, 30.52000));
      acc.addPoint(p(10, 50.45050, 30.52000));
      acc.addPoint(p(20, 50.45100, 30.52000));
      acc.addPoint(p(30, 50.45150, 30.52000));
      acc.addPoint(p(40, 50.45200, 30.52000));
      acc.addPoint(p(50, 50.45250, 30.52000));

      expect(acc.stats.maxSpeedMps, greaterThan(0));
    },
  );

  test(
    'calculates average speed using moving time instead of elapsed time',
    () {
      final acc = RideAccumulator();
      acc.startNewSegment();
      acc.addPoint(p(0, 50.45000, 30.52000));
      acc.addPoint(p(10, 50.45050, 30.52000));

      acc.startNewSegment();
      acc.addPoint(p(300, 50.45050, 30.52000));
      acc.addPoint(p(310, 50.45100, 30.52000));

      final stats = acc.stats;

      expect(stats.movingTime, Duration(seconds: 20));
      expect(stats.avgSpeedMps, closeTo(stats.distanceMeters / 20, 0.01));
    },
  );

  test('ignores implausible GPS jumps without corrupting ride stats', () {
    final acc = RideAccumulator()..startNewSegment();

    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000));

    final distanceBeforeJam = acc.stats.distanceMeters;

    acc.addPoint(p(30, 51.00000, 31.00000));

    expect(acc.stats.distanceMeters, closeTo(distanceBeforeJam, 1));
    expect(acc.stats.maxSpeedMps * 3.6, lessThan(150));

    acc.addPoint(p(35, 50.45055, 30.52001));

    expect(acc.stats.distanceMeters, greaterThan(distanceBeforeJam));
    expect(acc.stats.avgSpeedMps * 3.6, lessThan(50));
  });
}
