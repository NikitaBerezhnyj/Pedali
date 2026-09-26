import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/models/monthly_stat.dart';
import 'package:pedali/core/providers/ride_repository_provider.dart';

final monthlyStatsProvider = FutureProvider<List<MonthlyStat>>((ref) {
  return ref.read(rideRepositoryProvider).getMonthlyStats();
});
