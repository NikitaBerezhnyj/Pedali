import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/ride_repository.dart';
import 'package:pedali/core/providers/database_provider.dart';

final rideRepositoryProvider = Provider<RideRepository>((ref) {
  return RideRepository(ref.read(databaseProvider));
});
