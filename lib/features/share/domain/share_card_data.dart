import 'package:latlong2/latlong.dart';

class ShareCardData {
  const ShareCardData({
    required this.segments,
    required this.distance,
    required this.movingTime,
    required this.avgSpeed,
    required this.maxSpeed,
    required this.date,
  });

  final List<List<LatLng>> segments;
  final String distance;
  final String movingTime;
  final String avgSpeed;
  final String maxSpeed;
  final String date;
}
