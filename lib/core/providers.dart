import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/app_database.dart';
import 'db/ride_repository.dart';
import 'location/geolocator_location_source.dart';
import 'location/location_source.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final rideRepositoryProvider = Provider<RideRepository>((ref) {
  return RideRepository(ref.read(databaseProvider));
});

final locationSourceProvider = Provider<LocationSource>(
  (ref) => GeolocatorLocationSource(),
);

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});
