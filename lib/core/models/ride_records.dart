import 'package:pedali/core/db/app_database.dart';

class RideRecords {
  const RideRecords({this.longest, this.fastest, this.longestByTime});

  final Ride? longest;
  final Ride? fastest;
  final Ride? longestByTime;
}
