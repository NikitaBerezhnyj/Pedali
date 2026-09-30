import 'package:drift/drift.dart';

enum RideStatus { active, finished }

class Rides extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get startedAt => integer()(); // UTC, мс
  IntColumn get endedAt => integer().nullable()();
  TextColumn get status => textEnum<RideStatus>()(); // active | finished
  RealColumn get distanceMeters => real().withDefault(const Constant(0))();
  IntColumn get movingTimeMs => integer().withDefault(const Constant(0))();
  IntColumn get elapsedTimeMs => integer().withDefault(const Constant(0))();
  RealColumn get maxSpeedMps => real().withDefault(const Constant(0))();
  RealColumn get avgSpeedMps => real().withDefault(const Constant(0))();
}

class RideSegments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rideId => integer().references(Rides, #id)();
  IntColumn get startedAt => integer()();
  IntColumn get endedAt => integer().nullable()();
}

class TrackPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rideId => integer().references(Rides, #id)();
  IntColumn get segmentId => integer().references(RideSegments, #id)();
  IntColumn get ts => integer()(); // UTC, ms
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get altitude => real().nullable()();
  RealColumn get accuracy => real()();
  RealColumn get speedMps => real().nullable()();
}
