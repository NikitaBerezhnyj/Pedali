import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/rides/providers/ride_repository_provider.dart';

final rideProvider = FutureProvider.family<Ride?, int>((ref, id) {
  return ref.read(rideRepositoryProvider).getRide(id);
});
