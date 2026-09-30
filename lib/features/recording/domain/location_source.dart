import 'package:pedali/features/rides/domain/gps_track_oint.dart';

abstract interface class LocationSource {
  Future<bool> ensurePermissions();
  Stream<GPSTrackPoint> positions();
}
