import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/recording/data/geolocator_location_source.dart';
import 'package:pedali/features/recording/domain/location_source.dart';

final locationSourceProvider = Provider<LocationSource>(
  (ref) => GeolocatorLocationSource(),
);
