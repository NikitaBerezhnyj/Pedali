import 'package:flutter_map/flutter_map.dart';
import 'package:http/io_client.dart';

final mapTileProvider = NetworkTileProvider(
  httpClient: IOClient(),
  cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(
    maxCacheSize: 500 * 1024 * 1024,
  ),
);
