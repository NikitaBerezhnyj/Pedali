import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/rides/domain/ride_records.dart';
import 'package:pedali/features/rides/providers/finished_rides_provider.dart';

final recordsProvider = Provider<RideRecords>((ref) {
  final rides = ref.watch(finishedRidesProvider).value ?? [];

  return RideRecords.fromRides(rides);
});
