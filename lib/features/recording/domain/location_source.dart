import 'package:pedali/features/rides/domain/track_sample.dart';

abstract interface class LocationSource {
  Future<bool> ensurePermissions();
  Stream<GPSTrackPoint> positions();
}
