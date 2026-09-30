import 'gps_point.dart';

abstract interface class LocationSource {
  Future<bool> ensurePermissions();
  Stream<GpsPoint> positions();
}
