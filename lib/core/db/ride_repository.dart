import 'package:drift/drift.dart';

import '../track/ride_stats.dart';
import '../track/track_sample.dart';
import 'app_database.dart';

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
        elapsedTimeMs: Value(endedAt.difference(_dummyStart).inMilliseconds),
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

  static final _dummyStart = DateTime.fromMillisecondsSinceEpoch(0);
}
