import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/rides/providers/ride_repository_provider.dart';

final finishedRidesProvider = StreamProvider<List<Ride>>((ref) {
  return ref.read(rideRepositoryProvider).watchFinishedRides();
});
