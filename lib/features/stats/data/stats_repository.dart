import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/features/stats/domain/monthly_stat.dart';

class StatsRepository {
  StatsRepository(this._db);

  final AppDatabase _db;

  Future<List<MonthlyStat>> getMonthlyStats() async {
    final rows = await _db
        .customSelect(
          '''
            SELECT
              strftime('%Y-%m', datetime(started_at / 1000, 'unixepoch', 'localtime')) AS month,
              SUM(distance_meters) AS total_distance,
              COUNT(*) AS ride_count,
              SUM(moving_time_ms) AS total_moving_ms
            FROM rides
            WHERE status = 'finished'
            GROUP BY month
            ORDER BY month DESC
          ''',
          readsFrom: {_db.rides},
        )
        .get();

    return rows
        .map(
          (r) => MonthlyStat(
            monthKey: r.read<String>('month'),
            totalDistanceMeters: r.read<double>('total_distance'),
            rideCount: r.read<int>('ride_count'),
            totalMovingTimeMs: r.read<int>('total_moving_ms'),
          ),
        )
        .toList();
  }
}
