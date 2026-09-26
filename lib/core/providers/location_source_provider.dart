import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/location/geolocator_location_source.dart';
import 'package:pedali/core/location/location_source.dart';

final locationSourceProvider = Provider<LocationSource>(
  (ref) => GeolocatorLocationSource(),
);
