import 'package:flutter_map/flutter_map.dart';

final mapTileProvider = NetworkTileProvider(
  cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(
    maxCacheSize: 500 * 1024 * 1024,
  ),
);
