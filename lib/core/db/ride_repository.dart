import 'package:drift/drift.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/models/monthly_stat.dart';
import 'package:pedali/core/track/ride_stats.dart';
import 'package:pedali/core/track/track_sample.dart';

class RideSummary {
  const RideSummary({
    required this.id,
    required this.startedAt,
    required this.distanceMeters,
    required this.movingTimeMs,
    required this.elapsedTimeMs,
    required this.maxSpeedMps,
    required this.avgSpeedMps,
  });

  final int id;
  final DateTime startedAt;
  final double distanceMeters;
  final int movingTimeMs;
  final int elapsedTimeMs;
  final double maxSpeedMps;
  final double avgSpeedMps;
}

class RideRepository {
  RideRepository(this._db);

  final AppDatabase _db;

  Future<int> startRide(DateTime startedAt) async {
    return _db
        .into(_db.rides)
        .insert(
          RidesCompanion.insert(
            startedAt: startedAt.millisecondsSinceEpoch,
            status: RideStatus.active,
          ),
        );
  }

  Future<int> openSegment(int rideId, DateTime startedAt) {
    return _db
        .into(_db.rideSegments)
        .insert(
          RideSegmentsCompanion.insert(
            rideId: rideId,
            startedAt: startedAt.millisecondsSinceEpoch,
          ),
        );
  }

  Future<void> closeSegment(int segmentId, DateTime endedAt) {
    return (_db.update(
      _db.rideSegments,
    )..where((s) => s.id.equals(segmentId))).write(
      RideSegmentsCompanion(endedAt: Value(endedAt.millisecondsSinceEpoch)),
    );
  }

  Future<void> insertPoints(
    int rideId,
    int segmentId,
    List<TrackSample> samples,
  ) async {
    if (samples.isEmpty) return;
    await _db.batch((batch) {
      batch.insertAll(
        _db.trackPoints,
        samples
            .map(
              (s) => TrackPointsCompanion.insert(
                rideId: rideId,
                segmentId: segmentId,
                ts: s.time.millisecondsSinceEpoch,
                lat: s.lat,
                lon: s.lon,
                accuracy: s.accuracyMeters,
                speedMps: Value(s.speedMps),
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> finishRide(int rideId, DateTime endedAt, RideStats stats) {
    return (_db.update(_db.rides)..where((r) => r.id.equals(rideId))).write(
      RidesCompanion(
        status: const Value(RideStatus.finished),
        endedAt: Value(endedAt.millisecondsSinceEpoch),
        distanceMeters: Value(stats.distanceMeters),
        movingTimeMs: Value(stats.movingTime.inMilliseconds),
        maxSpeedMps: Value(stats.maxSpeedMps),
        avgSpeedMps: Value(stats.avgSpeedMps),
      ),
    );
  }

  Future<void> setElapsedTime(int rideId, Duration elapsed) {
    return (_db.update(_db.rides)..where((r) => r.id.equals(rideId))).write(
      RidesCompanion(elapsedTimeMs: Value(elapsed.inMilliseconds)),
    );
  }

  Future<void> deleteRide(int rideId) async {
    await _db.batch((batch) {
      batch.deleteWhere(_db.trackPoints, (t) => t.rideId.equals(rideId));
      batch.deleteWhere(_db.rideSegments, (s) => s.rideId.equals(rideId));
      batch.deleteWhere(_db.rides, (r) => r.id.equals(rideId));
    });
  }

  Future<Ride?> findActiveRide() {
    return (_db.select(
      _db.rides,
    )..where((r) => r.status.equalsValue(RideStatus.active))).getSingleOrNull();
  }

  Stream<List<Ride>> watchFinishedRides() {
    return (_db.select(_db.rides)
          ..where((r) => r.status.equalsValue(RideStatus.finished))
          ..orderBy([(r) => OrderingTerm.desc(r.startedAt)]))
        .watch();
  }

  Future<List<TrackPoint>> getTrackPoints(int rideId) {
    return (_db.select(_db.trackPoints)
          ..where((t) => t.rideId.equals(rideId))
          ..orderBy([(t) => OrderingTerm.asc(t.ts)]))
        .get();
  }

  Future<Ride?> getRide(int id) {
    return (_db.select(
      _db.rides,
    )..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  Future<Ride?> longestRide() {
    return (_db.select(_db.rides)
          ..where((r) => r.status.equalsValue(RideStatus.finished))
          ..orderBy([(r) => OrderingTerm.desc(r.distanceMeters)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Ride?> fastestRide({double minDistanceMeters = 5000}) {
    return (_db.select(_db.rides)
          ..where(
            (r) =>
                r.status.equalsValue(RideStatus.finished) &
                r.distanceMeters.isBiggerOrEqualValue(minDistanceMeters),
          )
          ..orderBy([(r) => OrderingTerm.desc(r.avgSpeedMps)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Ride?> longestRideByTime() {
    return (_db.select(_db.rides)
          ..where((r) => r.status.equalsValue(RideStatus.finished))
          ..orderBy([(r) => OrderingTerm.desc(r.movingTimeMs)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<MonthlyStat>> getMonthlyStats() async {
    final rows = await _db
        .customSelect(
          '''
    SELECT
      strftime('%Y-%m', datetime(started_at / 1000, 'unixepoch', 'localtime')) AS month,
      SUM(distance_meters) AS total_distance,
      COUNT(*) AS ride_count,
      SUM(moving_time_ms) AS total_moving_ms
    FROM rides
    WHERE status = 'finished'
    GROUP BY month
    ORDER BY month DESC
    ''',
          readsFrom: {_db.rides},
        )
        .get();

    return rows
        .map(
          (r) => MonthlyStat(
            monthKey: r.read<String>('month'),
            totalDistanceMeters: r.read<double>('total_distance'),
            rideCount: r.read<int>('ride_count'),
            totalMovingTimeMs: r.read<int>('total_moving_ms'),
          ),
        )
        .toList();
  }
}
