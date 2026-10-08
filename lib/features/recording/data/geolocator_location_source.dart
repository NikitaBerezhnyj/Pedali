import 'package:geolocator/geolocator.dart';
import 'package:pedali/features/recording/domain/location_source.dart';
import 'package:pedali/features/rides/domain/gps_track_point.dart';
import 'package:permission_handler/permission_handler.dart';

class GeolocatorLocationSource implements LocationSource {
  @override
  Future<bool> ensurePermissions() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return false;
    }

    await Permission.notification.request();
    return true;
  }

  @override
  Stream<GPSTrackPoint> positions({required String notificationText}) {
    final settings = AndroidSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 3,
      intervalDuration: const Duration(seconds: 1),
      foregroundNotificationConfig: ForegroundNotificationConfig(
        notificationTitle: 'Pedali',
        notificationText: notificationText,
        enableWakeLock: true,
        setOngoing: true,
        notificationIcon: const AndroidResource(name: 'ic_notification'),
      ),
    );
    return Geolocator.getPositionStream(
      locationSettings: settings,
    ).map(_toPoint);
  }

  GPSTrackPoint _toPoint(Position p) => GPSTrackPoint(
    time: p.timestamp.toUtc(),
    lat: p.latitude,
    lon: p.longitude,
    accuracyMeters: p.accuracy,
    altitudeMeters: p.altitude,
    speedMps: p.speed < 0 ? null : p.speed,
  );
}
