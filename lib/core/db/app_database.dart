import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:pedali/core/db/schema.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [Rides, RideSegments, TrackPoints])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'pedali'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Migrations here
    },
  );
}
