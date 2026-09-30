import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/stats/data/stats_repository.dart';
import 'package:pedali/core/providers/database_provider.dart';

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepository(ref.read(databaseProvider));
});
