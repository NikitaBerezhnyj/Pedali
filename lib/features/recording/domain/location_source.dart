import 'package:pedali/features/rides/domain/gps_track_point.dart';

abstract interface class LocationSource {
  Future<bool> ensurePermissions();
  Stream<GPSTrackPoint> positions({required String notificationText});
}
