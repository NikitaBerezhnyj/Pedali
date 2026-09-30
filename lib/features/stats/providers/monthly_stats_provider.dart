import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/stats/domain/monthly_stat.dart';
import 'package:pedali/features/stats/providers/stats_repository_provider.dart';

final monthlyStatsProvider = FutureProvider<List<MonthlyStat>>((ref) {
  return ref.read(statsRepositoryProvider).getMonthlyStats();
});
